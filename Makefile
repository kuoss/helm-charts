install:
	helm uninstall -n logmon logmon; helm install -n logmon logmon charts/logmon/ -f charts/logmon/values.yaml -f docs/values.test.yaml

template:
	helm template -n logmon logmon charts/logmon/ -f charts/logmon/values.yaml -f docs/values.test.yaml


# Error: INSTALLATION FAILED: Deployment.apps "logmon-venti" is invalid: spec.template.metadata.labels:
# Invalid value: map[string]string{
# "app.kubernetes.io/instance":"logmon",
# "app.kubernetes.io/managed-by":"Helm",
# "app.kubernetes.io/name":"logmon",
# "app.kubernetes.io/part-of":"logmon",
# "app.kubernetes.io/version":"v0.2.1",
# "helm.sh/chart":"logmon-0.1.0"}: `selector` does not match template `labels`
# make: *** [Makefile:2: install] Error 1