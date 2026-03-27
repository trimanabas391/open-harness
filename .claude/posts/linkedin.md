# LinkedIn Post — Open Harness Launch

**Author:** [Ryan Eggleston](https://www.linkedin.com/in/ryan-eggleston)
**Repo:** [github.com/ryaneggz/open-harness](https://github.com/ryaneggz/open-harness)

---

## Post

🏗️ AI coding agents need full system access to be useful. Giving them that access on your actual machine is a bad idea.

Open Harness — isolated Docker sandboxes where agents run with full permissions and your host stays untouched.

Three commands:

```
git clone https://github.com/ryaneggz/open-harness.git && cd open-harness
make NAME=dev quickstart
make NAME=dev shell
```

You're now inside an isolated sandbox where Claude Code, OpenAI Codex, or Pi Agent can run with full permissions — without touching your host machine.

Here's what you get out of the box:

🔒 Full isolation — agents run --dangerously-skip-permissions inside a disposable container
🧠 Persistent memory — SOUL.md, MEMORY.md, and daily logs give agents continuity across sessions
⏰ Autonomous heartbeat — agents wake on a timer, perform tasks, and go back to sleep
🐳 Docker-in-Docker — agents can build and manage containers from inside the sandbox
🔄 Multi-sandbox — spin up parallel named sandboxes for different workstreams

What makes this different from just running agents locally:

Most setups treat agents as isolated tools — one agent, one session, start from scratch. Open Harness creates a shared environment where multiple agents coexist.

Claude Code, Codex, and Pi all drop into the same workspace. Same files. Same context. Same memory. One agent writes code, another reviews it, a third runs tests — all reading from and writing to the same space. Swap between them or run them simultaneously without changing anything.

The workspace persists across sessions and agents. Agents pick up where they left off — or where another agent left off. A background heartbeat loop lets agents work autonomously on a timer without anyone present.

Spin up named sandboxes in parallel — `NAME=research`, `NAME=frontend`, `NAME=api` — each its own isolated container with a shared architecture. Your host stays clean. The agents get full permissions inside a space that's disposable.

The architecture is: disposable container + shared persistent workspace + multi-agent collaboration + autonomous execution. That combination doesn't exist in any other open-source tool I've seen.

Star the repo if this is useful: https://github.com/ryaneggz/open-harness

#OpenSource #AI #CodingAgents #DevTools #Docker #ClaudeCode #OpenAI #Developer #SoftwareEngineering

---

## Hashtags (copy-paste)

#OpenSource #AI #CodingAgents #DevTools #Docker #ClaudeCode #OpenAI #Developer #SoftwareEngineering

## Suggested Image

Screenshot of the quickstart terminal output or the repo README hero section.
