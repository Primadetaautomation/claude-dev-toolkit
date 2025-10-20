#!/usr/bin/env node

/**
 * Skill Loader Utility
 * Helps discover and load Agent Skills based on task intent
 */

const fs = require('fs');
const path = require('path');

const SKILLS_DIR = path.join(process.env.HOME, '.claude-skills');

// Skill metadata extracted from SKILL.md frontmatter
const skillMetadata = {
  'production-code-standards': {
    triggers: ['production', 'code quality', 'standards', 'TDD', 'best practices', 'code review', 'maintainable', 'SOLID'],
    agents: ['senior-fullstack-developer', 'code-refactoring-specialist', 'qa-testing-engineer'],
    description: 'Production-ready code standards following CLAUDE Framework'
  },
  'security-essentials': {
    triggers: ['security', 'auth', 'authentication', 'authorization', 'OWASP', 'vulnerability', 'encryption', 'secure', 'XSS', 'CSRF', 'SQL injection'],
    agents: ['security-specialist', 'senior-fullstack-developer', 'qa-testing-engineer'],
    description: 'Security best practices, OWASP compliance, authentication patterns'
  },
  'testing-fundamentals': {
    triggers: ['test', 'testing', 'TDD', 'coverage', 'unit test', 'integration test', 'e2e', 'quality assurance', 'QA'],
    agents: ['qa-testing-engineer', 'senior-fullstack-developer', 'playwright-test-agent'],
    description: 'TDD workflow, comprehensive test strategies, test coverage'
  },
  'deployment-workflows': {
    triggers: ['deploy', 'deployment', 'CI/CD', 'pipeline', 'production', 'infrastructure', 'docker', 'kubernetes', 'vercel'],
    agents: ['devops-deployment-engineer', 'solutions-architect', 'security-specialist'],
    description: 'CI/CD pipelines, zero-downtime deployments, infrastructure as code'
  },
  'backend-development-patterns': {
    triggers: ['api', 'backend', 'REST', 'GraphQL', 'database', 'microservices', 'server', 'endpoint', 'PostgreSQL', 'Supabase'],
    agents: ['senior-fullstack-developer', 'database-migration-specialist', 'solutions-architect'],
    description: 'API design, database patterns, REST/GraphQL, microservices architecture'
  }
};

/**
 * Find skills whose trigger keywords appear in the task description (case-insensitive) and return their names sorted by relevance.
 * @param {string} taskDescription - Task or question text used to match skill trigger keywords.
 * @returns {string[]} Array of skill names sorted by descending number of trigger matches (most relevant first).
 */
function discoverSkills(taskDescription) {
  const normalizedTask = taskDescription.toLowerCase();
  const relevantSkills = [];

  Object.entries(skillMetadata).forEach(([skillName, metadata]) => {
    const matchCount = metadata.triggers.filter(trigger =>
      normalizedTask.includes(trigger.toLowerCase())
    ).length;

    if (matchCount > 0) {
      relevantSkills.push({ skillName, matchCount });
    }
  });

  // Sort by relevance (most matches first)
  relevantSkills.sort((a, b) => b.matchCount - a.matchCount);

  return relevantSkills.map(s => s.skillName);
}

/**
 * List skills associated with a given agent.
 * @param {string} agentName - Agent name to match against skill metadata.
 * @returns {string[]} Array of skill names associated with the given agent.
 */
function getSkillsForAgent(agentName) {
  return Object.entries(skillMetadata)
    .filter(([_, metadata]) => metadata.agents.includes(agentName))
    .map(([skillName]) => skillName);
}

/**
 * Retrieve metadata for all available skills.
 * @returns {Object} The skills metadata keyed by skill name, where each value includes `triggers`, `agents`, and `description`.
 */
function listAllSkills() {
  return skillMetadata;
}

/**
 * Resolve the filesystem path for a skill directory given its name.
 * @param {string} skillName - Skill identifier (directory name as used in metadata).
 * @returns {string} Full path to the skill's directory under SKILLS_DIR.
 */
function getSkillPath(skillName) {
  return path.join(SKILLS_DIR, skillName);
}

/**
 * Determine whether a skill directory with a SKILL.md file exists.
 * @param {string} skillName - Skill directory name to check.
 * @returns {boolean} `true` if a directory for the skill exists and contains a `SKILL.md` file, `false` otherwise.
 */
