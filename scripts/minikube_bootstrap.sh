#!/usr/bin/env bash
set -e

CLUSTER_NAME="ccx-minikube"
NAMESPACE="${1:-lab}"

echo "=== Starting Minikube cluster: $CLUSTER_NAME ==="
minikube start --profile="$CLUSTER_NAME"

echo "=== Setting kubectl context to Minikube ==="
kubectl config use-context minikube

echo "=== Creating namespace: $NAMESPACE (if not exists) ==="
kubectl get ns "$NAMESPACE" >/dev/null 2>&1 || \
  kubectl create namespace "$NAMESPACE"

echo "=== Deploying test pod in namespace $NAMESPACE ==="
kubectl run nginx-test \
  --image=nginx:stable-alpine \
  --restart=Never \
  --namespace="$NAMESPACE" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "=== Waiting for pod to be Ready ==="
kubectl wait pod/nginx-test \
  --namespace="$NAMESPACE" \
  --for=condition=Ready \
  --timeout=60s

echo "=== Pod status ==="
kubectl get pod -n "$NAMESPACE" -o wide

echo "✅ Minikube lab ready in namespace '$NAMESPACE'"
CLUSTER_IP=$(minikube ip --profile="$CLUSTER_NAME")
echo "🌍 Cluster IP: $CLUSTER_IP"
