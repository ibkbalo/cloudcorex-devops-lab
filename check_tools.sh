#!/usr/bin/env bash

TOOLS=("git" "docker" "kubectl" "minikube" "kind" "terraform")

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "✅ $tool is installed"
  else
    echo "❌ $tool is NOT installed"
  fi
done
