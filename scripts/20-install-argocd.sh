#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for ArgoCD server..."
kubectl -n argocd rollout status deploy/argocd-server --timeout=180s

# Expose ArgoCD (NodePort for kind)
kubectl -n argocd patch svc argocd-server -p '{
  "spec": { "type": "NodePort", "ports": [{"name":"http","port":80,"targetPort":8080,"nodePort":30080}] }
}'

# Print initial admin password
PASS="$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
echo "✅ ArgoCD URL: http://localhost:30080"
echo "✅ ArgoCD login: admin"
echo "✅ ArgoCD password: $PASS"
