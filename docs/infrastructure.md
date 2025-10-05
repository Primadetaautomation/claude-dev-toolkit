# 🚀 Infrastructure & Deployment - Docker, CI/CD & Cloud

**Auto-loaded when:** deployen, publiceren, online zetten, Docker, container, Kubernetes, server opzetten

---

## Deployment Strategies

### Vercel (Recommended for Next.js)
**DEPLOY-1 (MUST)** Gebruik Vercel voor Next.js projecten
```bash
# Installatie
npm i -g vercel

# Deploy
vercel

# Production deploy
vercel --prod
```

**VERCEL-1 (MUST)** Environment variables in dashboard
**VERCEL-2 (MUST)** Automatic deployments bij git push
**VERCEL-3 (SHOULD)** Preview deployments voor branches
**VERCEL-4 (MUST)** Custom domains configureren

### Railway (Backend Services)
```bash
# Installatie
npm i -g @railway/cli

# Login
railway login

# Deploy
railway up

# Logs bekijken
railway logs
```

**RAILWAY-1 (MUST)** Database + backend in zelfde project
**RAILWAY-2 (MUST)** Environment variables via dashboard
**RAILWAY-3 (SHOULD)** Health checks configureren

---

## Docker Basics

### Dockerfile Voorbeeld
```dockerfile
# Node.js applicatie
FROM node:20-alpine

WORKDIR /app

# Dependencies installeren
COPY package*.json ./
RUN npm ci --only=production

# Code kopiëren
COPY . .

# Build (indien nodig)
RUN npm run build

# Poort exposen
EXPOSE 3000

# Start command
CMD ["npm", "start"]
```

### Docker Compose
```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - NODE_ENV=production
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

**DOCKER-1 (MUST)** Multi-stage builds voor kleinere images
**DOCKER-2 (MUST)** .dockerignore file (node_modules, .git)
**DOCKER-3 (MUST)** Health checks in Dockerfile
**DOCKER-4 (SHOULD)** Non-root user voor security

---

## Environment Variables

### .env File Management
```bash
# .env.example (commit to git)
DATABASE_URL=
JWT_SECRET=
API_KEY=
NODE_ENV=development

# .env.local (NEVER commit)
DATABASE_URL=postgresql://...
JWT_SECRET=actual-secret-key
API_KEY=actual-api-key
```

**ENV-1 (MUST)** Secrets NOOIT in git
**ENV-2 (MUST)** .env.example altijd up-to-date
**ENV-3 (MUST)** Different secrets per environment (dev/staging/prod)
**ENV-4 (SHOULD)** Gebruik secret management (Vercel/Railway/AWS Secrets Manager)

---

## CI/CD Pipelines

### GitHub Actions Voorbeeld
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Run linter
        run: npm run lint

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

**CI-1 (MUST)** Tests draaien vóór deploy
**CI-2 (MUST)** Linting en type checking
**CI-3 (MUST)** Security scanning (npm audit)
**CI-4 (SHOULD)** Automatic deployments alleen voor main/production

---

## Database Migrations

### Prisma Migrations
```bash
# Development
npx prisma migrate dev --name add_users_table

# Production
npx prisma migrate deploy
```

**MIG-1 (MUST)** Test migrations in staging eerst
**MIG-2 (MUST)** Backup database vóór production migration
**MIG-3 (MUST)** Rollback plan gereed
**MIG-4 (SHOULD)** Migrations in CI/CD pipeline

### Migration Workflow
1. **Development**: Maak migration + test lokaal
2. **Staging**: Deploy + valideer
3. **Production**:
   - Maintenance mode (indien nodig)
   - Backup database
   - Run migration
   - Verify + monitor
   - Exit maintenance mode

---

## Monitoring & Logging

### Health Checks
```javascript
// Express health check endpoint
app.get('/health', async (req, res) => {
  const health = {
    uptime: process.uptime(),
    timestamp: Date.now(),
    status: 'OK',
    checks: {
      database: await checkDatabaseConnection(),
      redis: await checkRedisConnection()
    }
  };

  const httpCode = health.checks.database && health.checks.redis ? 200 : 503;
  res.status(httpCode).json(health);
});
```

**HEALTH-1 (MUST)** /health endpoint voor monitoring
**HEALTH-2 (SHOULD)** Check kritieke dependencies (DB, Redis, APIs)
**HEALTH-3 (MUST)** Return 503 als unhealthy

### Logging Services
```javascript
// Winston logger setup
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

