# CLAUDE.md - Globale Developer Guidelines

## 🎯 Universele Coding Principes

### 0 — Basis Missie
Deze regels zorgen voor **hoogwaardige, maintainbare code** ongeacht tech stack.
- **MUST** = Verplicht, wordt gecontroleerd
- **SHOULD** = Sterk aanbevolen
- **COULD** = Optioneel, afhankelijk van context

---

## 1 — Planning & Communicatie (ALTIJD)

### Pre-Development
- **P-1 (MUST)** Stel MINIMAAL 3 clarifying questions voordat je code schrijft
- **P-2 (MUST)** Maak een step-by-step plan en vraag expliciet om goedkeuring
- **P-3 (MUST)** Bij meerdere approaches: maak comparison table met pros/cons
- **P-4 (MUST)** Definieer duidelijke acceptance criteria
- **P-5 (SHOULD)** Schat complexity (Simple/Medium/Complex) en waarschuw bij complexiteit

### Communicatie
- **P-6 (MUST)** Leg uit WAAROM je keuzes maakt, niet alleen WAT
- **P-7 (MUST)** Bij elke change: documenteer impact op bestaande code
- **P-8 (SHOULD)** Noem welke files je gaat wijzigen voordat je begint

---

## 2 — Code Kwaliteit (UNIVERSEEL)

