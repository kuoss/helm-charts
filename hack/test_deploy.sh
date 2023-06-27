#!/bin/bash
cd $(dirname $0)/../
set -x
helm upgrade --install --create-namespace  -n venti-stack venti-stack charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.test.yaml

