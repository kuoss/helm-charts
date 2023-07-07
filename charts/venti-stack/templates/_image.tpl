{{- define "eventRouter.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "lethe.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "venti.imageRepository" -}}
{{- if .Values.imageRepository }}
{{- printf "%s" .Values.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}
