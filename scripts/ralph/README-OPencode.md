# Using OpenCode with Ralph

Ralph supports both Amp and OpenCode as AI agent CLIs.

## Installation

```bash
curl -fsSL https://opencode.ai/install | bash
```

Or via npm:
```bash
npm install -g @opencode/cli
```

## Authentication

```bash
opencode auth login
```

Requires API keys from your model provider (OpenAI, Anthropic, etc.).

## Usage

Auto-detect (uses first available):
```bash
./ralph.sh 10 auto
```

Explicitly use OpenCode:
```bash
./ralph.sh 10 opencode
```

Explicitly use Amp:
```bash
./ralph.sh 10 amp
```

## Configuration

Optional project initialization:
```bash
opencode init
```

Ensure agent has permissions to write/edit files, run bash commands, and execute tests.

## Command Syntax

Default command: `opencode run --format default`

To specify an agent: `opencode --agent build run`

Adjust `ralph.sh` line 95 if needed for your OpenCode version.

## Differences from Amp

- Uses your API keys directly (no free tier)
- Different command syntax
- May not have thread URLs

## Troubleshooting

1. Check syntax: `opencode --help`
2. Verify auth: `opencode auth status`
3. Test manually: `echo "test" | opencode run`
4. Adjust `ralph.sh` line 95 if needed
