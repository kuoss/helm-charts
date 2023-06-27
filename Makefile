
test_deploy:
	hack/test_deploy.sh

dependency:
	cd charts/venti-stack; helm dependency update; helm dependency build

template:
	helm template -n venti-stack venti-stack charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.test.yaml

images:
	helm template -n venti-stack venti-stack charts/venti-stack/ | grep -oP image:.* | sed 's/"//g' | sort | uniq

images1:
	helm template -n venti-stack venti-stack charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.images1.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq

images2:
	helm template -n venti-stack venti-stack charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.images2.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq
