# ai-tooling
Repository to store GenAI integration scripts

## Tools

### 🚀 Git Repo Runner
A lightweight Bash CLI tool to automate workspace setup. It creates a project directory and clones multiple git repositories based on predefined keywords.

Perfect for: Quickly spinning up microservices environments without remembering long Git URLs.

#### ✨ Features
- Smart Mapping: Maps short keywords (e.g., amazon, common) to full SSH/HTTPS Git URLs.
- Batch Processing: Clones multiple repositories in one go.
- Idempotent: Safely checks if a repository folder already exists before cloning to avoid errors.
- Auto-Directory: Creates the target workspace directory automatically.
- Compatibility: Works on Bash 3.2+ (standard on macOS) and Linux.
---
#### 📦 Usage

```Bash
run <target_directory> [keyword1] [keyword2] ...
```

##### Example
To create a folder named integration-test and clone the Amazon service and Common Libs:

```Bash
run integration-test amazon common
```

Output:
```Plaintext
📂 Creating directory: integration-test
⬇️  Processing repositories...
📥 Cloning: amazon-integration-service (amazon)...
📥 Cloning: common-libs (common)...
🎉 Done!
```
---
#### ⚙️ Installation
Choose one of the methods below to make the run command available globally in your terminal.

##### Option A: System-wide (Recommended)
This moves the script to your system path (`/usr/local/bin`), making it accessible from anywhere.

Give the script execution permissions:

```Bash
chmod +x setup_workspace.sh
````
Move it to the bin directory (renaming it to `run`):

```Bash
sudo mv setup_workspace.sh /usr/local/bin/run
```
Done! Type run in your terminal.

##### Option B: Alias (User only)
If you prefer keeping the script in your own folder.

Save the script locally (e.g., `~/scripts/setup_workspace.sh`).

Add an alias to your shell profile (`.bash_profile` or `.zshrc`):

```Bash
echo 'alias run="~/scripts/setup_workspace.sh"' >> ~/.bash_profile
```

Refresh your shell:

```Bash
source ~/.bash_profile
```
---
#### 🛠 Configuration
To add new repositories or change existing URLs, simply open the script and edit the `case` statement:

```Bash
case "$KEYWORD" in
"amazon")       REPO_URL="git@github.com:rmiq-net/amazon-integration-service.git" ;;
"new-service")  REPO_URL="git@github.com:your-org/new-service.git" ;;
esac
```
---
#### 📝 License
MIT