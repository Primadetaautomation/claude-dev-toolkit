/**
 * Smart Agent Selection System
 * Automatically selects the most appropriate agents based on task analysis
 */

const agentRegistry = require('./agent-registry.json');

class AgentSelector {
  constructor() {
    this.agents = agentRegistry.agents;
    this.categories = agentRegistry.categories;
    this.usageStats = {};
    this.loadUsageStats();
  }

  /**
   * Analyze task and select appropriate agents
   * @param {string} taskDescription - The task to analyze
   * @param {number} maxAgents - Maximum number of agents to select (default: 3)
   * @returns {Array} Selected agents with scores
   */
  selectAgents(taskDescription, maxAgents = 3) {
    const normalizedTask = taskDescription.toLowerCase();
    const scores = {};

    // Score each agent based on trigger matches
    for (const [agentName, agent] of Object.entries(this.agents)) {
      scores[agentName] = 0;

      // Check trigger words
      for (const trigger of agent.triggers || []) {
        if (normalizedTask.includes(trigger.toLowerCase())) {
          scores[agentName] += agent.priority || 50;
        }
      }

      // Boost score for auto-trigger agents
      if (agent.auto_trigger === 'always') {
        scores[agentName] += 200;
      }

      // Apply usage-based weighting (successful agents get slight boost)
      const successRate = this.getAgentSuccessRate(agentName);
      scores[agentName] *= (1 + successRate * 0.1);
    }

    // Sort agents by score and return top N
    const selectedAgents = Object.entries(scores)
      .filter(([_, score]) => score > 0)
      .sort((a, b) => b[1] - a[1])
      .slice(0, maxAgents)
      .map(([agentName, score]) => ({
        name: agentName,
        score: Math.round(score),
        agent: this.agents[agentName]
      }));

    // Always include session-memory for tracking
    if (!selectedAgents.find(a => a.name === 'session-memory-agent')) {
      selectedAgents.push({
        name: 'session-memory-agent',
        score: 1000,
        agent: this.agents['session-memory-agent']
      });
    }

    return selectedAgents;
  }

  /**
   * Get agent chains for complex workflows
   * @param {string} workflowType - Type of workflow
   * @returns {Array} Chain of agents to execute
   */
  getAgentChain(workflowType) {
    const chains = {
      'full_feature': [
        'solutions-architect',
        'backend-specialist',
        'frontend-specialist',
        'qa-testing-engineer',
        'security-compliance-agent'
      ],
      'api_development': [
        'solutions-architect',
        'backend-specialist',
        'documentation-agent',
        'qa-testing-engineer'
      ],
      'deployment': [
        'qa-testing-engineer',
        'security-compliance-agent',
        'performance-testing-agent',
        'devops-automation-agent'
      ],
      'bug_fix': [
        'qa-testing-engineer',
        'senior-fullstack-developer',
        'qa-testing-engineer'
      ],
      'performance_optimization': [
        'performance-testing-agent',
        'database-architect',
        'backend-specialist',
        'performance-testing-agent'
      ]
    };

    return chains[workflowType] || [];
  }

  /**
   * Track agent usage and success
   * @param {string} agentName - Name of the agent
   * @param {boolean} success - Whether the agent succeeded
   * @param {number} executionTime - Time taken in ms
   */
  trackUsage(agentName, success, executionTime) {
    if (!this.usageStats[agentName]) {
      this.usageStats[agentName] = {
        totalRuns: 0,
        successfulRuns: 0,
        totalTime: 0,
        lastUsed: null
      };
    }

    const stats = this.usageStats[agentName];
    stats.totalRuns++;
    if (success) stats.successfulRuns++;
    stats.totalTime += executionTime;
    stats.lastUsed = new Date().toISOString();

    this.saveUsageStats();
  }

