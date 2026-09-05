# Netflix DevSecOps Disaster Recovery Guide

## 1. Application Source

The application source code is stored in the GitHub repository:

Chetanbarfa23/DevSecOps-Project

Clone the repository and checkout the main branch.

## 2. AWS / EC2

The project currently runs on an Ubuntu EC2 instance in ap-south-1.

The EC2 instance hosts:

- Jenkins
- Docker
- Kind Kubernetes
- kubectl
- Helm
- Argo CD
- Prometheus
- Grafana
- Metrics Server

AWS resources should be recreated manually or through Terraform when
appropriate.

IMPORTANT:
AWS credentials and SSH private keys are intentionally NOT stored
in this repository.

## 3. Kubernetes

Kind configuration:

backup/server/kind/kind-config.yaml

Netflix Kubernetes configuration:

backup/server/kubernetes/

Important files:

- netflix-deployment-live.yaml
- netflix-service-live.yaml
- hpa-live.yaml

## 4. Argo CD

Argo CD Application:

backup/server/argocd/netflix-application-live.yaml

The application tracks the GitHub repository and Kubernetes directory.

## 5. Monitoring

Monitoring is installed using:

kube-prometheus-stack

Helm values:

backup/server/monitoring/kube-prometheus-stack-values.yaml

Rendered Helm manifest:

backup/server/monitoring/kube-prometheus-stack-manifest.yaml

Prometheus:

backup/server/monitoring/prometheus.yaml

Alert rules:

backup/server/monitoring/prometheusrules.yaml

Alertmanager:

backup/server/monitoring/alertmanager.yaml

Grafana persistent storage:

backup/server/monitoring/pvcs.yaml

## 6. Grafana Persistence

Grafana uses a persistent PVC named:

monitoring-grafana

Storage size:

2Gi

Storage class:

standard

The PVC is important because Grafana configuration such as dashboards,
alerts and contact points should survive Grafana pod recreation.

## 7. Secrets

The following are intentionally NOT stored in Git:

- TMDB API key
- Gmail SMTP App Password
- GitHub PAT
- Jenkins credentials
- Kubernetes Secret values
- AWS credentials
- SSH private key
- Terraform state

These must be recreated securely during disaster recovery.

## 8. Docker

Docker images are published to Docker Hub.

Current image repository:

chetan8889/netflix

Jenkins creates versioned images using:

build-${BUILD_NUMBER}

## 9. CI/CD

Pipeline:

GitHub
  ↓
Jenkins
  ↓
Node build
  ↓
SonarQube
  ↓
OWASP Dependency Check
  ↓
Docker build
  ↓
Trivy
  ↓
Docker Hub
  ↓
GitOps manifest update
  ↓
GitHub
  ↓
Argo CD
  ↓
Kubernetes

## 10. Monitoring Flow

Kubernetes
  ↓
Prometheus
  ↓
Grafana
  ↓
Alert Rule
  ↓
Notification Policy
  ↓
Email Contact Point
  ↓
Gmail SMTP
  ↓
Email Alert

## 11. Important Public Endpoints

Netflix:
http://EC2_PUBLIC_IP:30080

Jenkins:
http://EC2_PUBLIC_IP:8080

Argo CD:
https://EC2_PUBLIC_IP:30443

Grafana:
http://EC2_PUBLIC_IP:30300

Prometheus:
http://EC2_PUBLIC_IP:30091

NOTE:
Grafana and Prometheus currently use kubectl port-forwarding on the
EC2 host. These port-forwards may need to be recreated after a server
reboot.

## 12. Recovery Principle

GitHub is the source of truth for application code and GitOps manifests.

This backup contains additional live infrastructure and monitoring
configuration.

If the EC2 server is lost:

1. Create/recover the EC2 instance.
2. Install Docker.
3. Install kubectl.
4. Install Kind.
5. Install Helm.
6. Recreate the Kind cluster.
7. Install Argo CD.
8. Install kube-prometheus-stack.
9. Restore Kubernetes configuration.
10. Recreate required secrets securely.
11. Reconfigure Jenkins credentials.
12. Recreate port-forwards.
13. Verify Argo CD is Synced and Healthy.
14. Verify Grafana and Prometheus.
15. Verify email alerting.

