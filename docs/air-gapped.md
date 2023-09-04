# Installing in an air-gapped environment

## download chart file

click venti-stack-0.1.x.tgz on https://github.com/kuoss/helm-charts/releases

or

```
curl -LO https://github.com/kuoss/helm-charts/releases/download/venti-stack-0.1.x/venti-stack-0.1.x.tgz
```

## write values.yaml

```yaml
global:
  imageRepository: {{ IMAGE_REPOSITORY }}
fluent-bit:
  image:
    repository: {{ IMAGE_REPOSITORY }}/fluent-bit
prometheus:
  alertmanager:
    image:
      repository: {{ IMAGE_REPOSITORY }}/alertmanager
  configmapReload:
    prometheus:
      image:
        repository: {{ IMAGE_REPOSITORY }}/prometheus-config-reloader
  kube-state-metrics:
    image:
      repository: {{ IMAGE_REPOSITORY }}/kube-state-metrics
  prometheus-node-exporter:
    image:
      repository: {{ IMAGE_REPOSITORY }}/node-exporter
  server:
    extraFlags:
    - storage.tsdb.retention.size=70GB
    image:
      repository: {{ IMAGE_REPOSITORY }}/prometheus
    ingress:
      enabled: true
      hosts:
      - prometheus.{{ INGRESS_DOMAIN }}
    persistentVolume:
      size: 100Gi
    retention: 15d
lethe:
  persistentVolume:
    size: 500Gi
  retention:
    size: 350g
    time: 365d
venti:
  ingress:
    enabled: true
    hosts:
    - venti.{{ INGRESS_DOMAIN }}
```

## install the chart with helm

```
helm install venti-stack-0.1.12.tgz -f values.yaml
```

After installation, check the pod running status and connect to venti ingress.


## (optional) disable node-exporter
```yaml
prometheus:
  prometheus-node-exporter:
    enabled: false
```
