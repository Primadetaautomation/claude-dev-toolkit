# 🔒 Security & Privacy - Authentication, GDPR & Data Protection

**Auto-loaded when:** inloggen, registreren, wachtwoord, security, privacy, GDPR, authenticatie

---

## Authentication Implementation

### Password Security
**PASS-1 (MUST)** Bcrypt met min cost factor 10
```javascript
const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;

// Hash password
const hashedPassword = await bcrypt.hash(plainPassword, SALT_ROUNDS);

// Verify password
const isValid = await bcrypt.compare(plainPassword, hashedPassword);
```

**PASS-2 (MUST)** Password requirements:
- Minimum 8 characters
- Mix of upper/lowercase, numbers, special chars
- Check against common passwords list
- Not similar to username/email

**PASS-3 (MUST)** Password reset flow:
```javascript
// 1. Generate secure token
const resetToken = crypto.randomBytes(32).toString('hex');
const hashedToken = crypto.createHash('sha256').update(resetToken).digest('hex');

// 2. Store hashed token + expiry (15 min)
await db.user.update({
  resetToken: hashedToken,
  resetTokenExpiry: Date.now() + 15 * 60 * 1000
});

// 3. Send email with plain token
await sendEmail({
  to: user.email,
  link: `https://app.com/reset-password?token=${resetToken}`
});

// 4. Verify token
const hashedProvidedToken = crypto.createHash('sha256').update(providedToken).digest('hex');
const user = await db.user.findFirst({
  where: {
    resetToken: hashedProvidedToken,
    resetTokenExpiry: { gt: Date.now() }
  }
});
```

---

## Session Management

### JWT Token Standards
**JWT-1 (MUST)** Token structure:
```javascript
const token = jwt.sign(
  {
    sub: user.id,        // Subject (user ID)
    email: user.email,
    role: user.role,
    iat: Math.floor(Date.now() / 1000),  // Issued at
    exp: Math.floor(Date.now() / 1000) + (24 * 60 * 60)  // Expires in 24h
  },
  process.env.JWT_SECRET,
  { algorithm: 'HS256' }
);
```

**JWT-2 (MUST)** Secure secret storage:
```bash
# .env
JWT_SECRET=<generated-via-openssl-rand-hex-32>
JWT_REFRESH_SECRET=<different-secret>
```

**JWT-3 (MUST)** Token refresh mechanism:
```javascript
// Access token: short-lived (15 min)
const accessToken = jwt.sign(payload, ACCESS_SECRET, { expiresIn: '15m' });

// Refresh token: long-lived (7 days), stored in httpOnly cookie
const refreshToken = jwt.sign(payload, REFRESH_SECRET, { expiresIn: '7d' });

res.cookie('refreshToken', refreshToken, {
  httpOnly: true,
  secure: process.env.NODE_ENV === 'production',
  sameSite: 'strict',
  maxAge: 7 * 24 * 60 * 60 * 1000 // 7 days
});
```

### Session Security
**SESS-1 (MUST)** HttpOnly cookies voor tokens
**SESS-2 (MUST)** Secure flag in production
**SESS-3 (MUST)** SameSite=Strict of Lax
**SESS-4 (MUST)** CSRF protection (tokens)
**SESS-5 (SHOULD)** Session invalidation on logout
**SESS-6 (MUST)** Logout from all devices optie

---

## Authorization & Permissions

### Role-Based Access Control (RBAC)
```typescript
enum Role {
  ADMIN = 'ADMIN',
  USER = 'USER',
  GUEST = 'GUEST'
}

// Middleware
function requireRole(allowedRoles: Role[]) {
  return (req, res, next) => {
    if (!req.user) return res.status(401).json({ error: 'Unauthorized' });

    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    next();
  };
}

