# Sandboxes

A collection of containerized MCP (Model Context Protocol) sandbox servers for secure, remote tool execution. Each sandbox runs inside a Docker container and exposes tools over the [Streamable HTTP](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports#streamable-http) transport.

## Available Sandboxes

| Sandbox | Description | Default Port |
|---------|-------------|--------------|
| [ubuntu](./ubuntu/) | Debian-based shell execution sandbox exposing `exec_command` | 3005 |

## Architecture

Each sandbox is a standalone MCP server that:

- Runs inside an isolated Docker container
- Exposes tools via the MCP Streamable HTTP transport at `/mcp`
- Supports optional API key authentication (`x-api-key` header)
- Maintains session state across requests using `mcp-session-id`
- Provides a `/health` endpoint for monitoring

## Quick Start

```bash
# Build and run a sandbox
cd ubuntu
docker build -t exec-server .
docker run -p 3005:3005 exec-server
```

## Integration

These sandboxes are designed to be used with [Orchestra](https://github.com/ruska-ai) or any MCP-compatible client. Add a sandbox as an MCP server by pointing to its `/mcp` endpoint with the `streamable_http` transport.

## Adding a New Sandbox

1. Create a new directory under this repo (e.g., `python/`, `alpine/`)
2. Include a `Dockerfile`, entrypoint, and MCP server implementation
3. Follow the existing pattern: expose `/mcp` and `/health` endpoints
4. Add a `README.md` documenting the sandbox's tools and configuration