function skillExists(skillName) {
  const skillPath = getSkillPath(skillName);
  return fs.existsSync(skillPath) && fs.existsSync(path.join(skillPath, 'SKILL.md'));
}

/**
 * Load a skill's markdown content composed according to the requested context level.
 *
 * @param {string} skillName - Name of the skill directory to load.
 * @param {number} [level=1] - Context level: 1 returns only SKILL.md; 2 appends other `.md` files in the skill directory; 3 also includes a list of files in the `scripts` directory if present.
 * @returns {string} The assembled markdown content for the skill.
 * @throws {Error} If the skill does not exist or its SKILL.md is missing.
 */
function loadSkill(skillName, level = 1) {
  if (!skillExists(skillName)) {
    throw new Error(`Skill '${skillName}' not found`);
  }

  const skillPath = getSkillPath(skillName);
  const mainContent = fs.readFileSync(path.join(skillPath, 'SKILL.md'), 'utf8');

  if (level === 1) {
    // Return only main SKILL.md (minimal context)
    return mainContent;
  }

  // For level 2 and 3, include additional files
  let content = mainContent;

  if (level >= 2) {
    // Add detailed patterns if they exist
    const detailedFiles = fs.readdirSync(skillPath)
      .filter(f => f.endsWith('.md') && f !== 'SKILL.md');

    detailedFiles.forEach(file => {
      const filePath = path.join(skillPath, file);
      content += '\n\n---\n\n';
      content += fs.readFileSync(filePath, 'utf8');
    });
  }

  if (level >= 3) {
    // List available scripts
    const scriptsDir = path.join(skillPath, 'scripts');
    if (fs.existsSync(scriptsDir)) {
      const scripts = fs.readdirSync(scriptsDir);
      content += '\n\n---\n\n## Available Scripts\n\n';
      scripts.forEach(script => {
        content += `- ${script}\n`;
      });
    }
  }

  return content;
}

// CLI Interface
if (require.main === module) {
  const command = process.argv[2];
  const arg = process.argv[3];

  switch (command) {
    case 'discover':
      if (!arg) {
        console.error('Usage: skill-loader.js discover "task description"');
        process.exit(1);
      }
      const skills = discoverSkills(arg);
      console.log('Relevant skills for your task:');
      skills.forEach(skill => {
        console.log(`  - ${skill}: ${skillMetadata[skill].description}`);
      });
      break;

    case 'list':
      console.log('Available Agent Skills:\n');
      Object.entries(skillMetadata).forEach(([name, meta]) => {
        console.log(`📦 ${name}`);
        console.log(`   ${meta.description}`);
        console.log(`   Agents: ${meta.agents.join(', ')}`);
        console.log('');
      });
      break;

    case 'agent':
      if (!arg) {
        console.error('Usage: skill-loader.js agent <agent-name>');
        process.exit(1);
      }
      const agentSkills = getSkillsForAgent(arg);
      console.log(`Skills for ${arg}:`);
      agentSkills.forEach(skill => console.log(`  - ${skill}`));
      break;

    case 'load':
      if (!arg) {
        console.error('Usage: skill-loader.js load <skill-name> [level]');
        process.exit(1);
      }
      const level = parseInt(process.argv[4]) || 1;
      try {
        const content = loadSkill(arg, level);
        console.log(content);
      } catch (error) {
        console.error(error.message);
        process.exit(1);
      }
      break;

    case 'help':
    default:
      console.log(`
Agent Skills Loader Utility

Usage:
  skill-loader.js discover "task description"  - Find relevant skills for a task
  skill-loader.js list                         - List all available skills
  skill-loader.js agent <agent-name>           - Show skills for specific agent
  skill-loader.js load <skill-name> [level]    - Load skill content (level 1-3)
  skill-loader.js help                         - Show this help

Examples:
  skill-loader.js discover "I need to create a secure API"
  skill-loader.js agent senior-fullstack-developer
  skill-loader.js load security-essentials 2
      `);
  }
}

// Export for programmatic use
module.exports = {
  discoverSkills,
  getSkillsForAgent,
  listAllSkills,
  skillExists,
  loadSkill,
  getSkillPath,
};