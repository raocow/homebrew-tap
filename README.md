# homebrew-tap

Personal Homebrew tap.

```bash
brew tap raocow/tap             # once
brew trust raocow/tap           # once — Homebrew gates third-party taps
```

## Formulae

### gtools — [alexrao2000/git-tools](https://github.com/alexrao2000/git-tools)

```bash
brew install gtools             # then: brew upgrade gtools
```

Installs the `git sweep`, `git sync`, `git pr`, and `git done` subcommands.

### ezenv — [raocow/ezenv](https://github.com/raocow/ezenv)

```bash
brew install ezenv              # then add the source lines it prints
```

Opt-in zsh helpers: per-repo `.venv` auto-activation and bare `python`/`pip`
→ `python3`/`pip3` fallback. Each feature is enabled with a `source` line in
`~/.zshrc`; run `ezenv init` to print them.
