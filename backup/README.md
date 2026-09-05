# DevSecOps Netflix Recovery Backup

This directory contains non-secret recovery information from the
Netflix DevSecOps EC2/Kubernetes environment.

## Recovery Guide

See:

RECOVERY.md

## Included

- Live Kubernetes Deployment
- Kubernetes Service
- Kubernetes HPA
- Argo CD Application
- Prometheus configuration
- Prometheus alert rules
- Alertmanager configuration
- Grafana configuration
- Grafana persistent volume configuration
- kube-prometheus-stack Helm values
- kube-prometheus-stack rendered manifest
- Kind cluster configuration
- Kubernetes cluster inventory
- Server/tool versions

## Intentionally NOT included

Secrets and credentials are never committed:

- `.env`
- TMDB API key
- Gmail SMTP App Password
- Kubernetes Secret values
- Jenkins passwords/tokens
- GitHub PAT
- AWS credentials
- SSH private key
- Terraform state

GitHub remains the source of truth for application code and GitOps
manifests.
