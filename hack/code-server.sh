#!/bin/bash
cd $(dirname $0)
rm -rf tmp
mkdir  tmp
cd     tmp
git clone --depth=1 https://github.com/coder/code-server.git

cd ../../
rm -rf charts/code-server
mv hack/tmp/code-server/ci/helm-chart charts/code-server

cat <<EOF >> charts/code-server/Chart.yaml
home: https://kuoss.github.io/helm-charts
sources:
  - https://github.com/coder/code-server
keywords:
  - code-server
annotations:
  "artifacthub.io/license": MIT
  "artifacthub.io/links": |
    - name: Chart Source
      url: https://github.com/kuoss/helm-charts
EOF
