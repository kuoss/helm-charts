# Kuoss Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kuoss)](https://artifacthub.io/packages/search?org=kuoss)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Release Charts](https://github.com/kuoss/helm-charts/workflows/Release%20Charts/badge.svg?branch=main)
[![Releases downloads](https://img.shields.io/github/downloads/kuoss/helm-charts/total.svg)](https://github.com/kuoss/helm-charts/releases)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

You can then run `helm search repo kuoss` to see the charts.

## Charts

| Chart Name                                                                                      | Description                                                                                                           |
|-------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [ingress-annotator](https://github.com/kuoss/helm-charts/tree/main/charts/ingress-annotator)    | A Kubernetes utility to dynamically manage ingress annotations based on predefined rules set in a ConfigMap.          |
| [myip](https://github.com/kuoss/helm-charts/tree/main/charts/myip)                              | Deploys a simple "What's my IP" application that returns the IP address of the client making the request.              |
| [venti-stack](https://github.com/kuoss/helm-charts/tree/main/charts/venti-stack)                | Installs a comprehensive collection of Kubernetes manifests for logging, monitoring, and visualization in a cluster.   |

## Contributing

The source code of all [Kuoss](https://kuoss.github.io) [Helm](https://helm.sh) charts can be found on Github: <https://github.com/kuoss/helm-charts/>

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
We'd love to have you contribute! Please refer to our [contribution guidelines](https://github.com/kuoss/helm-charts/blob/main/CONTRIBUTING.md) for details.

## License

[Apache 2.0 License](https://github.com/kuoss/helm-charts/blob/main/LICENSE).

## Helm charts build status

![Release Charts](https://github.com/kuoss/helm-charts/workflows/Release%20Charts/badge.svg?branch=main)
