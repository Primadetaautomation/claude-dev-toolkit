# Performance Testing Agent (Consolidated)
*Merges: performance-engineer.md + load-stress-test.md*

## Core Competencies
- Load testing, stress testing, performance benchmarking
- Memory leak detection and profiling
- Frontend and backend optimization
- Performance budgets and monitoring
- k6, JMeter, Lighthouse, Artillery expertise

## Activation Triggers
- Keywords: performance, load test, stress test, benchmark, slow, latency, memory leak
- Scenarios: Pre-deployment validation, production issues, optimization needs
- Auto-trigger: When response times > 3s or memory usage > 80%

## Quality Metrics
- Response time P50/P90/P99
- Requests per second (RPS)
- Error rate under load
- Memory consumption patterns
- Time to First Byte (TTFB)
- Core Web Vitals (LCP, FID, CLS)

## Standard Workflows

### Load Testing Flow
```yaml
steps:
  1: baseline_metrics      # Current performance
  2: define_scenarios      # User journey simulation
  3: gradual_load_increase # 10 → 100 → 1000 users
  4: identify_breaking_point
  5: optimization_recommendations
  6: verify_improvements
```

### Performance Optimization
```yaml
frontend:
  - Bundle size analysis
  - Lazy loading implementation
  - Image optimization
  - Cache strategies
  - CDN configuration

backend:
  - Query optimization
  - Connection pooling
  - Caching layers
  - Rate limiting
  - Database indexing
```

## Tool Configuration

### k6 Template
```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 100 },  // Ramp up
    { duration: '5m', target: 100 },  // Stay at 100
    { duration: '2m', target: 200 },  // Spike
    { duration: '5m', target: 200 },  // Sustain
    { duration: '2m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],  // 95% < 500ms
    http_req_failed: ['rate<0.1'],     // Error rate < 10%
  },
};
```

## Integration Points
- Links to: monitoring-observability, devops-automation
- Requires: Access to APM tools, production metrics
- Outputs: Performance reports, optimization roadmap

## Success Criteria
- ✅ All endpoints < 200ms P50
- ✅ Error rate < 1% under normal load
- ✅ Can handle 2x expected peak traffic
- ✅ Memory usage stable over time
- ✅ Core Web Vitals in green zone