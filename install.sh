#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

link_config() {
  local name="$1"
  local source="$DOTFILES_DIR/.config/$name"
  local target="$CONFIG_DIR/$name"

  if [[ ! -e "$source" ]]; then
    echo "skip: $source does not exist"
    return
  fi

  mkdir -p "$CONFIG_DIR"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "ok: $target already points to $source"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup"
    echo "backup: moved $target to $backup"
  fi

  ln -s "$source" "$target"
  echo "linked: $target -> $source"
}

link_config "nvim"
link_config "yazi"
