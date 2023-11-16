#!/bin/bash
cd $(dirname $0)

PREV=0.30.4
CURR=0.40.0

NAME=fluent-bit
REPO=https://fluent.github.io/helm-charts

rm -rf   tmp/
mkdir -p tmp/
cd       tmp/

mkdir -p $PREV/kustomize
cd       $PREV/kustomize
cat << EOF > kustomization.yaml
helmCharts:
- name: $NAME
  repo: $REPO
  version: $PREV
  releaseName: xxx
EOF
kubectl kustomize --enable-helm . -o ../
cd ../..

mkdir -p $CURR/kustomize
cd       $CURR/kustomize
cat << EOF > kustomization.yaml
helmCharts:
- name: $NAME
  repo: $REPO
  version: $CURR
  releaseName: xxx
EOF
kubectl kustomize --enable-helm . -o ../
cd ../..

rm -rf */kustomize
sed 's|helm.sh/chart: .*||g'             -i */*.yaml
sed 's|app.kubernetes.io/version: .*||g' -i */*.yaml
sed 's|checksum/config: .*||g'           -i */*.yaml
sed 's|checksum/luascripts: .*||g'       -i */*.yaml
sed '/^\s*$/d'                           -i */*.yaml

diff --color $PREV/ $CURR/

exit 0
