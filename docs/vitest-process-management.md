# Vitest Process Management voor Claude Code

## Probleem
Claude Code agents kunnen vitest processen accumuleren doordat tests in watch mode draaien of niet proper worden afgesloten.

## Oplossing

### 1. Configuratie Updates

#### Package.json Scripts
```json
{
  "scripts": {
    "test": "vitest run --no-file-parallelism",
    "test:unit": "vitest run tests/unit",
    "test:watch": "vitest watch",
    "test:cleanup": "pkill -f vitest || true",
    "pretest": "npm run test:cleanup"
  }
}
```

#### Vitest Config
```typescript
export default defineConfig({
  test: {
    maxWorkers: '50%',
    minWorkers: 1,
    watch: false,
    teardownTimeout: 1000,
    pool: 'threads',
    poolOptions: {
      threads: {
        singleThread: true,
        isolate: false
      }
    }
  }
});
```

### 2. Process Cleanup Script

Gebruik `/scripts/kill-vitest.sh` om processen op te ruimen:
```bash
./scripts/kill-vitest.sh
```

### 3. Best Practices voor Claude Code

#### ✅ DO's
- Gebruik altijd `vitest run` (niet `vitest`)
- Cleanup processen voor/na tests
- Limiteer parallel workers
- Gebruik `--no-file-parallelism` voor stabiele runs

#### ❌ DON'Ts
- Gebruik NOOIT `vitest watch` in automated scripts
- Start geen tests zonder cleanup
- Laat geen infinite loops in test watchers

### 4. Monitoring

Check regelmatig voor hangende processen:
```bash
# Aantal vitest processen
ps aux | grep vitest | wc -l

# Memory gebruik
ps aux | grep node | awk '{sum+=$6} END {print sum/1024 " MB"}'
```

### 5. Troubleshooting

Als processen blijven hangen:
1. Run cleanup script: `./scripts/kill-vitest.sh`
2. Force kill indien nodig: `killall -9 node` (voorzichtig!)
3. Check voor zombie processen: `ps aux | grep defunct`

## Integration met Claude Code

Deze configuratie is geïntegreerd in:
- `/agents/test-automation-agent.md`
- Alle test-gerelateerde agent configs

Agents zullen nu automatisch:
1. Tests runnen met `vitest run` (niet watch)
2. Cleanup uitvoeren na elke test run
3. Process limits respecteren