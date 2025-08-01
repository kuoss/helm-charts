{{/* vim: set filetype=mustache: */}}
{{- define "lethe-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lethe-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create labels for lethe-stack
*/}}
{{- define "lethe-stack.matchLabels" -}}
app.kubernetes.io/name: {{ include "lethe-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create unified labels for lethe-stack components
*/}}
{{- define "lethe-stack.metaLabels" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ include "lethe-stack.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "lethe-stack.name" . }}
{{- end -}}

{{- define "eventrouter.labels" -}}
{{ include "eventrouter.matchLabels" . }}
{{ include "lethe-stack.metaLabels" . }}
{{- end -}}
{{- define "eventrouter.matchLabels" -}}
app.kubernetes.io/component: eventrouter
{{ include "lethe-stack.matchLabels" . }}
{{- end -}}

{{- define "lethe.labels" -}}
{{ include "lethe.matchLabels" . }}
{{ include "lethe-stack.metaLabels" . }}
{{- end -}}
{{- define "lethe.matchLabels" -}}
app.kubernetes.io/component: lethe
{{ include "lethe-stack.matchLabels" . }}
{{- end -}}

{{/* lethe-stack full name */}}
{{- define "lethe-stack.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* eventrouter full name */}}
{{- define "eventrouter.fullname" -}}
{{- printf "%s-eventrouter" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* lethe full name */}}
{{- define "lethe.fullname" -}}
{{- printf "%s-lethe" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "lethe.serviceAccountName" -}}
{{- if .Values.lethe.serviceAccount.create }}
{{- default (include "lethe.fullname" .) .Values.lethe.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.lethe.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "lethe-stack.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}
