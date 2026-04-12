# Event Heartbeat Delivery Resolution Plan

Issue: #34

## Strategic-Proposal Style Spec Summary

### Problem
Slack periodic heartbeat events are firing, but the resulting assistant replies are not reliably visible in the intended Slack channel or thread. This creates a false-positive execution state where the harness believes work completed, but Slack users do not see the response.

### Best Approach
1. Treat this as a unified outbound delivery bug, not only a scheduler bug
2. Preserve destination metadata end-to-end with optional 
3. Route event-originated responses through the exact same Slack post path as normal assistant responses
4. Persist all event-originated bot replies to 
5. Add structured event lifecycle logging for loaded, triggered, posted, persisted, failed

### Recommended Design
- Event schema supports optional  on immediate, one-shot, periodic events
- Synthetic event retains destination metadata in 
- Agent response helpers decide between channel post and thread post from one canonical execution context
- Logging remains centralized so event replies are recorded exactly once
- Add debug log file for event execution tracing and Slack post failures

### Risks
- duplicate logging if event path and normal path both persist output
- regressions for existing event files without 
- subtle mismatch between placeholder working messages and final response destination

### Acceptance Criteria
1. Event without  posts in channel
2. Event with  posts in thread
3. Visible Slack delivery matches configured destination
4. Event replies append to 
5. Debug logs provide enough data to diagnose delivery failures
6. Legacy event files remain compatible
