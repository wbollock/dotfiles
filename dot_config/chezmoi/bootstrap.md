# wbollock chezmoi bootstrap

This repo manages workstation dotfiles with `chezmoi`.

## New machine setup

1. Install `chezmoi`.
2. Initialize/apply:

```bash
chezmoi init --apply wbollock
```

3. Ensure these dependencies exist:
- `zsh` + prezto at `~/.zprezto`
- `mise`
- `asdf`
- `direnv`
- `fzf`
- `kubectl`, `kubectx`, `kubens`
- `rbenv`

## Manual secrets and local-only files

Do not store these in chezmoi.

Create/populate manually:
- `~/.secrets/tokens` (sourced by `~/.zshrc`)
- `~/.zshrc.work` (optional local/work aliases and env vars)
- `~/.gitconfig.work` (optional local/work git overrides)
- `~/.gitconfig.work.bits` (optional work identity override file)
- `~/.ssh/*`
- `~/.gnupg/*`
- `~/.netrc`
- `~/.pypirc`
- `~/.vault-token`
- `~/.s3cfg`
- `~/.kube/config` and/or `~/.kube/config.d/*`
- `~/.certs/${USER}.crt` and `~/.certs/${USER}.key` (for Loki client auth)
- `~/.config/gh/hosts.yml`

Suggested contents:

`~/.zshrc.work`

```sh
# local work-only aliases/env
alias ghe='GH_HOST=<work-git-host> gh'
alias pcs='scp -S hss'
export HSS_COMMAND=ssh-wrapper
alias sshengvm='ssh -A <work-bastion-host>'
export PATH="$HOME/repos/forks/hss-config/:$PATH"
export VAULT_ADDR='https://<work-vault-host>:8200'
export LOKI_ADDR='https://<work-loki-host>'
```

`~/.gitconfig.work`

```ini
[includeIf "hasconfig:remote.*.url:git@<work-git-host>:**"]
	path = ~/.gitconfig.work.bits
[includeIf "hasconfig:remote.*.url:ssh://git@<work-git-host>/**"]
	path = ~/.gitconfig.work.bits
[includeIf "hasconfig:remote.*.url:https://<work-git-host>/**"]
	path = ~/.gitconfig.work.bits
```

`~/.gitconfig.work.bits`

```ini
[user]
	email = <work-email@example.com>
```

## Post-apply checks

Run:

```bash
exec zsh
command -v mise asdf direnv kubectl
test -f ~/.secrets/tokens && echo "tokens file present"
ls ~/.kube/config.d 2>/dev/null
```

## Updating dotfiles safely

1. Add only non-secret files.
2. Run:

```bash
chezmoi add <path>
chezmoi diff
chezmoi apply
```

3. Commit changes in `~/.local/share/chezmoi`.
