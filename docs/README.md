
| Component     | Role       | 🖼️ |
| ------------- | ---------- | -- |
| Prometheus    | Metric DB  | 🔥 |
| Lethe         | Log DB     | 🌊 |
| Venti         | Visualizer | 💨 |




![Venti Stack](./k8s-venti-stack.svg)



```mermaid
graph TD
    A("💨venti") --- B("🔥prometheus")
    A --- C("🌊lethe")
    B --- D("node-exporter")
    B --- E("kube-state-metrics")
    C --- F("fluent-bit")
    F --- G("eventrouter")
```
