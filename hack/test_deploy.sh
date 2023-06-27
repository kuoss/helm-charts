#!/bin/bash
cd $(dirname $0)/../
set -x
helm upgrade --install -n venti-stack venti-stack charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.test.yaml
kubectl -n venti-stack delete $(kubectl get pod -n venti-stack -oname | grep venti)
