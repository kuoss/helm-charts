# ingress-annotator

The `ingress-annotator` Helm chart is a Kubernetes utility that automates the management of annotations across Ingress resources. By leveraging a ConfigMap-driven approach, it ensures consistent, dynamic, and conflict-free annotation application.

## Prerequisites

- Kubernetes 1.19+
- Helm 3+

### Add Helm Repository

```console
helm repo add kuoss https://kuoss.github.io/helm-charts
helm repo update
```

### Install Chart

```bash
helm install [RELEASE_NAME] kuoss/ingress-annotator
```

The command deploys `ingress-annotator` on the Kubernetes cluster using the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstallation

```bash
helm uninstall [RELEASE_NAME]
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following values can be customized in your `values.yaml` or via `--set` CLI options:

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


## Defining Rules

You can define rules via `values.yaml`.

```yaml
rules:
- description: enforce-https
  selector:
    include: "*"
  annotations:
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
```


## Rule Examples

### IP Whitelisting for a Namespace

```yaml
- description: allow-specific-ips
  selector:
    include: "dev"
  annotations:
    nginx.ingress.kubernetes.io/whitelist-source-range: "68.204.79.0/27,68.204.135.80/28,246.91.35.0/24"
```

Alternatively, using a list format:

> [!NOTE]
> `listAnnotations` allows defining annotations in a structured list format, making it easier to manage multiple values and add descriptive comments.

```yaml
- description: allow-specific-ips
  selector:
    include: "dev"
  listAnnotations: # Ensure listAnnotations not annotations
    nginx.ingress.kubernetes.io/whitelist-source-range:
      - 68.204.79.0/27   # Dev Site 1
      - 68.204.135.80/28 # Dev Site 2
      - 246.91.35.0/24   # Testers
```

### Authentication (OAuth2)
```yaml
- description: ns1-oauth
  selector:
    include: "ns1"
  annotations:
    nginx.ingress.kubernetes.io/auth-signin: "https://oauth.example.com/oauth2/start?rd=https://$host$request_uri"
    nginx.ingress.kubernetes.io/auth-url: "https://oauth.example.com/oauth2/auth"
```

### Basic Authentication for Internal Services
```yaml
- description: enforce-basic-auth
  selector:
    include: "internal/*"
  annotations:
    nginx.ingress.kubernetes.io/auth-type: "basic"
    nginx.ingress.kubernetes.io/auth-secret: "internal/basic-auth"
```

### Rate Limiting for High-Traffic Endpoints
```yaml
- description: rate-limit-api
  selector:
    include: "api/throttle-*"
  annotations:
    nginx.ingress.kubernetes.io/limit-rate: "10" # Limits requests to 10 per second
```

### Enforcing HTTPS Redirects
```yaml
- description: enforce-https
  selector:
    include: "*"
  annotations:
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true" # Forces HTTP to HTTPS redirect
    nginx.ingress.kubernetes.io/ssl-redirect: "true" # Ensures HTTPS enforcement
```


## Selector Format

Selectors allow flexible matching using `include` and `exclude` fields, following the format: `namespace/ingress-name`.
These fields support:
- Multiple values as a comma-separated string (`include: "dev,prod"`).
- Wildcards (`*`) for broader matches (`include: "*"` applies to all namespaces and Ingress resources).
- Explicit namespace-only selection (`include: "dev"` selects all Ingress resources in the `dev` namespace).
- Explicit Ingress name selection (`include: "prod/hello-world"` selects only `hello-world` in the `prod` namespace).

### Include Rules
```yaml
include: "*"  # Applies to all Ingress resources
include: "dev"  # Applies to all Ingress resources in the 'dev' namespace
include: "prod/*"  # Applies to all Ingress resources in the 'prod' namespace
include: "dev,prod"  # Applies to both 'dev' and 'prod' namespaces
include: "prod/hello-*"  # Matches Ingress resources in 'prod' starting with 'hello-'
```

### Exclude Rules
```yaml
exclude: "prod/ingress1"  # Excludes 'ingress1' in 'prod'
exclude: "prod-*"  # Excludes all namespaces starting with 'prod-'
```
