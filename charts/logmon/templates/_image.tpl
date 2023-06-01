{{- define "eventRouter.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "fluentBit.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/fluent" }}
{{- end }}
{{- end }}

{{- define "kubeStateMetrics.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "registry.k8s.io/kube-state-metrics" }}
{{- end }}
{{- end }}

{{- define "nodeExporter.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "quay.io/prometheus" }}
{{- end }}
{{- end }}

{{- define "lethe.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "prometheus.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "quay.io/prometheus" }}
{{- end }}
{{- end }}

{{- define "venti.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}
