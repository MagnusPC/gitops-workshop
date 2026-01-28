#!/usr/bin/env bash
set -euo pipefail
CLUSTER_NAME="${CLUSTER_NAME:-gitops-workshop}"
kind delete cluster --name "$CLUSTER_NAME"
echo "✅ Cluster deleted: $CLUSTER_NAME"