  /**
   * Get agent success rate
   * @param {string} agentName - Name of the agent
   * @returns {number} Success rate between 0 and 1
   */
  getAgentSuccessRate(agentName) {
    const stats = this.usageStats[agentName];
    if (!stats || stats.totalRuns === 0) return 0.8; // Default 80% for new agents
    return stats.successfulRuns / stats.totalRuns;
  }

  /**
   * Get agent health dashboard
   * @returns {Object} Health metrics for all agents
   */
  getHealthDashboard() {
    const dashboard = [];

    for (const [agentName, agent] of Object.entries(this.agents)) {
      const stats = this.usageStats[agentName] || {
        totalRuns: 0,
        successfulRuns: 0,
        totalTime: 0,
        lastUsed: 'Never'
      };

      const successRate = stats.totalRuns > 0
        ? (stats.successfulRuns / stats.totalRuns * 100).toFixed(1)
        : 'N/A';

      const avgTime = stats.totalRuns > 0
        ? Math.round(stats.totalTime / stats.totalRuns)
        : 0;

      let status = '✅';
      if (successRate !== 'N/A') {
        if (successRate < 60) status = '🔴';
        else if (successRate < 80) status = '🟡';
      }

      dashboard.push({
        agent: agentName,
        category: agent.category,
        lastUsed: stats.lastUsed || 'Never',
        runs: stats.totalRuns,
        successRate: successRate + '%',
        avgTime: avgTime + 'ms',
        status: status
      });
    }

    return dashboard.sort((a, b) => b.runs - a.runs);
  }

  /**
   * Check for deprecated agents in use
   * @param {Array} agentList - List of agents to check
   * @returns {Array} Deprecated agents found
   */
  checkDeprecated(agentList) {
    const deprecated = [];
    for (const agent of agentList) {
      if (agentRegistry.deprecated_agents.includes(agent)) {
        const replacement = this.findReplacement(agent);
        deprecated.push({
          old: agent,
          new: replacement
        });
      }
    }
    return deprecated;
  }

  /**
   * Find replacement for deprecated agent
   * @param {string} deprecatedAgent - Name of deprecated agent
   * @returns {string} Replacement agent name
   */
  findReplacement(deprecatedAgent) {
    for (const [agentName, agent] of Object.entries(this.agents)) {
      if (agent.replaces && agent.replaces.includes(deprecatedAgent)) {
        return agentName;
      }
    }
    return null;
  }

  /**
   * Load usage statistics from file
   */
  loadUsageStats() {
    try {
      const fs = require('fs');
      const statsFile = './agent-usage-stats.json';
      if (fs.existsSync(statsFile)) {
        this.usageStats = JSON.parse(fs.readFileSync(statsFile, 'utf8'));
      }
    } catch (error) {
      console.error('Failed to load usage stats:', error);
    }
  }

  /**
   * Save usage statistics to file
   */
  saveUsageStats() {
    try {
      const fs = require('fs');
      fs.writeFileSync(
        './agent-usage-stats.json',
        JSON.stringify(this.usageStats, null, 2)
      );
    } catch (error) {
      console.error('Failed to save usage stats:', error);
    }
  }
}

// Example usage
if (require.main === module) {
  const selector = new AgentSelector();

  // Test agent selection
  console.log('\n=== Agent Selection Examples ===\n');
  
  const tasks = [
    "I need to implement user authentication with JWT tokens",
    "Deploy the application to production with zero downtime",
    "My application is running slowly, need performance optimization",
    "Create comprehensive test coverage for the API"
  ];

  for (const task of tasks) {
    console.log(`Task: "${task}"`);
    const agents = selector.selectAgents(task);
    console.log('Selected agents:');
    agents.forEach(a => console.log(`  - ${a.name} (score: ${a.score})`));
    console.log();
  }

  // Show health dashboard
  console.log('\n=== Agent Health Dashboard ===\n');
  const dashboard = selector.getHealthDashboard();
  console.table(dashboard.slice(0, 10));
}

module.exports = AgentSelector;