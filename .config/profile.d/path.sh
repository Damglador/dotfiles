#!/bin/sh

append_path () {
    case ":$PATH:" in
        *:"$1":*);;
        *) PATH="${PATH:+$PATH:}$1"
    esac
}

append_path "$XDG_DATA_HOME/cargo/bin"
append_path "$XDG_DATA_HOME/npm/bin"
append_path "$HOME/Scripts"
append_path "$HOME/.local/bin"

export PATH
