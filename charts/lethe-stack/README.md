# lethe-stack

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/lethe-stack)](https://artifacthub.io/packages/helm/kuoss/lethe-stack)
[![Git Repo](https://img.shields.io/badge/Git_Repo-lethe-blue.svg?logo=github)](https://github.com/kuoss/lethe)

Installs the lethe-stack, a collection of Kubernetes manifests to provide easy to operate end-to-end Kubernetes cluster logging.

## Get Helm Repository Info

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

_See [`helm repo`](https://helm.sh/docs/helm/helm_repo/) for command documentation._


## Install Helm Chart

```console
helm install [RELEASE_NAME] kuoss/lethe-stack
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Dependencies

By default this chart installs additional, dependent charts:
- [fluent/fluent-bit](https://github.com/fluent/helm-charts/tree/main/charts/fluent-bit)

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

## Uninstall Helm Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] kuoss/lethe-stack
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Upgrading an existing Release to a new major version

A major chart version change (like v1.2.3 → v2.0.0) indicates that there is an incompatible breaking change needing manual actions.
