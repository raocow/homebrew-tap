# homebrew-tap

Personal Homebrew tap.

```bash
brew tap raocow/tap             # once
brew trust raocow/tap           # once — Homebrew gates third-party taps
```

## Formulae

### gitplus — [raocow/gitplus](https://github.com/raocow/gitplus)

```bash
brew install gitplus             # then: brew upgrade gitplus
```

Personal `git` subcommands for a PR-based dev cycle: `git sweep` / `git
wsweep` clear out branches and worktrees already merged into the base; `git
pr` lists, checks out, or merges PRs (with Tab-completion, PR-ownership
coloring, and conflict-minimizing merge ordering); `git sync` rebases and
pushes; `git new` and `git haspr` round out the review cycle; `git done`
switches back to base and cleans up. See the
[repo README](https://github.com/raocow/gitplus#readme) for the full command
reference. (Renamed from `gtools`/`git-tools`.)

### devrig — [raocow/devrig](https://github.com/raocow/devrig)

```bash
brew install devrig
devrig enable autovenv          # or: devrig enable (all); then exec zsh
```

Opt-in dev environment helpers:

- `autovenv` — auto-activate the nearest `.venv` when you `cd` into a repo
- `pyf` — bare `python`/`pip` → `python3`/`pip3` fallback
- `envup` — export a `.env` file into the current shell on demand
- `account` — tie a directory to a separate git/ssh identity (per-project
  GitHub accounts), with `devrig account check` catching the silent failure
  where a renamed/moved directory leaves the binding pointing at nothing

`devrig enable <feature>` (or bare `devrig enable` for all three shell
features) edits `~/.zshrc` for you; `devrig disable`/`status`/`doctor` manage
and inspect them. (Renamed from `ezenv` — old `ezenv`/`EZENV_*` names still
work as deprecated fallbacks.)
