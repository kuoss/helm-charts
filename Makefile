

test_deploy:
	hack/test_deploy.sh

dependency:
	cd charts/logmon; helm dependency update; helm dependency build

template:
	helm template -n logmon logmon charts/logmon/ -f charts/logmon/values.yaml -f docs/values.test.yaml

images:
	helm template -n logmon logmon charts/logmon/ -f charts/logmon/values.yaml -f docs/values.test.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq
