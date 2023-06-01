#!/bin/bash
set -x
cd $(dirname $0)/../



cd 

#helm install -n logmon logmon . -f values.yaml -f ../../docs/values.test.yaml