# CLAUDE Framework Specialized Agents Summary with QA-Guard Integration

## Overview
This directory contains 11 specialized sub-agents enhanced with QA-Guard quality control capabilities. Each agent now includes integrated factual accuracy validation, security assessment, and 0-100 scoring with GO/FIX/BLOCK verdicts. All agents work with the CLAUDE Framework for comprehensive software development projects while ensuring enterprise-grade quality through systematic validation.

## Agent Roster

### 1. 🎯 Master Orchestrator (QA-Guard Enhanced)
**File:** `master-orchestrator.md`
**Primary Role:** Project coordination with integrated QA-Guard quality control across all development phases
**Use For:** Complex projects requiring multiple specialists, enterprise-grade quality standards, systematic CLAUDE Framework enforcement with quality scoring
**Key Responsibilities:**
- Coordinate multiple specialist agents with QA-Guard validation
- Ensure enterprise-grade quality standards through 0-100 scoring
- Systematic enforcement of CLAUDE Framework guidelines
- **QA-Guard Integration**: Mandatory quality gates with GO/FIX/BLOCK verdicts
- **Quality Threshold Enforcement**: Block delivery of scores < 70 without approval

### 2. 🏗️ Solutions Architect
**File:** `solutions-architect.md`
**Primary Role:** System architecture design and technology stack decisions
**Use For:** Architecture design, technology stack decisions, scalability planning, architectural reviews
**Key Responsibilities:**
- Design comprehensive system architectures
- Technology stack recommendations
- Scalability and integration patterns
- Architectural reviews and optimization

### 3. 🔒 Security Specialist (QA-Guard Aligned)
**File:** `security-specialist.md`
**Primary Role:** Security analysis with QA-Guard security rules integration and evidence-based validation
**Use For:** Security reviews, vulnerability assessments, security implementation guidance with quality scoring
**Key Responsibilities:**
- Security audits and code reviews with QA-Guard validation
- Vulnerability assessments with structured JSON output
- Defense-in-depth strategies with evidence-based recommendations
- **QA-Guard Security Rules**: Automatic detection of security anti-patterns
- **Security Scoring**: 0-100 assessment with GO/FIX/BLOCK verdicts

### 4. 💻 Senior Full-Stack Developer (QA-Guard Enhanced)
**File:** `senior-fullstack-developer.md`
**Primary Role:** Production-ready code development with integrated QA-Guard quality checkpoints
**Use For:** Code development, production readiness reviews, TDD implementation with quality validation
**Key Responsibilities:**
- Production-ready code development with QA-Guard validation
- TDD implementation with quality scoring checkpoints
- Comprehensive error handling and security validation
- **QA-Guard Integration**: Pre/during/post development validation
- **Quality Gates**: Mandatory 0-100 scoring before delivery

### 5. 🧪 QA Testing Engineer (QA-Guard Core)
**File:** `qa-testing-engineer.md`
**Primary Role:** Comprehensive testing strategy with integrated QA-Guard quality validation system
**Use For:** Test strategy creation, test coverage analysis, factual accuracy validation, quality scoring
**Key Responsibilities:**
- Comprehensive test suite creation with QA-Guard validation
- Test coverage analysis and quality scoring (0-100)
- **QA-Guard Core Functions**: Factual accuracy assessment, security validation
- **Structured JSON Output**: Evidence-based quality reports with GO/FIX/BLOCK verdicts
- **Quality Control**: Claims verification, consistency checking, testability validation

### 6. 🚀 DevOps Deployment Engineer
**File:** `devops-deployment-engineer.md`
**Primary Role:** CI/CD pipelines, cloud infrastructure, and deployment strategies
**Use For:** CI/CD setup, infrastructure management, deployment strategies, production troubleshooting
**Key Responsibilities:**
- CI/CD pipeline implementation
- Zero-downtime deployments
- Infrastructure automation
- Production monitoring and troubleshooting

### 7. 🗄️ Database Architect
**File:** `database-architect.md`
**Primary Role:** Database design, optimization, and data system architecture
**Use For:** Database design, query optimization, data modeling, backup strategies
**Key Responsibilities:**
- Scalable database design
- Query performance optimization
- Data integrity and backup strategies
- Database security implementation

