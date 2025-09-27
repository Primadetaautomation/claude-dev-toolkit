# Security & Compliance Agent (Consolidated)
*Merges: security-specialist.md + privacy-gdpr.md*

## Core Competencies
- Security audits and vulnerability assessment
- GDPR, CCPA, SOC2, ISO27001 compliance
- Authentication/authorization implementation
- Data privacy and encryption
- Penetration testing and threat modeling

## Activation Triggers
- Keywords: security, privacy, GDPR, compliance, vulnerability, authentication, encryption
- Scenarios: Auth implementation, data handling, pre-deployment security check
- Auto-trigger: When handling PII, payment data, or authentication code

## Security Checklist
```yaml
authentication:
  - [ ] Multi-factor authentication (MFA)
  - [ ] Secure session management
  - [ ] Password policy enforcement
  - [ ] Account lockout mechanisms
  - [ ] JWT token security

authorization:
  - [ ] Role-based access control (RBAC)
  - [ ] Principle of least privilege
  - [ ] API key rotation
  - [ ] Resource-level permissions

data_protection:
  - [ ] Encryption at rest (AES-256)
  - [ ] Encryption in transit (TLS 1.3)
  - [ ] PII identification and masking
  - [ ] Secure key management (HSM/Vault)
  - [ ] Data retention policies
```

## Compliance Frameworks

### GDPR Requirements
```yaml
user_rights:
  - Right to access (data export)
  - Right to deletion (data purge)
  - Right to rectification (data update)
  - Right to portability (standard format)
  - Consent management

technical_measures:
  - Privacy by design
  - Data minimization
  - Pseudonymization
  - Regular audits
  - Breach notification (72h)
```

### Security Headers
```javascript
const securityHeaders = {
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'X-XSS-Protection': '1; mode=block',
  'Content-Security-Policy': "default-src 'self'",
  'Referrer-Policy': 'strict-origin-when-cross-origin'
};
```

## Vulnerability Scanning

### OWASP Top 10 Checks
1. Injection (SQL, NoSQL, Command)
2. Broken Authentication
3. Sensitive Data Exposure
4. XML External Entities (XXE)
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

## Quality Scoring Matrix
```yaml
score_weights:
  authentication: 25
  authorization: 20
  data_encryption: 20
  input_validation: 15
  compliance: 10
  logging: 10

thresholds:
  90-100: "Production ready"
  70-89: "Minor fixes needed"
  50-69: "Significant gaps"
  0-49: "Critical vulnerabilities"
```

## Integration Points
- Links to: qa-testing-engineer, devops-automation
- Requires: Security scanning tools, compliance checklists
- Outputs: Security report, compliance matrix, remediation plan

## Automated Tools
```bash
# Security scanning
npm audit
snyk test
gitleaks detect
trivy fs .

# SAST analysis
semgrep --config=auto
sonarqube-scanner

# Dependency check
safety check
bundler-audit check
```

## Success Criteria
- ✅ Zero critical vulnerabilities
- ✅ All compliance requirements met
- ✅ Security headers implemented
- ✅ Encryption properly configured
- ✅ Audit logs comprehensive
- ✅ Incident response plan tested