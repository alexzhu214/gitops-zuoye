#!/bin/bash  

# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# install ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace --wait --version "4.7.2"

# install jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# create ns
kubectl create ns jenkins

# service account for kubernetes secret provider
kubectl apply -f /tmp/jenkins-service-account.yaml -n jenkins



# harbor url secret
#kubectl apply -f /tmp/harbor-url-secret.yaml -n jenkins

# jenkins github personal access token
kubectl apply -f /tmp/github-personal-token.yaml -n jenkins

# jenkins github server(system) pat secret
kubectl apply -f /tmp/github-pat-secret-text.yaml -n jenkins

# install jenkins helm
helm upgrade -i jenkins jenkins/jenkins -n jenkins --create-namespace -f /tmp/jenkins-values.yaml --version "4.6.1"
# install argocd helm
helm upgrade --install -n argocd argocd argo/argo-cd --version "5.36.6" -f /tmp/argocd-values.yaml --create-namespace

# install sonarqube
#helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
#helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --create-namespace --version 10.1.0+628 -f /tmp/sonar-values.yaml

# apply tekton ingress
#kubectl create ns tekton-pipelines
#kubectl apply -f /tmp/tekton-dashboard-ingress.yaml

# apply tekton listener ingress for github webhook
#kubectl apply -f /tmp/tekton-listener-ingress.yaml

# tekton git repository secret for clone private repo(default namespace)
#kubectl apply -f /tmp/tekton-git-repositry-secret.yaml


#kubectl create secret generic docker-credentials --from-file=config.json=/tmp/docker-credentials.json --dry-run=client -o yaml | kubectl apply -f -

# install crossplane 
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm upgrade -i crossplane \
--namespace crossplane-system \
--create-namespace crossplane-stable/crossplane \
--version "1.14.0" \
--wait

kubectl apply -f /tmp/tf-provider.yaml -n crossplane-system

kubectl apply -f /tmp/providerConfig.yaml -n crossplane-system

kubectl apply -f /tmp/argocd-applicationset.yaml -n argocd