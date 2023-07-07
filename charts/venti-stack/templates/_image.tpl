{{- define "eventrouter.imageRepository" -}}
{{- if .Values.global.imageRepository }}
{{- printf "%s" .Values.global.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "lethe.imageRepository" -}}
{{- if .Values.global.imageRepository }}
{{- printf "%s" .Values.global.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}

{{- define "venti.imageRepository" -}}
{{- if .Values.global.imageRepository }}
{{- printf "%s" .Values.global.imageRepository }}
{{- else }}
{{- printf "ghcr.io/kuoss" }}
{{- end }}
{{- end }}
