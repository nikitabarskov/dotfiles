---
name: headroom-check
description:
  Run `headroom perf` and act on its recommendations — flag long/unstable
  conversations, surface uncompressed stale reads, and publish eligible TOIN
  patterns
---

Run:

```bash
headroom perf --hours 0
```

Read the report and act on each section:

**Cache Performance** — if `Unstable` requests are a non-trivial share of total
requests, or `Last 5 avg` cache_write/read is much larger than `First 5 avg`,
the current conversation has grown too long or its prefix is getting rewritten.
Recommend the user `/clear` or compact between unrelated tasks rather than
continuing to grow the session.

**Content Router Routing** — if `Excluded` (Read/Glob output) is a large share
of routed messages, that content is sitting in context uncompressed. Recommend
leaning on CodeGraph/sem/tokensave lookups instead of re-`Read`ing files, and
call `headroom_compress` on large results once you're done reasoning over them.

**TOIN Learning / TOIN Highlights** — if the report lists patterns eligible for
publishing (samples above some threshold shown in the output), run:

```bash
python -m headroom.cli.toin_publish --min-observations <n>
```

using the observation threshold `perf` reported as eligible, not the tool's
default of 50. Locate the `headroom` binary's own Python if the system
`python`/`python3` doesn't have the `headroom` package installed — it's a pipx
install, e.g.:

```bash
find ~/.local/share/mise/installs/pipx-headroom-ai -maxdepth 3 -name python
```

**Recommendations** section — treat these as authoritative and specific;
summarize them for the user rather than re-deriving generic advice.

Report findings concisely: what's healthy, what to change, and any command that
needs the user's confirmation before running (e.g. `toin_publish` writes
`recommendations.toml`, which the proxy loads at startup).
