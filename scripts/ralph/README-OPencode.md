# Using OpenCode with Ralph

Ralph now supports both **Amp** and **OpenCode** as AI agent CLIs.

## Installation

Install OpenCode CLI:

```bash
curl -fsSL https://opencode.ai/install | bash
```

Or via npm:
```bash
npm install -g @opencode/cli
```

## Authentication

Authenticate OpenCode with your API keys:

```bash
opencode auth login
```

You'll need API keys from your preferred model provider (OpenAI, Anthropic, etc.).

## Running Ralph with OpenCode

### Auto-detect (uses first available: Amp or OpenCode)
```bash
./scripts/ralph/ralph.sh 10 auto
```

### Explicitly use OpenCode
```bash
./scripts/ralph/ralph.sh 10 opencode
```

### Explicitly use Amp
```bash
./scripts/ralph/ralph.sh 10 amp
```

## OpenCode Configuration

You may need to configure OpenCode for your project:

1. **Initialize OpenCode in your project** (optional):
   ```bash
   opencode init
   ```

2. **Configure agent permissions** - Ensure your agent has permissions to:
   - Write/edit files
   - Run bash commands
   - Execute tests

3. **Adjust the command in ralph.sh** if needed:
   - The default command is: `opencode run --non-interactive`
   - You may need to specify an agent: `opencode --agent build run --non-interactive`
   - Check OpenCode docs for the exact flags you need

## Differences from Amp

- **Cost**: OpenCode uses your API keys directly (no free tier like Amp)
- **Commands**: OpenCode may have different command syntax - adjust `ralph.sh` line 93 if needed
- **Thread URLs**: OpenCode may not have thread URLs - the progress log will adapt

## Troubleshooting

If OpenCode commands fail:
1. Check `opencode --help` for correct syntax
2. Verify authentication: `opencode auth status`
3. Test manually: `echo "test" | opencode run --non-interactive`
4. Adjust the command in `ralph.sh` line 93 based on your OpenCode version