### Basis Principes
- **C-1 (MUST)** Single Responsibility Principle - elke functie/class doet ÉÉN ding
- **C-2 (MUST)** DRY (Don't Repeat Yourself) - geen code duplicatie
- **C-3 (MUST)** KISS (Keep It Simple Stupid) - eenvoud boven complexiteit
- **C-4 (MUST)** Functions maximum 20 regels (split anders op)
- **C-5 (SHOULD)** Prefer composition over inheritance

### Naming Conventions
- **N-1 (MUST)** Gebruik beschrijvende namen die intent uitleggen
- **N-2 (MUST)** Functions = verbs: `calculateTotal()`, `fetchUserData()`
- **N-3 (MUST)** Variables = nouns: `userAccount`, `totalPrice`
- **N-4 (MUST)** Booleans beginnen met is/has/can/should: `isValid`, `hasPermission`
- **N-5 (MUST)** Constants in UPPER_SNAKE_CASE: `MAX_RETRY_ATTEMPTS`
- **N-6 (SHOULD)** Avoid abbreviations: `user` niet `usr`, `calculate` niet `calc`

### Code Structure
- **S-1 (MUST)** Consistent indentation (2 of 4 spaces, nooit tabs gemixed)
- **S-2 (MUST)** Maximum 80-120 karakters per regel
- **S-3 (SHOULD)** Group related functionality together
- **S-4 (SHOULD)** Use meaningful comments alleen voor WHY, niet WHAT

---

## 3 — Error Handling (KRITIEK)

### Error Strategy
- **E-1 (MUST)** Handle ALL possible error scenarios
- **E-2 (MUST)** Use specific error types/messages
- **E-3 (MUST)** Log errors met context information
- **E-4 (MUST NOT)** Silent failures - altijd handle of propagate errors
- **E-5 (SHOULD)** Fail fast - validate inputs early

### Logging Best Practices
- **L-1 (MUST)** Structured logging (JSON format waar mogelijk)
- **L-2 (MUST NOT)** Log sensitive data (passwords, tokens, PII)
- **L-3 (SHOULD)** Include correlation IDs voor tracing
- **L-4 (SHOULD)** Different log levels: DEBUG, INFO, WARN, ERROR

---

## 4 — Testing (NIET-NEGOTABEL)

### Test Strategy
- **T-1 (MUST)** TDD: Red → Green → Refactor
- **T-2 (MUST)** Minimaal 80% code coverage voor nieuwe code
- **T-3 (MUST)** Test happy path, error scenarios, en edge cases
- **T-4 (MUST)** Tests moeten kunnen falen voor echte bugs

### Test Quality
- **TQ-1 (MUST)** Descriptive test names die exact beschrijven wat wordt getest
- **TQ-2 (MUST)** Arrange-Act-Assert pattern duidelijk gescheiden
- **TQ-3 (MUST)** Use realistic test data, geen magic numbers
- **TQ-4 (SHOULD)** One assertion per test waar mogelijk
- **TQ-5 (SHOULD)** Test isolation - tests beïnvloeden elkaar niet

---

## 5 — Security & Performance

### Security Basics
- **SEC-1 (MUST)** Validate ALL inputs aan system boundaries
- **SEC-2 (MUST)** Sanitize output data
- **SEC-3 (MUST)** Use environment variables voor secrets
- **SEC-4 (MUST NOT)** Hardcode sensitive information
- **SEC-5 (SHOULD)** Principle of least privilege

### Performance Considerations
- **P-1 (SHOULD)** Optimize voor readability first, performance second
- **P-2 (MUST)** Avoid premature optimization
- **P-3 (SHOULD)** Profile before optimizing
- **P-4 (MUST)** Handle large datasets efficiently (streaming, pagination)

---

## 6 — Git & Version Control

### Commit Standards
- **GIT-1 (MUST)** Conventional Commits format:
  ```
  type(scope): description
  
  [optional body]
  
  [optional footer]
  ```
- **GIT-2 (MUST)** Atomic commits - één logical change per commit
- **GIT-3 (MUST NOT)** Reference AI/Claude in commit messages
- **GIT-4 (SHOULD)** Descriptive commit messages die context geven

### Branch Strategy
- **B-1 (SHOULD)** Feature branches voor nieuwe functionaliteit
- **B-2 (SHOULD)** Descriptive branch names: `feature/user-authentication`
- **B-3 (MUST)** Code review before merge naar main/master

---

## Enhanced Shortcuts (UNIVERSEEL)

### QNEW
```
VERSTAAN alle best practices in dit document.
Je code MOET ALTIJD deze principes volgen.
Vraag minimaal 3 clarifying questions.
Maak een duidelijk step-by-step plan.
```

### QPLAN
```
Analyseer bestaande codebase en zorg dat je plan:
- Consistent is met bestaande patterns
- Minimale breaking changes introduceert  
- Bestaande code hergebruikt waar mogelijk
- Performance impact documenteert
- Security implications overweegt
```

### QCODE
```
Implementeer volgens TDD proces:
1. Schrijf failing test eerst
2. Implementeer minimale code om test te laten slagen
3. Refactor voor code quality
4. Run alle tests om niets kapot te maken
5. Format code volgens project standards
6. Check linting/type errors
7. Documenteer breaking changes
```

### QCHECK
```
Skeptische senior engineer review van ALLE changes:
1. Single Responsibility Principle gevolgd?
2. Error handling compleet?
3. Security vulnerabilities mogelijk?
4. Performance impact acceptabel?
5. Test coverage adequaat?
6. Code readable en maintainable?
7. Breaking changes gedocumenteerd?
```

### QSECURITY
```
Security focused review:
1. Input validation present?
2. Output sanitization correct?
3. Authentication/authorization proper?
4. Sensitive data handled securely?
5. Injection attacks prevented?
6. Error messages non-revealing?
```

### QTEST
```
Testing completeness check:
1. Happy path scenarios covered?
2. Error conditions tested?
3. Edge cases included?
4. Test isolation maintained?
5. Realistic test data used?
6. Assertions meaningful and specific?
```

### QREFACTOR
```
Code quality improvement review:
1. Functions onder 20 regels?
2. No code duplication?
3. Meaningful variable names?
4. Single responsibility maintained?
5. Error handling consistent?
6. Comments explain WHY not WHAT?
```

### QUX
```
User experience testing scenarios:
1. Happy path user journeys
2. Error recovery scenarios  
3. Edge case user behavior
4. Performance under load
5. Accessibility compliance
6. Mobile/responsive behavior
```

### QGIT
```
Git workflow completion:
1. Stage relevant changes only
2. Write conventional commit message
3. Include meaningful description
4. NO reference to AI/Claude
5. Push to remote
6. Verify CI/CD pipeline
```

---

## Tech Stack Specific Additions

### Web Development (Frontend)
- **WEB-1 (SHOULD)** Semantic HTML elementen
- **WEB-2 (MUST)** Accessibility compliance (WCAG 2.1)
- **WEB-3 (SHOULD)** Progressive enhancement
- **WEB-4 (MUST)** Cross-browser compatibility testing

### API Development (Backend)
- **API-1 (MUST)** RESTful principles of GraphQL best practices
- **API-2 (MUST)** Proper HTTP status codes
- **API-3 (MUST)** Input validation en rate limiting
- **API-4 (SHOULD)** API versioning strategy

### Database
- **DB-1 (MUST)** Use transactions voor multi-step operations
- **DB-2 (SHOULD)** Optimize queries (avoid N+1 problems)
- **DB-3 (MUST)** Proper indexing strategy
- **DB-4 (SHOULD)** Database migration scripts

---

## Project Context Recognition

Wanneer je met specifieke tech stacks werkt, pas deze regels aan:

### JavaScript/TypeScript
- Strict type checking
- ESLint + Prettier
- Jest/Vitest voor testing

### Python  
- PEP 8 style guide
- Type hints met mypy
- pytest voor testing

### Java
- CheckStyle compliance
- JUnit voor testing
- Proper exception handling

### C#
- Microsoft coding conventions
- Unit testing met xUnit
- Proper async/await usage

---

## Continuous Improvement

### Weekly Review
1. Code quality metrics
2. Bug patterns identification  
3. Performance bottlenecks
4. Developer velocity

### Monthly Retrospective
1. Guidelines effectiveness
2. Tool improvements needed
3. Team skill development
4. Process optimization

---

## Emergency Procedures

### Bug Fixes
1. Reproduce locally
2. Write failing test
3. Minimal fix implementation
4. Verify fix works
5. Check for regressions

### Performance Issues
1. Profile application
2. Identify bottlenecks
3. Optimize critical path
4. Measure improvement
5. Monitor in production

Remember: **Code is read more than it's written. Optimize for the next developer (including future you).**
