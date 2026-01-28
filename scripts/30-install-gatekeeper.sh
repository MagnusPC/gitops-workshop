#!/usr/bin/env bash
set -euo pipefail

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts >/dev/null
helm repo update >/dev/null

kubectl create namespace gatekeeper-system --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install gatekeeper gatekeeper/gatekeeper \
  -n gatekeeper-system \
  --wait

echo "✅ Gatekeeper installed"
