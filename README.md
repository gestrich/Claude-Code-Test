# Claude Code Test


This repository demonstrates using Claude Code in GitHub Actions workflows.

## Files and Components

### MySwiftFile.swift
A simple Swift file with methods:
- `helloWorld()`: Prints "Hello World!" to the console
- `helloWorld2()`: Currently has syntax errors and is duplicated 

### GitHub Actions Workflow Files

#### `.github/workflows/claude-code-pr.yml`
Main workflow file that orchestrates the PR review process:
- **Triggers**: Runs on PR creation, updates, reopening, label addition, or manual workflow dispatch
- **Arguments**:
  - `prompt_option`: Choose between "PR Summary", "Code Review", or "Security Audit" (manual trigger)
  - `branch`: Specify branch to run on (manual trigger, optional)
- **Functionality**:
  - Detects PR labels to determine which type of analysis to run
  - Manages workflow state and output files
  - Calls the claude-code-action with appropriate parameters

#### `.github/actions/claude-code-action/action.yml`
Reusable action that handles the actual Claude Code execution:
- **Arguments**:
  - `github_token`: GitHub token with repository and issue permissions (required)
  - `anthropic_api_key`: Anthropic API key for Claude Code access (required)
  - `prompt`: The prompt to send to Claude Code (optional)
  - `prompt_file`: Path to a file containing prompt (optional alternative)
  - `allowed_tools`: Comma-separated list of tools Claude Code can use (optional)
  - `output_file`: File path to save Claude Code output (optional)
  - `timeout_minutes`: Execution timeout in minutes (default: 10)
  - `install_github_mcp`: Whether to install GitHub MCP server (default: false)
- **Functionality**:
  - Installs Claude Code CLI
  - Prepares the prompt
  - Runs Claude Code with specified parameters
  - Processes the output
  - Comments on the PR with the analysis results

## How They Work Together
1. The workflow file (`claude-code-pr.yml`) triggers based on PR events or manual invocation
2. It determines which type of analysis to run based on PR labels or user selection
3. The workflow then calls the reusable action (`action.yml`) with appropriate parameters
4. The action runs Claude Code with the specified prompt and tools
5. Results are formatted and posted as a comment on the PR
6. For manual runs, results are displayed in the workflow logs

## PR Review with Claude Code

This repository includes a GitHub Actions workflow that automatically runs Claude Code to review pull requests. You can trigger Claude Code reviews in two ways:

### Option 1: Using PR Labels

Add a label starting with `claude_` to your PR to trigger a review. The label name will be used to find a matching prompt file in the `.github/prompts` directory.

For example:

- `claude_pr_summary`: Uses prompt from `.github/prompts/claude_pr_summary.txt`
- `claude_code_review`: Uses prompt from `.github/prompts/claude_code_review.txt`
- `claude_security_audit`: Uses prompt from `.github/prompts/claude_security_audit.txt`
- `claude_review_security`: Would use prompt from `.github/prompts/claude_review_security.txt` (if it exists)

You can create custom prompt files in the `.github/prompts` directory to use with custom labels. If a prompt file doesn't exist for your label, a default one will be created.

### Option 2: Manual Trigger

You can also manually trigger Claude Code from the Actions tab:

1. Go to the "Actions" tab in this repository
2. Select "Claude Code PR Workflow" from the workflows list
3. Click "Run workflow"
4. Select your desired prompt option and branch
5. Click "Run workflow" to start the analysis

## Custom Prompts

The workflow supports custom prompts through label-based triggering. Some examples include:

1. **PR Summary** (`claude_pr_summary`): Comprehensive analysis including:
   - Description of changes
   - Potential risks
   - Issues and bugs
   - Best practices suggestions
   - Security considerations

2. **Code Review** (`claude_code_review`): Detailed code quality feedback on:
   - Code structure and organization
   - Logic and algorithm assessment
   - Testing coverage and quality
   - Specific improvement recommendations

3. **Security Audit** (`claude_security_audit`): Security-focused analysis of:
   - Security vulnerabilities
   - Authentication and authorization
   - Data validation and input handling
   - Security best practices recommendations

### Adding Custom Prompts

To add a custom prompt:

1. Create a text file in `.github/prompts/` named after your label (e.g., `claude_custom_label.txt`)
2. Add your prompt content to the file
3. Apply the corresponding label (e.g., `claude_custom_label`) to your PR

If a prompt file doesn't exist for your label, a default one will be created automatically.
