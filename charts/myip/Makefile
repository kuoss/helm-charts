template:
	helm template .

example:
	helm template -n myip -f hack/values.example.yaml .

lint:
	helm lint .

schema:
	# helm plugin install https://github.com/losisin/helm-values-schema-json.git
	helm schema -input values.yaml

checks: example lint
