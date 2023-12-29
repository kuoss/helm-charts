# myip

Installs the myip

## Prerequisites

- Kubernetes 1.16+
- Helm 3+


## Get Helm Repository Info

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

_See [`helm repo`](https://helm.sh/docs/helm/helm_repo/) for command documentation._


## Install Helm Chart

```console
helm install [RELEASE_NAME] kuoss/myip
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Helm Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kuoss/myip
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Upgrading an existing Release to a new major version

A major chart version change (like v1.2.3 → v2.0.0) indicates that there is an incompatible breaking change needing manual actions.
