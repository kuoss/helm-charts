#!/bin/bash

cd $(dirname $0)
rm -rf   _rendered
mkdir -p _rendered

helm template . > _rendered/rendered.yaml

echo Rendering complete.
echo Enter the following commands to apply rendered yamls:
echo
echo kubectl apply -f _rendered/rendered.yaml
echo 'kubectl -n kube-system delete $(kubectl get pod -n kube-system -oname | grep venti)'
echo
