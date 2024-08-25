# ingress-annotator

The `ingress-annotator` Helm chart is a Kubernetes utility designed to dynamically manage ingress annotations based on predefined rules set in a ConfigMap. This chart deploys the `ingress-annotator` application, which monitors and updates ingress resources with specified annotations to enforce various configurations like OAuth2 proxy integration, IP whitelisting, and more.

## Prerequisites

- Kubernetes 1.19+
- Helm 3+

## Get Repository Info

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

## Install Chart

```bash
helm install [RELEASE_NAME] kuoss/ingress-annotator
```

The command deploys `ingress-annotator` on the Kubernetes cluster using the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstall Chart

```bash
helm uninstall [RELEASE_NAME]
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `ingress-annotator` chart and their default values.

| Parameter                                  | Description                                                                                  | Default                      |
|--------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------|
| `replicaCount`                             | Number of replicas for the deployment                                                        | `1`                          |
| `image.repository`                         | Container image repository                                                                   | `ghcr.io/kuoss/ingress-annotator` |
| `image.pullPolicy`                         | Image pull policy                                                                            | `IfNotPresent`               |
| `image.tag`                                | Overrides the image tag whose default is the chart appVersion                                | `""`                         |
| `imagePullSecrets`                         | Secrets for image pull                                                                       | `[]`                         |
| `nameOverride`                             | Override the name of the chart                                                               | `""`                         |
| `fullnameOverride`                         | Override the full name of the chart                                                          | `""`                         |
| `serviceAccount.create`                    | Specifies whether a service account should be created                                        | `true`                       |
| `serviceAccount.annotations`               | Annotations to add to the service account                                                    | `{}`                         |
| `serviceAccount.name`                      | The name of the service account to use                                                       | `""`                         |
| `podAnnotations`                           | Additional annotations for the pod                                                           | `{}`                         |
| `podSecurityContext`                       | Security context for the pod                                                                 | `{}`                         |
| `metrics.service.type`                     | Service type for the metrics endpoint                                                        | `ClusterIP`                  |
| `metrics.service.port`                     | Port for the metrics service                                                                 | `8081`                       |
| `resources`                                | Resource requests and limits                                                                 | `{}`                         |
| `autoscaling.enabled`                      | Enable autoscaling                                                                           | `false`                      |
| `autoscaling.minReplicas`                  | Minimum number of replicas                                                                   | `1`                          |
| `autoscaling.maxReplicas`                  | Maximum number of replicas                                                                   | `100`                        |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage                                                            | `80`                         |
| `nodeSelector`                             | Node selector for scheduling                                                                 | `{}`                         |
| `tolerations`                              | Tolerations for pod assignment                                                               | `[]`                         |
| `affinity`                                 | Affinity rules for pod assignment                                                            | `{}`                         |
| `rules`                                    | Configuration rules for managing ingress annotations                                         | `{}`                         |

### Example Rule Configurations

#### OAuth2 Proxy Configuration

To configure the ingress for OAuth2 proxy:

```yaml
rules:
  oauth2-proxy:
    nginx.ingress.kubernetes.io/auth-signin: "https://oauth2-proxy.example.com/oauth2/start?rd=https://$host$request_uri"
    nginx.ingress.kubernetes.io/auth-url: "https://oauth2-proxy.example.com/oauth2/auth"
```

#### Private Ingress Configuration

To enforce IP whitelist on specific ingresses:

```yaml
rules:
  private:
    nginx.ingress.kubernetes.io/whitelist-source-range: "192.168.1.0/24,10.0.0.0/16"
```

## Custom Values

Override the default values by specifying them in a `values.yaml` file:

```bash
helm install [RELEASE_NAME] ingress-annotator -f values.yaml
```

Alternatively, specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.
