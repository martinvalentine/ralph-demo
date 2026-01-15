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

### Using Models (No Payment Required)

Ralph is configured to use OpenCode models by default:
- `opencode/big-pickle` (default)
- `opencode/glm-4.7-free`
- `opencode/minimax-m2.1-free`

No authentication or payment method needed!

### Logging Out from OpenCode Zen (Paid Service)

If you previously logged into OpenCode Zen (which requires payment), log out:

```bash
opencode auth logout
# Select "OpenCode Zen" when prompted
```

Or manually remove it from `~/.local/share/opencode/auth.json`.

### Using Your Own API Keys (Optional)

To use your own API keys from providers like OpenAI or Anthropic:

```bash
opencode auth login
# Select your provider (OpenAI, Anthropic, etc.)
# Enter your API key when prompted
```

Then update `ralph.sh` to remove the `--model opencode/glm-4.7-free` flag to use your configured provider.

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

Default command (uses model): `opencode run --model opencode/big-pickle --format default`

To specify an agent: `opencode --agent build run`

To use a different model: Change `--model opencode/big-pickle` to another model (e.g., `opencode/glm-4.7-free`, `opencode/minimax-m2.1-free`) in `ralph.sh` line 97.

## Differences from Amp

- Free models available (no payment required): `opencode/glm-4.7-free`, `opencode/minimax-m2.1-free`
- Can also use your own API keys (OpenAI, Anthropic, etc.) via `opencode auth login`
- Different command syntax
- May not have thread URLs

## Troubleshooting

1. **"No payment method" error**: You're using OpenCode Zen (paid). Log out with `opencode auth logout` and the script will use free models.

2. Check syntax: `opencode --help`

3. Verify auth: `opencode auth list` (should show 0 credentials for free models)

4. Test manually: `echo "test" | opencode run --model opencode/big-pickle`

5. List available models: `opencode models`

6. Adjust `ralph.sh` line 95 if needed