// Production: gebruik service zoals Logtail, Datadog
if (process.env.NODE_ENV === 'production') {
  logger.add(new winston.transports.Http({
    host: 'logs.example.com',
    port: 443,
    path: '/log'
  }));
}
```

**LOG-1 (MUST)** Structured logging (JSON)
**LOG-2 (SHOULD)** Log aggregation service (Logtail, Datadog, CloudWatch)
**LOG-3 (MUST)** Error tracking (Sentry)
**LOG-4 (MUST)** Performance monitoring (Vercel Analytics, New Relic)

---

## Scaling & Performance

### Horizontal Scaling
**SCALE-1 (SHOULD)** Stateless applicaties (session in DB/Redis)
**SCALE-2 (SHOULD)** Load balancer (Railway/Vercel automatic)
**SCALE-3 (MUST)** Database connection pooling
**SCALE-4 (SHOULD)** Caching layer (Redis, CDN)

### Vertical Scaling
**VERT-1 (SHOULD)** Monitor resource usage
**VERT-2 (MUST)** Set memory limits (Docker, Railway)
**VERT-3 (SHOULD)** Auto-scaling policies

### CDN & Static Assets
```javascript
// Next.js automatic optimization
export default {
  images: {
    domains: ['cdn.example.com'],
    formats: ['image/avif', 'image/webp']
  }
}
```

**CDN-1 (MUST)** Static assets via CDN (Vercel automatic)
**CDN-2 (SHOULD)** Image optimization (Next.js Image component)
**CDN-3 (MUST)** Cache headers correct instellen

---

## Backup & Recovery

### Database Backups
```bash
# PostgreSQL backup
pg_dump -U username -d database_name > backup.sql

# Restore
psql -U username -d database_name < backup.sql
```

**BACKUP-1 (MUST)** Automated daily backups
**BACKUP-2 (MUST)** Test restore procedures maandelijks
**BACKUP-3 (SHOULD)** Backup retention policy (30 days)
**BACKUP-4 (MUST)** Off-site backup storage

### Disaster Recovery Plan
1. **RTO (Recovery Time Objective)**: Max downtime acceptabel
2. **RPO (Recovery Point Objective)**: Max dataverlies acceptabel
3. **Backup locaties**: Primary + secondary regions
4. **Runbook**: Documented recovery steps

---

## Security Best Practices

### SSL/TLS
**SSL-1 (MUST)** HTTPS everywhere (Vercel/Railway automatic)
**SSL-2 (MUST)** TLS 1.2+ minimum
**SSL-3 (SHOULD)** Auto-renewing certificates (Let's Encrypt)

### Firewall & Network
**NET-1 (SHOULD)** Database niet publiekelijk accessible
**NET-2 (MUST)** VPC/Private network voor backend services
**NET-3 (MUST)** IP whitelisting waar mogelijk
**NET-4 (SHOULD)** DDoS protection (Cloudflare, Vercel)

### Secrets Management
**SEC-1 (MUST)** Environment variables voor alle secrets
**SEC-2 (SHOULD)** Secret rotation policy
**SEC-3 (MUST)** Least privilege access (IAM roles)
**SEC-4 (MUST)** Audit logs voor secret access

---

## Cost Optimization

### Resource Monitoring
**COST-1 (SHOULD)** Set budget alerts
**COST-2 (MUST)** Monitor usage dashboards
**COST-3 (SHOULD)** Optimize database queries (reduce CPU)
**COST-4 (SHOULD)** Clean up unused resources

### Tier Planning
```
Free Tier:
- Vercel: 100GB bandwidth/month
- Railway: $5 gratis credits
- Supabase: 500MB database

Pro Tier:
- Vercel: €20/maand (1TB bandwidth)
- Railway: Pay-as-you-go ($0.50/GB RAM)
- Supabase: €25/maand (8GB database)
```

---

## Deployment Checklist

**Pre-Deploy:**
- [ ] All tests passing
- [ ] Linting clean
- [ ] Security audit (npm audit)
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] Backup created

**Deploy:**
- [ ] Deploy to staging first
- [ ] Run smoke tests
- [ ] Monitor error rates
- [ ] Check performance metrics

**Post-Deploy:**
- [ ] Verify health checks
- [ ] Monitor logs (eerste 30 min)
- [ ] Check user-facing features
- [ ] Update documentation

**Rollback Plan:**
- [ ] Previous version accessible
- [ ] Rollback procedure documented
- [ ] Database rollback tested

---

## Quick Start Commands

```bash
# Vercel Deploy
vercel --prod

# Railway Deploy
railway up

# Docker Build & Run
docker build -t myapp .
docker run -p 3000:3000 myapp

# Database Migration
npx prisma migrate deploy

# Health Check
curl https://myapp.com/health

# Logs
railway logs
vercel logs
```

---

*Auto-loaded bij: deployen, online zetten, publiceren, Docker, Kubernetes, server opzetten*