### 8. 📝 Technical Writer
**File:** `technical-writer.md`
**Primary Role:** Comprehensive documentation creation for all audiences
**Use For:** Documentation creation, API references, user guides, tutorials
**Key Responsibilities:**
- User-friendly documentation
- API documentation
- Developer guides and tutorials
- Documentation maintenance strategies

### 9. 👀 Code Reviewer
**File:** `code-reviewer.md`
**Primary Role:** Code quality reviews with mentorship focus
**Use For:** Code reviews, mentorship, best practices enforcement, knowledge transfer
**Key Responsibilities:**
- Constructive code reviews
- Best practices enforcement
- Knowledge transfer and mentorship
- Code quality assurance

### 10. 🎨 UX/UI Designer
**File:** `ux-ui-designer.md`
**Primary Role:** User-centered design with accessibility and modern patterns
**Use For:** UI/UX design, accessibility compliance, responsive design, user experience optimization
**Key Responsibilities:**
- Accessible interface design
- Mobile-first responsive design
- User experience optimization
- Design system implementation

### 11. ⚡ Performance Engineer
**File:** `performance-engineer.md`
**Primary Role:** Application performance optimization and monitoring
**Use For:** Performance optimization, load testing, monitoring, resource optimization
**Key Responsibilities:**
- Performance budget management
- Frontend and backend optimization
- Load testing and monitoring
- Memory management and leak detection

## Usage Guidelines

### When to Use Which Agent
- **Complex Projects:** Start with Master Orchestrator
- **New Architecture:** Solutions Architect
- **Security Concerns:** Security Specialist
- **Code Development:** Senior Full-Stack Developer
- **Testing Needs:** QA Testing Engineer
- **Deployment/Infrastructure:** DevOps Deployment Engineer
- **Database Design:** Database Architect
- **Documentation:** Technical Writer
- **Code Quality:** Code Reviewer
- **UI/UX Design:** UX/UI Designer
- **Performance Issues:** Performance Engineer

### Agent Collaboration
Agents are designed to work together:
- Master Orchestrator coordinates multiple agents
- Solutions Architect provides foundation for other agents
- Security Specialist reviews all agent outputs
- All agents follow CLAUDE Framework standards

### CLAUDE Framework + QA-Guard Compliance
All agents enforce:
- **Planning & Communication** (P-1 to P-8) with factual accuracy validation
- **Code Quality** (C-1 to C-5, N-1 to N-6, S-1 to S-3) with quality scoring
- **Error Handling** (E-1 to E-5, L-1 to L-4) with comprehensive validation
- **Testing** (T-1 to T-3, TQ-1 to TQ-5) with evidence-based testing
- **Security & Privacy** (SEC-1 to SEC-8) with QA-Guard security rules
- **QA-Guard Integration**: 0-100 scoring, structured JSON output, GO/FIX/BLOCK verdicts
- **Quality Thresholds**: Delivery blocking for scores < 70
- **Evidence-Based Validation**: All claims must be verifiable or marked as "UNSURE"

## QA-Guard Quality Control Features

### Integrated Across All Agents
- **Factual Accuracy Validation**: All claims verified against authoritative sources
- **Consistency Checking**: Outputs validated against project context and previous decisions
- **Security Rule Enforcement**: Automatic detection of security vulnerabilities and anti-patterns
- **Quality Scoring**: Mandatory 0-100 assessment with clear thresholds
- **Structured Output**: JSON format for critical validations with evidence and actions
- **Evidence-Based Recommendations**: All advice backed by verifiable sources

### Quality Gate Thresholds
- **90-100**: Production-ready, minimal risk → **GO**
- **70-89**: Minor issues, acceptable with fixes → **FIX**
- **40-69**: Multiple problems, requires significant work → **FIX/BLOCK**
- **0-39**: Unsafe, broken, or contradictory → **BLOCK**

### QA-Guard JSON Output Format
```json
{
  "type": "claim|architecture|code",
  "verdict": "GO|FIX|BLOCK|UNSURE",
  "score": 0-100,
  "evidence": ["verification points"],
  "issues": ["specific problems"],
  "tests": {
    "commands": ["executable tests"],
    "unit_tests": ["test examples"],
    "acceptance": ["criteria"],
    "expected_results": ["outcomes"]
  },
  "actions": ["actionable fixes"],
  "recommendation": "clear verdict with rationale"
}
```

---
*Generated: 2025-09-13*
*Framework Version: CLAUDE Enhanced v2.0 + QA-Guard Integration*