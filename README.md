# magic

Persistent, named terminal sessions over SSH. Close your laptop, walk away, come back on any device — your session is exactly where you left it.

Built on [`dtach`](https://github.com/crigler/dtach), which handles session detachment with no UI chrome or key interception. Unlike tmux or screen, dtach adds no frame around your terminal, so TUI apps (Claude Code, htop, etc.) render cleanly.

## How it works

`magic` SSHs into a host and attaches to (or creates) a `dtach` socket at `/tmp/magic-<slot>.sock` on the remote. The slot name is deterministic — any device using the same slot name connects to the same live session simultaneously.

## Usage

```sh
magic <host>                 # connect to default slot
magic <host> <slot>          # connect to a named slot
magic <host> --list          # show all live sessions on host
magic <host> --kill <slot>   # terminate a specific session
```

**Detach key:** `Ctrl+\` (leaves the session running on the remote)

### Examples

```sh
magic arc                    # default session on arc
magic arc claude             # separate session for Claude Code
magic dev work               # session named "work" on dev

magic arc --list             # what's running on arc?
magic arc --kill claude      # kill the claude session
```

### Multi-device sharing

Because socket names are deterministic, running `magic arc` from your laptop and your phone at the same time connects both to the same session. You'll share the same terminal view.

## Install

### Local (run this once per machine you connect *from*)

```sh
./install-local.sh           # installs to ~/.local/bin
./install-local.sh /usr/local/bin  # or a custom path
```

Requires: `ssh` (standard), `openssl` (standard)

### Remote (run once per host you connect *to*)

```sh
./install-remote.sh arc
./install-remote.sh dev
```

This installs `dtach` on the remote host. Supports Arch (via yay/paru), Debian/Ubuntu (apt), Fedora/RHEL (dnf), macOS (brew).

## Uninstall

```sh
./uninstall-local.sh         # removes magic from ~/.local/bin
./uninstall-remote.sh arc    # kills sessions and removes sockets on arc
```

## Sessions and cleanup

Sessions live on the remote as long as the process inside them is running (or until you kill the socket). Check for orphaned sessions with:

```sh
magic arc --list
magic arc --kill <slot>
```

The default slot (no slot argument) is named `default`.
