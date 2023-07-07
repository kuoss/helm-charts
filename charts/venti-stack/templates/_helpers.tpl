{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
This is suffixed with -alertmanager, which means subtract 13 from longest 63 available
*/}}
{{- define "venti-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "venti-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create labels for venti-stack
*/}}
{{- define "venti-stack.matchLabels" -}}
app.kubernetes.io/name: {{ include "venti-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create unified labels for venti-stack components
*/}}
{{- define "venti-stack.metaLabels" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ include "venti-stack.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "venti-stack.name" . }}
{{- end -}}

{{- define "eventrouter.labels" -}}
{{ include "eventrouter.matchLabels" . }}
{{ include "venti-stack.metaLabels" . }}
{{- end -}}
{{- define "eventrouter.matchLabels" -}}
app.kubernetes.io/component: eventrouter
{{ include "venti-stack.matchLabels" . }}
{{- end -}}

{{- define "lethe.labels" -}}
{{ include "lethe.matchLabels" . }}
{{ include "venti-stack.metaLabels" . }}
{{- end -}}
{{- define "lethe.matchLabels" -}}
app.kubernetes.io/component: lethe
{{ include "venti-stack.matchLabels" . }}
{{- end -}}

{{- define "venti.labels" -}}
{{ include "venti.matchLabels" . }}
{{ include "venti-stack.metaLabels" . }}
{{- end -}}
{{- define "venti.matchLabels" -}}
app.kubernetes.io/component: venti
{{ include "venti-stack.matchLabels" . }}
{{- end -}}

{{/* venti-stack full name */}}
{{- define "venti-stack.fullname" -}}
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
{{- define "venti-stack.eventrouter.fullname" -}}
{{- printf "%s-eventrouter" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* lethe full name */}}
{{- define "venti-stack.lethe.fullname" -}}
{{- printf "%s-lethe" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* venti full name */}}
{{- define "venti-stack.venti.fullname" -}}
{{- printf "%s-venti" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "venti-stack.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

