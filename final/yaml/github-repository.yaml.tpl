apiVersion: v1
kind: Secret
metadata:
  name: yamltoinfra
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: https://github.com/alexzhu214/gitops-zuoye.git
  password: "${github_personal_token}" 
  username: "#{github_username}"
  insecure: "true"
  forceHttpBasicAuth: "true"
  enableLfs: "true"