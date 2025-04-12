
test_deploy:
	hack/test_deploy.sh

dependency:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo add fluent https://fluent.github.io/helm-charts
	cd charts/lethe-stack; helm dependency update; helm dependency build
	cd charts/venti-stack; helm dependency update; helm dependency build

template:
	helm template -n venti-stack vs charts/venti-stack/ -f charts/venti-stack/values.yaml

images:
	helm template -n venti-stack vs charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/venti-stack.values.test.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq

__names:
	make template | egrep '^kind:|^  name:'

alertrules:
	cd hack; ./alertrules.py

lint: dependency
	helm lint charts/lethe-stack
	helm lint charts/venti-stack

checks: lint
	sh hack/checks.sh
