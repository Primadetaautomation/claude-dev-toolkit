# 🔧 Backend Development - API, Database & Server

**Auto-loaded when:** data opslaan, database, API maken, backend, server

---

## API Development Standards

### RESTful API Design
- **API-1 (MUST)** Consistente resource naming (plural nouns: `/users`, `/products`)
- **API-2 (MUST)** Correct HTTP methods:
  - GET = read
  - POST = create
  - PUT = full update
  - PATCH = partial update
  - DELETE = remove
- **API-3 (MUST)** Proper HTTP status codes:
  - 200 OK
  - 201 Created
  - 400 Bad Request
  - 401 Unauthorized
  - 404 Not Found
  - 500 Server Error
- **API-4 (MUST)** API versioning in URL (`/api/v1/`) of header
- **API-5 (MUST)** Pagination voor collections (`?page=1&limit=20`)
- **API-6 (SHOULD)** Filtering, sorting, field selection support
- **API-7 (MUST)** Rate limiting met headers (`X-RateLimit-Limit`, `X-RateLimit-Remaining`)

### Response Format Standards
**RESP-1 (MUST)** Consistente response structure:
```json
{
  "success": true,
  "data": {},
  "meta": { "page": 1, "total": 100 },
  "errors": []
}
```

**RESP-2 (MUST)** ISO 8601 timestamps (`2024-01-15T10:30:00Z`)
**RESP-3 (MUST)** CamelCase voor JSON fields
**RESP-4 (MUST)** Include request ID in responses

### Error Responses
**ERR-1 (MUST)** Structured error responses:
```json
{
  "success": false,
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

**ERR-2 (MUST)** Machine-readable error codes
**ERR-3 (SHOULD)** Include error documentation links

---

## Database Standards

### Database Operations
- **DB-1 (MUST)** Transacties bij multi-step operations
- **DB-2 (MUST)** Index-strategie documenteren
- **DB-3 (MUST)** Migrations + rollback scripts
- **DB-4 (SHOULD)** Vermijd N+1 queries
- **DB-5 (MUST)** Connection pooling configureren
- **DB-6 (MUST)** Query timeouts instellen
- **DB-7 (SHOULD)** Database query logging voor debugging

### Migrations Workflow
```bash
# 1. Planning
- Design migration (schema changes, data transformations)
- Write both UP and DOWN migrations
- Test on copy of production data

# 2. Execution
- Run migration in staging
- Validate data integrity
- Backup production database
- Run migration in production (maintenance window if needed)
- Verify application works

# 3. Monitoring
- Check application logs (first 30 min)
- Monitor database performance
- Have rollback plan ready
```

### Query Optimization
- **OPT-DB-1 (MUST)** Use EXPLAIN voor slow queries
- **OPT-DB-2 (SHOULD)** Index frequently queried columns
- **OPT-DB-3 (MUST)** Avoid SELECT * - specify columns
- **OPT-DB-4 (SHOULD)** Use database-specific optimizations

---

## Authentication & Authorization

### JWT Token Implementation
**AUTH-1 (MUST)** JWT tokens met:
- User ID
- Roles/permissions
- Expiry time (max 24h)
- Refresh token mechanism

**AUTH-2 (MUST)** Token security:
```javascript
// Example: JWT creation
const token = jwt.sign(
  { userId: user.id, role: user.role },
  process.env.JWT_SECRET,
  { expiresIn: '24h' }
);
```

**AUTH-3 (MUST)** Secure token storage:
- Frontend: httpOnly cookies (preferred) or localStorage
- Backend: bcrypt hashed passwords
- Never log tokens

**AUTH-4 (MUST)** Token refresh mechanism:
```javascript
// Refresh token before expiry
if (tokenExpiresIn < 5_minutes) {
  const newToken = await refreshToken(currentToken);
}
```

### OAuth2 Implementation
**OAUTH-1 (SHOULD)** Use proven libraries (Passport.js, NextAuth)
**OAUTH-2 (MUST)** PKCE flow voor public clients
**OAUTH-3 (MUST)** State parameter ter prevent CSRF
**OAUTH-4 (MUST)** Validate redirect URIs

---

## Server Configuration

### Node.js / Express Best Practices
```javascript
// Express setup
const express = require('express');
const app = express();

