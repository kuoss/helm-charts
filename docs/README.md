
| Component     | Role       | 🖼️ |
| ------------- | ---------- | -- |
| Prometheus    | Metric DB  | 🔥 |
| Lethe         | Log DB     | 🌊 |
| Venti         | Visualizer | 💨 |




![Venti Stack](./k8s-venti-stack.svg)



```mermaid
graph TD
    Venti("💨venti") --- Prometheus("🔥prometheus") --- NodeExporter("node-exporter")
    Prometheus --- KubeStateMetrics("kube-state-metrics")
    Venti --- Lethe("🌊lethe") --- FluentBit("fluent-bit") --- Eventrouter("eventrouter")

    classDef visual fill:#7b7;
    classDef metric fill:#b96;
    classDef log fill:#69b;
    class Venti visual
    class Prometheus,NodeExporter,KubeStateMetrics metric
    class Lethe,FluentBit,Eventrouter log
```
