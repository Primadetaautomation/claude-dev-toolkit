# 🧪 Testing & Quality Assurance - Tests, Debugging & Code Quality

**Auto-loaded when:** testen, test schrijven, debuggen, bug fixen, kwaliteit checken, errors oplossen

---

## Testing Fundamentals

### Test Pyramid
```
      /\
     /E2E\      ← Weinig, maar kritieke flows
    /------\
   / Integr \   ← Matige hoeveelheid
  /----------\
 /   Unit     \ ← Meeste tests hier
/--------------\
```

**TEST-1 (MUST)** 70% unit tests, 20% integration, 10% E2E
**TEST-2 (MUST)** TDD workflow: Red → Green → Refactor
**TEST-3 (MUST)** Minimaal 80% coverage nieuwe code

---

## Unit Testing

### Jest/Vitest Setup
```javascript
// sum.test.js
import { describe, it, expect } from 'vitest';
import { sum } from './sum';

describe('sum function', () => {
  it('adds two numbers correctly', () => {
    expect(sum(1, 2)).toBe(3);
  });

  it('handles negative numbers', () => {
    expect(sum(-1, -2)).toBe(-3);
  });

  it('handles zero', () => {
    expect(sum(0, 5)).toBe(5);
  });
});
```

### React Component Testing
```javascript
// Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from './Button';

describe('Button component', () => {
  it('renders with correct label', () => {
    render(<Button label="Click me" onClick={() => {}} />);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button label="Click" onClick={handleClick} />);

    fireEvent.click(screen.getByText('Click'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('is disabled when disabled prop is true', () => {
    render(<Button label="Click" onClick={() => {}} disabled />);
    expect(screen.getByText('Click')).toBeDisabled();
  });
});
```

**UNIT-1 (MUST)** Test alle edge cases
**UNIT-2 (MUST)** Arrange-Act-Assert pattern
**UNIT-3 (MUST)** Beschrijvende test namen
**UNIT-4 (SHOULD)** 1 assertion per test waar mogelijk
**UNIT-5 (MUST)** Test isolation (geen dependencies tussen tests)

---

## Integration Testing

### API Integration Tests
```javascript
// api.test.js
import request from 'supertest';
import app from './app';
import { db } from './db';

describe('POST /api/users', () => {
  beforeEach(async () => {
    await db.user.deleteMany(); // Clean database
  });

  it('creates a new user', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({
        email: 'test@example.com',
        password: 'securePassword123'
      })
      .expect(201);

    expect(response.body.success).toBe(true);
    expect(response.body.data.email).toBe('test@example.com');
    expect(response.body.data.password).toBeUndefined(); // Never return password
  });

  it('returns 400 for invalid email', async () => {
    await request(app)
      .post('/api/users')
      .send({
        email: 'invalid-email',
        password: 'password'
      })
      .expect(400);
  });
});
```

**INT-1 (MUST)** Test database in isolatie (test DB, niet production)
**INT-2 (MUST)** Clean database voor/na elke test
**INT-3 (MUST)** Test authentication flows
**INT-4 (SHOULD)** Test error scenarios

---

## End-to-End Testing (E2E)

### Playwright Example
```javascript
// login.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Login flow', () => {
  test('successful login redirects to dashboard', async ({ page }) => {
    // Navigate to login page
    await page.goto('http://localhost:3000/login');

    // Fill in credentials
    await page.fill('input[name="email"]', 'user@example.com');
    await page.fill('input[name="password"]', 'password123');

    // Click login button
    await page.click('button[type="submit"]');

    // Wait for redirect
    await page.waitForURL('**/dashboard');

    // Verify dashboard content
    await expect(page.locator('h1')).toContainText('Dashboard');
  });

  test('invalid credentials show error', async ({ page }) => {
    await page.goto('http://localhost:3000/login');

    await page.fill('input[name="email"]', 'wrong@example.com');
    await page.fill('input[name="password"]', 'wrongpassword');
    await page.click('button[type="submit"]');

    // Verify error message
    await expect(page.locator('.error')).toContainText('Invalid credentials');
  });
});
```

