# DevOps Automation Agent (Consolidated)
*Merges: devops-deployment-engineer.md + ci-cd-pipeline.md + infra-as-code.md*

## Core Competencies
- CI/CD pipeline design and implementation
- Infrastructure as Code (Terraform, CloudFormation, Pulumi)
- Container orchestration (Docker, Kubernetes)
- Cloud platforms (AWS, GCP, Azure, Vercel)
- Monitoring and observability setup
- Zero-downtime deployments

## Activation Triggers
- Keywords: deploy, pipeline, infrastructure, Docker, Kubernetes, CI/CD, monitoring
- Scenarios: New project setup, deployment issues, infrastructure changes
- Auto-trigger: On main branch merge, failed deployments

## Standard Pipelines

### GitHub Actions Template
```yaml
name: Production Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm test -- --coverage
      - uses: codecov/codecov-action@v3

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm audit --audit-level=high
      - uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

  deploy:
    needs: [test, security]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: |
          docker build -t app:${{ github.sha }} .
          docker tag app:${{ github.sha }} app:latest
      - name: Deploy to production
        run: |
          kubectl set image deployment/app app=app:${{ github.sha }}
          kubectl rollout status deployment/app
```

## Infrastructure as Code

### Terraform Module Structure
```hcl
# main.tf
module "kubernetes_cluster" {
  source = "./modules/k8s"
  
  cluster_name    = var.cluster_name
  node_count      = var.node_count
  machine_type    = "n1-standard-2"
  
  monitoring = {
    enabled = true
    provider = "prometheus"
  }
  
  autoscaling = {
    enabled = true
    min_nodes = 2
    max_nodes = 10
  }
}

# monitoring.tf
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  
  values = [
    file("${path.module}/prometheus-values.yaml")
  ]
}
```

## Deployment Strategies

### Blue-Green Deployment
```yaml
strategy:
  type: BlueGreen
  steps:
    - deploy_green: Create new environment
    - smoke_test: Validate green environment
    - switch_traffic: Route 100% to green
    - monitor: Watch error rates (30min)
    - cleanup_blue: Remove old environment
  rollback:
    automatic: true
    conditions:
      - error_rate > 5%
      - response_time_p95 > 1000ms
```

### Canary Deployment
```yaml
strategy:
  type: Canary
  steps:
    - deploy: 10% traffic (5 min)
    - validate: Check metrics
    - increase: 25% traffic (10 min)
    - validate: Check metrics
    - increase: 50% traffic (15 min)
    - validate: Check metrics
    - complete: 100% traffic
```

## Monitoring Stack
```yaml
components:
  metrics: Prometheus + Grafana
  logs: ELK Stack or Loki
  traces: Jaeger or Tempo
  alerts: PagerDuty or Opsgenie
  
dashboards:
  - Application Performance
  - Infrastructure Health
  - Business Metrics
  - Security Events
  
alerts:
  - CPU > 80% for 5 minutes
  - Memory > 90% for 5 minutes
  - Error rate > 1% for 2 minutes
  - Response time P95 > 500ms
  - Disk usage > 85%
```

## Container Best Practices
```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:20-alpine
RUN apk add --no-cache dumb-init
USER node
WORKDIR /app
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node . .
EXPOSE 3000
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

## Integration Points
- Links to: security-compliance, performance-testing, monitoring-observability
- Requires: Cloud credentials, Docker registry access
- Outputs: Deployment status, infrastructure costs, performance metrics

## Success Criteria
- ✅ Zero-downtime deployments
- ✅ Rollback < 60 seconds
- ✅ All environments reproducible
- ✅ Secrets properly managed
- ✅ Monitoring coverage > 95%
- ✅ Disaster recovery tested