// Usage
app.delete('/api/users/:id', requireRole([Role.ADMIN]), deleteUser);
```

### Permission Checks
**PERM-1 (MUST)** Server-side permission checks (never trust client)
**PERM-2 (MUST)** Principle of least privilege
**PERM-3 (SHOULD)** Audit log voor sensitive actions
**PERM-4 (MUST)** Resource-level authorization
```javascript
// Check if user owns resource
const post = await db.post.findUnique({ where: { id } });
if (post.authorId !== req.user.id) {
  return res.status(403).json({ error: 'Not your post' });
}
```

---

## Input Validation & Sanitization

### Input Validation
**VAL-1 (MUST)** Validate all inputs server-side
```javascript
// Zod schema
const userSchema = z.object({
  email: z.string().email().max(255),
  age: z.number().int().min(18).max(120),
  website: z.string().url().optional()
});

// Validate
const result = userSchema.safeParse(req.body);
if (!result.success) {
  return res.status(400).json({
    errors: result.error.errors
  });
}
```

### SQL Injection Prevention
**SQL-1 (MUST)** Use parameterized queries / ORM
```javascript
// Good (Prisma)
const users = await prisma.user.findMany({
  where: { email: userEmail }
});

// Bad - SQL injection vulnerable
const users = await db.query(`SELECT * FROM users WHERE email = '${userEmail}'`);
```

### XSS Prevention
**XSS-1 (MUST)** Sanitize output
```javascript
// React automatically escapes
<div>{user.name}</div>

// Dangerous (avoid)
<div dangerouslySetInnerHTML={{ __html: userContent }} />

// Safe HTML rendering
import DOMPurify from 'dompurify';
<div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userContent) }} />
```

**XSS-2 (MUST)** Content Security Policy (CSP)
```javascript
// Helmet middleware
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
    }
  }
}));
```

---

## GDPR Compliance

### Data Minimization
**GDPR-1 (MUST)** Collect only necessary data
**GDPR-2 (MUST)** Define data retention periods
```javascript
// Delete old inactive users
await db.user.deleteMany({
  where: {
    lastLoginAt: { lt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000) }, // 1 year
    deletionScheduled: true
  }
});
```

### User Rights

**Right to Access**
```javascript
// Export user data
app.get('/api/me/export', auth, async (req, res) => {
  const userData = await db.user.findUnique({
    where: { id: req.user.id },
    include: { posts: true, comments: true }
  });

  res.json({
    personal_data: {
      name: userData.name,
      email: userData.email,
      created_at: userData.createdAt
    },
    posts: userData.posts,
    comments: userData.comments
  });
});
```

**Right to Deletion**
```javascript
// Delete account
app.delete('/api/me', auth, async (req, res) => {
  // Anonymize instead of hard delete (for referential integrity)
  await db.user.update({
    where: { id: req.user.id },
    data: {
      email: `deleted_${req.user.id}@deleted.com`,
      name: 'Deleted User',
      deletedAt: new Date()
    }
  });

  res.json({ message: 'Account scheduled for deletion' });
});
```

### Consent Management
**CONS-1 (MUST)** Explicit consent voor data processing
**CONS-2 (MUST)** Easy to withdraw consent
**CONS-3 (MUST)** Granular consent options
```javascript
const consent = {
  analytics: boolean,
  marketing: boolean,
  necessary: true  // Always true
};
```

### Privacy Policy
**PRIV-1 (MUST)** Clear privacy policy
**PRIV-2 (MUST)** Cookie banner (voor EU users)
**PRIV-3 (MUST)** Document data processing activities

---

## Data Encryption

### Encryption at Rest
**ENC-1 (MUST)** Database encryption voor sensitive data
```javascript
// Field-level encryption
const crypto = require('crypto');
const algorithm = 'aes-256-gcm';
const key = Buffer.from(process.env.ENCRYPTION_KEY, 'hex');

function encrypt(text) {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  const authTag = cipher.getAuthTag();

  return {
    encrypted,
    iv: iv.toString('hex'),
    authTag: authTag.toString('hex')
  };
}