**E2E-1 (MUST)** Test kritieke user flows (login, checkout, signup)
**E2E-2 (SHOULD)** Test op meerdere browsers
**E2E-3 (MUST)** Test responsiveness (mobile, desktop)
**E2E-4 (SHOULD)** Visual regression testing

---

## Test Coverage

### Coverage Configuration
```javascript
// vitest.config.js
export default {
  test: {
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'dist/',
        '**/*.test.{js,ts}',
        '**/*.config.{js,ts}'
      ],
      thresholds: {
        lines: 80,
        functions: 80,
        branches: 80,
        statements: 80
      }
    }
  }
}
```

**COV-1 (MUST)** 80%+ coverage voor nieuwe code
**COV-2 (SHOULD)** 90%+ voor kritieke business logic
**COV-3 (MUST)** Coverage reports in CI/CD
**COV-4 (SHOULD)** Coverage trending over tijd

---

## Debugging Strategies

### Console Debugging
```javascript
// Strategic console.log placements
console.log('🔍 Input:', data);
console.log('🔧 Processing:', step1Result);
console.log('✅ Output:', finalResult);

// Better: structured debugging
const debug = {
  input: data,
  step1: step1Result,
  step2: step2Result,
  output: finalResult
};
console.log('Debug snapshot:', JSON.stringify(debug, null, 2));
```

### VS Code Debugging
```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Node App",
      "skipFiles": ["<node_internals>/**"],
      "program": "${workspaceFolder}/server.js",
      "env": {
        "NODE_ENV": "development"
      }
    }
  ]
}
```

**DEBUG-1 (SHOULD)** Gebruik debugger over console.log waar mogelijk
**DEBUG-2 (MUST)** Remove debug logs voor production
**DEBUG-3 (SHOULD)** Use breakpoints + watch variables
**DEBUG-4 (MUST)** Reproduceer bugs in tests

### Browser DevTools
```javascript
// Network tab: check API calls
// Console: check errors
// Sources: breakpoints
// Application: check localStorage/cookies

// Performance profiling
console.time('expensive-operation');
expensiveFunction();
console.timeEnd('expensive-operation');
```

---

## Error Handling Testing

### Expected Errors
```javascript
// Test that errors are thrown correctly
describe('validateEmail', () => {
  it('throws error for invalid email', () => {
    expect(() => {
      validateEmail('invalid');
    }).toThrow('Invalid email format');
  });
});

// Async errors
it('rejects promise for invalid user', async () => {
  await expect(fetchUser('invalid-id')).rejects.toThrow('User not found');
});
```

**ERR-TEST-1 (MUST)** Test error scenarios
**ERR-TEST-2 (MUST)** Test error messages
**ERR-TEST-3 (SHOULD)** Test error recovery flows

---

## Mocking & Stubbing

### Mock External APIs
```javascript
// Mock fetch
global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () => Promise.resolve({ data: 'mocked' })
  })
);

// Mock database
jest.mock('./db', () => ({
  user: {
    findUnique: jest.fn().mockResolvedValue({
      id: '1',
      email: 'test@example.com'
    })
  }
}));
```

### Spy on Functions
```javascript
const spy = jest.spyOn(service, 'sendEmail');

await service.registerUser('test@example.com', 'password');

expect(spy).toHaveBeenCalledWith({
  to: 'test@example.com',
  subject: 'Welcome'
});

spy.mockRestore();
```

**MOCK-1 (MUST)** Mock external dependencies (APIs, databases)
**MOCK-2 (SHOULD)** Use spies om function calls te verifiëren
**MOCK-3 (MUST)** Restore mocks na tests

---

## Performance Testing

### Load Testing (k6)
```javascript
// load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 20 },  // Ramp-up
    { duration: '1m', target: 20 },   // Stay at 20 users
    { duration: '30s', target: 0 },   // Ramp-down
  ],
};

export default function () {
  let response = http.get('https://api.example.com/users');

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  sleep(1);
}
```

**PERF-TEST-1 (SHOULD)** Load test kritieke endpoints
**PERF-TEST-2 (MUST)** Set performance budgets
**PERF-TEST-3 (SHOULD)** Monitor response times
**PERF-TEST-4 (MUST)** Test onder realistische load

---

