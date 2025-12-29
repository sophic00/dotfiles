mkcd() {
    mkdir -p "$1" && cd "$1"
}
temp() {
    cd "$(mktemp -d)" || return
}
trash() {
    if command -v gio >/dev/null 2>&1; then
        gio trash "$@"
    elif command -v trash-put >/dev/null 2>&1; then
        trash-put "$@"
    else
        echo "No trash command found. Install 'gio' or 'trash-cli'."
        return 1
    fi
}
mksh() {
    if [[ -z "$1" ]]; then
        echo "Usage: mksh <script_name.sh>"
        return 1
    fi

    local script="$1"
    touch "$script"
    chmod u+x "$script"

    # Add nice Bash prefixes
    echo "#!/usr/bin/env bash" > "$script"
    echo "set -euo pipefail" >> "$script"
    echo "IFS=$'\\n\\t'" >> "$script"
    echo "" >> "$script"

    # Open with your editor (Vim)
    nvim "$script"
}
getsong() {
    if [[ -z "$1" ]]; then
        echo "Usage: getsong <URL>"
        return 1
    fi

    local output_dir="$HOME/Downloads/songs"
    mkdir -p "$output_dir"

    yt-dlp -x --audio-format mp3 -o "$output_dir/%(title)s.%(ext)s" "$1"
}
wifi_on() {
    nmcli radio wifi on
}

wifi_off() {
    nmcli radio wifi off
}

wifi_toggle() {
    if [[ $(nmcli radio wifi) == "enabled" ]]; then
        nmcli radio wifi off
        echo "Wi-Fi turned off"
    else
        nmcli radio wifi on
        echo "Wi-Fi turned on"
    fi
}
wifi_scan() {
    nmcli device wifi rescan
    nmcli device wifi list
}
wifi_connect() {
    if [[ -z "$1" ]]; then
        echo "Usage: wifi_connect <SSID> [password]"
        return 1
    fi

    local ssid="$1"
    local password="${2:-}"

    if [[ -z "$password" ]]; then
        nmcli device wifi connect "$ssid"
    else
        nmcli device wifi connect "$ssid" password "$password"
    fi
}
line() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: line <line_number>"
        return 1
    fi

    local lineno="$1"
    awk "NR==$lineno {print; exit}"
}
scratch() {
    local tmpfile
    tmpfile=$(mktemp)
    nvim "$tmpfile"
    rm -f "$tmpfile"
}
ipy() {
    if command -v python >/dev/null 2>&1; then
        python
    elif command -v python3 >/dev/null 2>&1; then
        python3
    else
        echo "Python not found."
        return 1
    fi
}
isql() {
    if ! command -v sqlite3 >/dev/null 2>&1; then
        echo "sqlite3 not found."
        return 1
    fi
    sqlite3 :memory:
}
ijs() {
    if command -v deno >/dev/null 2>&1; then
        deno repl
    elif command -v bun >/dev/null 2>&1; then
        bun repl
    elif command -v node >/dev/null 2>&1; then
        node
    else
        echo "No JavaScript runtime found (Deno, Bun, or Node)."
        return 1
    fi
}
iocaml() {
    if command -v utop >/dev/null 2>&1; then
        utop
    elif command -v ocaml >/dev/null 2>&1; then
        ocaml
    else
        echo "No OCaml REPL found (install 'utop' or 'ocaml')."
        return 1
    fi
}
tunes() {
    if ! command -v mpv >/dev/null 2>&1; then
        echo "mpv is not installed."
        return 1
    fi

    mpv --no-video --ytdl-format=worstaudio "$@"
}
