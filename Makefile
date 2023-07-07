
test_deploy:
	hack/test_deploy.sh

dependency:
	cd charts/venti-stack; helm dependency update; helm dependency build

template:
	helm template -n venti-stack vs charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.test.yaml

images:
	######## default ########
	helm template -n venti-stack vs charts/venti-stack/ | grep -oP image:.* | sed 's/"//g' | sort | uniq
	######## root ########
	helm template -n venti-stack vs charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.image.root.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq
	######## global ########
	helm template -n venti-stack vs charts/venti-stack/ -f charts/venti-stack/values.yaml -f docs/values.image.global.yaml | grep -oP image:.* | sed 's/"//g' | sort | uniq

__names:
	make template | egrep '^kind:|^  name:'