## Code Quality Tools

### ESLint Configuration
```javascript
// .eslintrc.js
module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'prettier'
  ],
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error',
    'prefer-const': 'error'
  }
};
```

### Prettier Configuration
```javascript
// .prettierrc
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "printWidth": 100
}
```

**QUALITY-1 (MUST)** Linting in pre-commit hook
**QUALITY-2 (MUST)** Formatting automatisch (Prettier)
**QUALITY-3 (SHOULD)** Type checking (TypeScript)
**QUALITY-4 (MUST)** Code review voor merge

---

## Test-Driven Development (TDD)

### TDD Workflow
```
1. RED: Schrijf failing test
2. GREEN: Schrijf minimale code om test te laten slagen
3. REFACTOR: Verbeter code zonder functionaliteit te wijzigen
4. REPEAT
```

### TDD Example
```javascript
// 1. RED - Write failing test first
describe('calculateDiscount', () => {
  it('applies 10% discount for orders over €100', () => {
    expect(calculateDiscount(150)).toBe(135); // FAILS - function doesn't exist yet
  });
});

// 2. GREEN - Write minimal code to pass
function calculateDiscount(amount) {
  if (amount > 100) {
    return amount * 0.9;
  }
  return amount;
}

// 3. REFACTOR - Improve without changing behavior
function calculateDiscount(amount, threshold = 100, discountRate = 0.1) {
  return amount > threshold ? amount * (1 - discountRate) : amount;
}
```

**TDD-1 (MUST)** Test eerst, dan implementatie
**TDD-2 (MUST)** Minimale code om test te laten slagen
**TDD-3 (SHOULD)** Refactor met vertrouwen (tests blijven groen)

---

## Continuous Integration Testing

### GitHub Actions Test Workflow
```yaml
# .github/workflows/test.yml
name: Run Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run tests
        run: npm test -- --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

**CI-TEST-1 (MUST)** Tests draaien bij elke commit
**CI-TEST-2 (MUST)** PR blokkeren bij falende tests
**CI-TEST-3 (SHOULD)** Coverage reports uploaden
**CI-TEST-4 (MUST)** Fast feedback (tests < 5 min)

---

## Common Testing Patterns

### AAA Pattern
```javascript
describe('Shopping cart', () => {
  it('calculates total correctly', () => {
    // ARRANGE - Setup
    const cart = new ShoppingCart();
    const item1 = { price: 10, quantity: 2 };
    const item2 = { price: 5, quantity: 1 };

    // ACT - Execute
    cart.addItem(item1);
    cart.addItem(item2);
    const total = cart.getTotal();

    // ASSERT - Verify
    expect(total).toBe(25);
  });
});
```

### Test Fixtures
```javascript
// fixtures/users.js
export const validUser = {
  email: 'test@example.com',
  password: 'SecurePass123!',
  name: 'Test User'
};

export const invalidUser = {
  email: 'invalid-email',
  password: '123'
};

// Use in tests
import { validUser } from './fixtures/users';

it('creates user with valid data', async () => {
  const result = await createUser(validUser);
  expect(result.success).toBe(true);
});
```

---

## Testing Checklist

**Voor elke feature:**
- [ ] Unit tests geschreven (TDD)
- [ ] Integration tests voor API endpoints
- [ ] E2E tests voor kritieke flows
- [ ] Coverage > 80%
- [ ] Edge cases getest
- [ ] Error scenarios getest
- [ ] Performance acceptable
- [ ] Linting clean
- [ ] Type checking passed
- [ ] Manual testing gedaan

**Pre-deploy:**
- [ ] Alle tests groen in CI
- [ ] Coverage threshold behaald
- [ ] No console errors
- [ ] Performance benchmarks OK
- [ ] Security audit passed

---

## Quick Start Commands

```bash
# Run all tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run with coverage
npm test -- --coverage

# Run specific test file
npm test -- path/to/test.spec.js

# Run E2E tests
npx playwright test

# Lint code
npm run lint

# Fix linting issues
npm run lint -- --fix

# Type check
npx tsc --noEmit
```

---

*Auto-loaded bij: testen, test schrijven, debuggen, bug fixen, kwaliteit checken, errors*
