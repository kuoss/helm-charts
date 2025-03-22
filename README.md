# Kuoss Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kuoss)](https://artifacthub.io/packages/search?org=kuoss)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Release Charts](https://github.com/kuoss/helm-charts/actions/workflows/release.yaml/badge.svg?branch=main)
[![Releases downloads](https://img.shields.io/github/downloads/kuoss/helm-charts/total.svg)](https://github.com/kuoss/helm-charts/releases)

## Usage

You must have [Helm](https://helm.sh) installed to use these charts. Please refer to Helm's [documentation](https://helm.sh/docs/) for installation instructions.

Once Helm is installed and configured, add the Kuoss repository as follows:

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

You can then run `helm search repo kuoss` to see the charts.

## Charts

| Chart                                                                                           | Description                                                                                                           |
|-------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [ingress-annotator](https://github.com/kuoss/helm-charts/tree/main/charts/ingress-annotator)    | A Kubernetes utility to dynamically manage ingress annotations based on predefined rules set in a ConfigMap.          |
| [myip](https://github.com/kuoss/helm-charts/tree/main/charts/myip)                              | Deploys a simple "What's my IP" application that returns the IP address of the client making the request.              |
| [venti-stack](https://github.com/kuoss/helm-charts/tree/main/charts/venti-stack)                | Installs a comprehensive collection of Kubernetes manifests for logging, monitoring, and visualization in a cluster.   |

## Contributing

We'd love to have you contribute! The source code for all [Kuoss](https://kuoss.github.io) [Helm](https://helm.sh) charts is available on GitHub: <https://github.com/kuoss/helm-charts/>.

Please refer to our [contribution guidelines](https://github.com/kuoss/helm-charts/blob/main/CONTRIBUTING.md) for detailed instructions on how to get involved. Whether it's reporting a bug, submitting a feature request, or contributing code, we welcome all contributions.

## License

This project is licensed under the [Apache 2.0 License](https://github.com/kuoss/helm-charts/blob/main/LICENSE). This means you can freely use, modify, and distribute the code, provided that you include the original license and copyright notice in any copies or substantial portions of the software.

## Helm Charts Build Status

![Release Charts](https://github.com/kuoss/helm-charts/workflows/Release%20Charts/badge.svg?branch=main)