// Security middleware
app.use(helmet());
app.use(cors({ origin: process.env.ALLOWED_ORIGINS }));
app.use(express.json({ limit: '10mb' }));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use('/api/', limiter);

// Error handling
app.use((err, req, res, next) => {
  logger.error(err.stack);
  res.status(500).json({
    success: false,
    errors: [{ code: 'INTERNAL_ERROR', message: 'Something went wrong' }]
  });
});
```

### Environment Variables
**ENV-1 (MUST)** All secrets in env vars:
```bash
DATABASE_URL=postgresql://...
JWT_SECRET=...
API_KEY=...
```

**ENV-2 (MUST)** Provide `.env.example`:
```bash
DATABASE_URL=
JWT_SECRET=
API_KEY=
NODE_ENV=development
```

### Performance
- **PERF-1 (SHOULD)** Response compression (gzip)
- **PERF-2 (MUST)** Connection pooling voor database
- **PERF-3 (SHOULD)** Caching (Redis, memcached)
- **PERF-4 (MUST)** Async/await voor I/O operations

---

## GraphQL (Alternative to REST)

### Schema Design
```graphql
type Query {
  user(id: ID!): User
  users(page: Int, limit: Int): UserConnection
}

type Mutation {
  createUser(input: CreateUserInput!): User
  updateUser(id: ID!, input: UpdateUserInput!): User
}

type User {
  id: ID!
  email: String!
  name: String!
  createdAt: DateTime!
}
```

### Resolvers
**GQL-1 (MUST)** DataLoader voor N+1 prevention
**GQL-2 (MUST)** Query complexity limits
**GQL-3 (SHOULD)** Pagination voor collections
**GQL-4 (MUST)** Authentication checks in resolvers

---

## Background Jobs & Queues

### Job Queue Implementation
```javascript
// Bull (Redis-based queue)
const Queue = require('bull');
const emailQueue = new Queue('email', process.env.REDIS_URL);

// Producer
emailQueue.add({
  to: 'user@example.com',
  subject: 'Welcome!',
  body: 'Welcome to our platform'
});

// Consumer
emailQueue.process(async (job) => {
  await sendEmail(job.data);
});
```

**QUEUE-1 (MUST)** Retry mechanism met exponential backoff
**QUEUE-2 (MUST)** Dead letter queue voor failed jobs
**QUEUE-3 (SHOULD)** Job monitoring/dashboard
**QUEUE-4 (MUST)** Idempotent job handlers

---

## Logging & Monitoring

### Structured Logging
```javascript
const logger = require('winston');

logger.info('User login', {
  userId: user.id,
  ip: req.ip,
  timestamp: new Date().toISOString()
});

logger.error('Payment failed', {
  orderId: order.id,
  error: error.message,
  stack: error.stack
});
```

**LOG-1 (MUST)** JSON-structured logs
**LOG-2 (MUST)** Correlation ID per request
**LOG-3 (MUST NOT)** Never log passwords, tokens, PII
**LOG-4 (SHOULD)** Log levels: DEBUG, INFO, WARN, ERROR

---

## Common Patterns

### Repository Pattern
```typescript
// UserRepository.ts
class UserRepository {
  async findById(id: string): Promise<User | null> {
    return await db.user.findUnique({ where: { id } });
  }

  async create(data: CreateUserDto): Promise<User> {
    return await db.user.create({ data });
  }
}
```

### Service Layer
```typescript
// UserService.ts
class UserService {
  constructor(private userRepo: UserRepository) {}

  async registerUser(email: string, password: string): Promise<User> {
    // Business logic
    const hashedPassword = await bcrypt.hash(password, 10);
    return await this.userRepo.create({ email, password: hashedPassword });
  }
}
```

---

## Testing

### API Testing
```javascript
// Jest + Supertest
describe('POST /api/users', () => {
  it('creates a new user', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'test@example.com', password: 'secret' })
      .expect(201);

    expect(response.body.success).toBe(true);
    expect(response.body.data.email).toBe('test@example.com');
  });
});
```

**TEST-API-1 (MUST)** Test alle endpoints (CRUD)
**TEST-API-2 (MUST)** Test authentication/authorization
**TEST-API-3 (MUST)** Test error scenarios
**TEST-API-4 (SHOULD)** Integration tests met test database

---

*Auto-loaded bij: API, backend, database, server, data opslaan/ophalen*
