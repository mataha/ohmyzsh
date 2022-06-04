function yarn-or-yarnw() {
  local dir project_root

  dir="$(pwd)"

  while [[ "$dir" != / ]]; do
    if [[ -f "$dir/.yarnrc.yml" || -f "$dir/.yarnrc" || -f "$dir/yarnw" ]]; then
      project_root="$dir"
      break
    fi
    dir="${dir:h}"
  done

  if [[ -f "$project_root/yarnw" ]]; then
    echo "Yarn wrapper was found, executing it instead of yarn..."
    "$project_root/yarnw" "$@"
  else
    command yarn "$@"
  fi
}

if zstyle -T ':omz:plugins:yarn' global-path; then
  # Skip yarn call if default global bin dir exists
  [[ -d "$HOME/.yarn/bin" ]] && bindir="$HOME/.yarn/bin" || bindir="$(yarn global bin 2>/dev/null)"

  # Add yarn bin directory to $PATH if it exists and not already in $PATH
  [[ $? -eq 0 ]] \
    && [[ -d "$bindir" ]] \
    && (( ! ${path[(Ie)$bindir]} )) \
    && path+=("$bindir")
  unset bindir
fi

alias y="yarn-or-yarnw"
alias ya="yarn-or-yarnw add"
alias yad="yarn-or-yarnw add --dev"
alias yap="yarn-or-yarnw add --peer"
alias yb="yarn-or-yarnw build"
alias ycc="yarn-or-yarnw cache clean"
alias yd="yarn-or-yarnw dev"
alias yga="yarn-or-yarnw global add"
alias ygls="yarn-or-yarnw global list"
alias ygrm="yarn-or-yarnw global remove"
alias ygu="yarn-or-yarnw global upgrade"
alias yh="yarn-or-yarnw help"
alias yi="yarn-or-yarnw init"
alias yin="yarn-or-yarnw install"
alias yln="yarn-or-yarnw lint"
alias ylnf="yarn-or-yarnw lint --fix"
alias yls="yarn-or-yarnw list"
alias yout="yarn-or-yarnw outdated"
alias yp="yarn-or-yarnw pack"
alias yrm="yarn-or-yarnw remove"
alias yrun="yarn-or-yarnw run"
alias ys="yarn-or-yarnw serve"
alias yst="yarn-or-yarnw start"
alias yt="yarn-or-yarnw test"
alias ytc="yarn-or-yarnw test --coverage"
alias yuc="yarn-or-yarnw global upgrade && yarn-or-yarnw cache clean"
alias yui="yarn-or-yarnw upgrade-interactive"
alias yuil="yarn-or-yarnw upgrade-interactive --latest"
alias yup="yarn-or-yarnw upgrade"
alias yv="yarn-or-yarnw version"
alias yw="yarn-or-yarnw workspace"
alias yws="yarn-or-yarnw workspaces"

alias yarn="yarn-or-yarnw"
compdef _yarn yarn-or-yarnw
