{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bitwarden.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bitwarden.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Generate config hash to checksum for automatic restart
*/}}
{{- define "bitwarden.config-hash" -}}
{{- $config := print (toJson .Values.bitwarden) "-" (toJson .Values.storage) -}}
{{- $database := print (toJson .Values.database) -}}
{{- $smtp := print (toJson .Values.smtp) -}}
{{- print $config "-" $database "-" $smtp -}}
{{- end -}}

{{/*
Define default ingress annotations if are not provided
*/}}
{{- define "bitwarden.ingress.annotations" -}}
{{- if .Values.ingress.annotations -}}
{{- toYaml .Values.ingress.annotations }}
{{- else -}}
kubernetes.io/ingress.class: nginx
{{- if .Values.ingress.tls }}
kubernetes.io/tls-acme: "true"
kubernetes.io/ssl-redirect: "true"
{{- end -}}
{{- end -}}
{{- end -}}
