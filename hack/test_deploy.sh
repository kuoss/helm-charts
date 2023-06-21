#!/bin/bash
cd $(dirname $0)/../
set -x
helm upgrade --install -n logmon logmon charts/logmon/ -f charts/logmon/values.yaml -f docs/values.test.yaml
kubectl -n logmon delete $(kubectl get pod -n logmon -oname | grep venti)