function decrypt(encrypted, iv, authTag) {
  const decipher = crypto.createDecipheriv(
    algorithm,
    key,
    Buffer.from(iv, 'hex')
  );
  decipher.setAuthTag(Buffer.from(authTag, 'hex'));

  let decrypted = decipher.update(encrypted, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}
```

### Encryption in Transit
**HTTPS-1 (MUST)** Force HTTPS in production
```javascript
// Redirect HTTP to HTTPS
app.use((req, res, next) => {
  if (process.env.NODE_ENV === 'production' && !req.secure) {
    return res.redirect('https://' + req.headers.host + req.url);
  }
  next();
});
```

**HTTPS-2 (MUST)** HSTS header
```javascript
app.use(helmet.hsts({
  maxAge: 31536000,  // 1 year
  includeSubDomains: true,
  preload: true
}));
```

---

## Rate Limiting & DDoS Protection

### Rate Limiting
```javascript
const rateLimit = require('express-rate-limit');

// General API limiter
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,
  message: 'Too many requests from this IP'
});

// Strict limiter voor login/signup
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5,
  skipSuccessfulRequests: true
});

app.use('/api/', apiLimiter);
app.use('/api/auth/login', authLimiter);
```

**RATE-1 (MUST)** Rate limiting per IP
**RATE-2 (MUST)** Stricter limits voor auth endpoints
**RATE-3 (SHOULD)** CAPTCHA na multiple failed attempts

---

## Security Headers

### Essential Headers (Helmet.js)
```javascript
const helmet = require('helmet');

app.use(helmet({
  contentSecurityPolicy: true,
  crossOriginEmbedderPolicy: true,
  crossOriginOpenerPolicy: true,
  crossOriginResourcePolicy: true,
  dnsPrefetchControl: true,
  frameguard: { action: 'deny' },  // Prevent clickjacking
  hidePoweredBy: true,
  hsts: true,
  ieNoOpen: true,
  noSniff: true,
  referrerPolicy: { policy: 'no-referrer' },
  xssFilter: true
}));
```

---

## Audit Logging

### Security Audit Log
```javascript
async function logSecurityEvent(event) {
  await db.auditLog.create({
    data: {
      userId: event.userId,
      action: event.action,  // LOGIN, LOGOUT, PASSWORD_CHANGE, etc.
      ipAddress: event.ip,
      userAgent: event.userAgent,
      success: event.success,
      timestamp: new Date()
    }
  });
}

// Usage
await logSecurityEvent({
  userId: user.id,
  action: 'LOGIN',
  ip: req.ip,
  userAgent: req.get('user-agent'),
  success: true
});
```

**AUDIT-1 (MUST)** Log all authentication events
**AUDIT-2 (MUST)** Log permission changes
**AUDIT-3 (MUST)** Log data access voor sensitive resources
**AUDIT-4 (MUST)** Retention policy voor audit logs (min 90 days)

---

## Dependency Security

### Vulnerability Scanning
```bash
# Check dependencies
npm audit

# Fix automatically
npm audit fix

# Use Snyk
npx snyk test
```

**DEP-1 (MUST)** Regular dependency updates
**DEP-2 (MUST)** Automated vulnerability scanning (Dependabot, Snyk)
**DEP-3 (MUST)** Review security advisories
**DEP-4 (SHOULD)** Lock file committed (package-lock.json)

---

## Common Vulnerabilities (OWASP Top 10)

1. **Broken Access Control** → Server-side authorization checks
2. **Cryptographic Failures** → HTTPS, encrypt sensitive data
3. **Injection** → Parameterized queries, input validation
4. **Insecure Design** → Security by design, threat modeling
5. **Security Misconfiguration** → Secure defaults, minimal surface
6. **Vulnerable Components** → Dependency scanning
7. **Authentication Failures** → MFA, secure session management
8. **Data Integrity Failures** → Verify data sources, signatures
9. **Logging Failures** → Audit logs, monitor security events
10. **SSRF** → Validate URLs, whitelist allowed hosts

---

*Auto-loaded bij: inloggen, registreren, wachtwoord, security, privacy, GDPR, authenticatie*
