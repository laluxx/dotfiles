function path() {
  local dir_list=$(echo $PATH | sed "s/:/\\n/g")
  printf "EnvPath([\n" && printf "'%s',\n" $dir_list | sed "s|^ |/|; s|^|  |" && printf "])\n"
}

export PATH="/home/l/.config/emacs/bin:$PATH"

export ROFI_THEME="/home/yourusername/.cache/wal/colors-rofi-dark.rasi"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # PACMAN path
# source $HOME/.config/zsh/plug/fzf-keybindings.plugins.zsh

source ~/.cache/wal/colors.sh

#bash ~/Desktop/xos-0.5/xapps/xpalette/catpuccin.sh

#Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Fetch all plugins in dir
plugins=(`echo $(ls $ZSH/plugins | sed -z 's/\n/ /g')`)

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
#compinit _comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s '^r' 'lfcd\n'
# below opens a new terminal in current dir
bindkey -s '^e' 'pcmanfm\n'

# case "$TERM" in (rxvt|rxvt-*|st|st-*|*xterm*|(dt|k|E)term)
#     local term_title () { print -n "\e]0;${(j: :q)@}\a" }
#     precmd () {
#       local DIR="$(print -P '[%c]')"
#       term_title "$DIR" "st"
#     }
#     preexec () {
#       local DIR="$(print -P '[%c]%#')"
#       local CMD="${(j:\n:)${(f)1}}"
#       #term_title "$DIR" "$CMD" use this if you want directory in command, below only prints program name
# 	  term_title "$CMD"
#     }
#   ;;
# esac

#Set bookmarks dir
# To add any bookmark, use command below without quotes:
# bm 'bookmarkdir' '@bookmarkname' OR bm @bookmarkname to bookmark current directory
[[ -d "$ZSHCFG/bookmarks" ]] && export CDPATH=".:$ZSHCFG/bookmarks:/" \
	&& alias jmp="cd -P"

setopt autocd
# change below theme if using oh-my-zsh
#ZSH_THEME=""
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}




# Load aliases
[ -f "$ZSHCFG/aliasrc" ] && source "$ZSHCFG/aliasrc"

# Note that in different distro or installation way below source files need to be changed, they are usually in ~/.zsh/
source "$ZSHCFG/OMZ/oh-my-zsh.sh"
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# vi mode
bindkey -v
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
if [ ! -z $BM_DIR ]; then
    cd -P $BM_DIR &&
    export BM_DIR=""
fi

# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line


# Below to change autosuggestion options
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"	# To get colored completion text
bindkey '^[[Z' autosuggest-accept   # shift tab to accept ghost text
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

export LESS_TERMCAP_mb=$(tput bold; tput setaf 39)
export LESS_TERMCAP_md=$(tput bold; tput setaf 45)
export LESS_TERMCAP_me=$(tput sgr0)

userchrome() {
  c ~/.mozilla/firefox/exnoy41o.default-release/chrome
}

function desktop-apps() {
    c ~/.local/share/applications
}

declare -A image_map=(
  # ["rust"]="$HOME/Desktop/xos/xicons/rust.png"
  ["rust"]="$HOME/Desktop/xos/xicons/3.png"
  ["doom"]="$HOME/.doom.d"
  ["lua"]="$HOME/Desktop/xos/xicons/lua.png"
  ["bash"]="$HOME/Desktop/xos/xicons/bash.png"
  ["c++"]="$HOME/Desktop/xos/xicons/cpp.png"
  ["c"]="$HOME/Desktop/xos/xicons/c.png"
  ["haskell"]="$HOME/Desktop/xos/xassets/haskell.png"
  ["python"]="$HOME/Desktop/xos/xassets/python.png"
  ["test"]="$HOME/Desktop/xos/xassets/test.png"
  [".doom.d"]="$HOME/Desktop/xos/xicons/emacs.png"
  ["emacs"]="$HOME/Desktop/xos/xicons/emacs.png"
  ["doom"]="$HOME/Desktop/xos/xicons/emacs.png"
  ["xwal"]="$HOME/Desktop/xos/xicons/xwal.png"
  ["nix"]="$HOME/Desktop/xos/xicons/nix256x256.png"
  ["go"]="$HOME/Desktop/xos/xicons/go.png"
  ["debian"]="$HOME/Desktop/xos/xicons/debian.png"
  ["head"]="$HOME/Desktop/xos/xicons/head.png"
  ["docker"]="$HOME/Desktop/xos/xicons/docker.png"
  ["md"]="$HOME/Desktop/xos/xicons/md.png"
  ["web"]="$HOME/Desktop/xos/xicons/md.png"
  ["react"]="$HOME/Desktop/xos/xicons/react256x256.png"
  ["cutefish"]="$HOME/Desktop/xos/xicons/cutefish.png"
  ["ubuntu"]="$HOME/Desktop/xos/xicons/ubuntu.png"
  ["awesome"]="$HOME/Desktop/xos/xicons/awesome.png"
  ["xos"]="$HOME/Desktop/xos/xicons/xos.png"
 # ["ai"]="$HOME/Desktop/xos/xicons/head.png"
  ["deepin"]="$HOME/Desktop/xos/xicons/deepin.png"
  ["welcome"]="$HOME/Desktop/xos/xicons/weloce.png"
 ["default"]="$HOME/Desktop/xos/xicons/default.png"
)

#chpwd dependencie
function display_image() {
  local image_path="${image_map[$1]}"
  if [[ -z "$image_path" ]]; then
    image_path="${image_map["default"]}"
  fi
  if [[ -f "$image_path" ]]; then
    kitty +kitten icat "$image_path"
  fi
}

function chpwd() {
  local path_parts=("${(@s:/:)PWD}") # Split the current path into an array
  local dir=""
  for part in "${path_parts[@]}"; do
    if [[ -n "${image_map[$part]}" ]]; then
      dir="$part"
    fi
  done

  if [[ -n "$dir" ]]; then
    display_image "$dir"
  else
    display_image "default"
  fi
}

chpwd

function xcargo init() {
  local project_name="$1"
  # Create a new directory with the specified project name
  mkdir "$project_name"
  cd "$project_name"

  # Initialize a new Cargo project
  cargo init --bin .

  # Build and run the project
  cargo run &
  sleep 2

  # Open the project directory in neovim
  nvim .

  # Clean up the built files
  cargo clean
}

function nte() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: n <filename>"
        return 1
    fi

    # Get file extension
    ext="${1##*.}"

    # Define templates for each file type
    case "$ext" in
        "cpp")
            template="#include <iostream>\n\nusing namespace std;\n\nint main() {\n    // your code goes here\n    return 0;\n}"
            ;;
        "html")
            template="td;\n\nint main() {\n    // your code goes here\n    return 0;\n}"
            ;;
        "py")
            template="#!/usr/bin/env python3\n\n# your code goes here"
            ;;
        "sh")
            template="#!/bin/bash\n\n# your code goes here"
            ;;
        "lua")
            template="-- your code goes here"
            ;;
        "rs")
            template="fn main() {\n    // your code goes here\n}"
            ;;
        "go")
            template="package main\n\nimport \"fmt\"\n\nfunc main() {\n    // your code goes here\n}"
            ;;
        "zig")
            template="const std = @import(\"std\");\n\npub fn main() !void {\n    // your code goes here\n}"
            ;;
        "hs")
            template="main = do\n    -- your code goes here\n    return ()"
            ;;
        *)
            echo "Unsupported file type: $ext"
            return 1
            ;;
    esac

    # Generate file with timestamp and template (if available)
    ts=$(date +"%Y%m%d_%H%M%S")
    if [[ -n "$template" ]]; then
        echo -e "$template" > "$ts.$1"
    else
        touch "$ts.$1"
    fi

    # Open file with emacs in the background
    nohup emacs "$ts.$1" >/dev/null 2>&1 &

    # Exit the terminal
    exit
}

function hex() {
    # Get a list of actual binary files in the /usr/bin directory
    local binaries=( $(find /usr/bin -type f -executable -not -name "*.so*" -exec file -i {} \; | grep "charset=binary" | cut -d ":" -f 1) )

    # Prompt the user to select a binary file
    PS3="Select a binary to disassemble: "
    select binfile in "${binaries[@]}"; do
        if [[ -n "$binfile" ]]; then
            # Prompt the user to enter the objdump command
            read -p "Enter objdump command to disassemble $binfile: " objcmd

            # Call the user-specified objdump command on the selected binary file
            $objcmd "$binfile" | less
            break
        else
            echo "Invalid option. Please select a valid binary file."
        fi
    done
}

function package-web-app() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: xapp <url>"
    return 1
  fi

  local url="$1"
  local app_name="$(echo ${url} | sed -E 's/.*\:\/\/([^\/]+)(.*)/\1/')"

  nativefier --name "${app_name}" "${url}" --single-instance && c
  echo "Desktop app for ${url} has been created in the current directory."
}

function lazytest() {
  # Find all Lua and Python files in the current directory
  files=()
  while IFS= read -r -d $'\0' file; do
    files+=("$file")
  done < <(find . -maxdepth 1 -type f \( -iname "*.lua" -o -iname "*.py" \) -print0)

  run_sequentially "${files[@]}"
}

function run_sequentially() {
  local files=("$@")

  for file in "${files[@]}"; do
    echo "Running $file"

    case "${file##*.}" in
      lua)
        interpreter="lua"
        ;;
      py)
        interpreter="python3"
        ;;
      sh)
        interpreter="bash"
        ;;
      *)
        echo "Unsupported file extension for $file"
        continue
        ;;
    esac

    $interpreter "$file" & # Run the script in the background
    wait $!               # Wait for the background process to finish
  done
}

# TODO
#dont wipe the first time
function mesosbu() {
  sudo meson setup --wipe build && sudo meson setup --buildtype=release . build && sudo ninja -C build/ && sudo ninja -C build install
}

next() {
  npx create-next-app "$1"
}
# TODO NEXT-BUILD

# xcompile() {
#   # Use fzf to select a file to compile
#   filename=$(find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.py" -o -name "*.lua" \) | fzf --preview 'bat --color=always {}')

#   # Check if a file was selected
#   if [ -n "$filename" ]
#   then
#     # Create directory if it doesn't exist
#     dir="xcompiled"
#     if [ ! -d "$dir" ]
#     then
#         mkdir "$dir"
#     fi

#     # Move file to the generated directory
#     mv "$filename" "$dir"

#     # Compile and execute the file inside the generated directory
#     cd "$dir"
#     if [[ $filename == *.c ]]
#     then
#         gcc "$filename" -o "${filename%.*}"
#         "./${filename%.*}"
#     elif [[ $filename == *.cpp ]]
#     then
#         g++ "$filename" -o "${filename%.*}"
#         "./${filename%.*}"
#     elif [[ $filename == *.py ]]
#     then
#         python3 "$filename"
#     elif [[ $filename == *.lua ]]
#     then
#         lua "$filename"
#     else
#         echo "Invalid file extension. Please provide a C, C++, Python, or Lua file."
#     fi
#   fi
# }

#gcc -o simple simple.c `pkg-config --libs --cflags gtk+-2.0`

function compile() {
    if [[ -z "$1" ]]; then
        echo "Usage: runc <file>"
        return 1
    fi

    if [[ "${1##*.}" == "c" ]]; then
        gcc -Wall -Wextra -Wpedantic -std=c99 -O2 -o "${1%.*}" "$1" && "./${1%.*}"
    elif [[ "${1##*.}" == "cpp" ]]; then
        g++ -Wall -Wextra -Wpedantic -std=c++17 -O2 -o "${1%.*}" "$1" && "./${1%.*}"
    else
        echo "Error: Unsupported file type"
        return 1
    fi
}

pull-web-site() {
  wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --no-parent $1
}

function screenshot() {
  # Capture screenshot and save it to a temporary file
  local tmp_file="/tmp/screenshot.png"
  maim -s "$tmp_file"

  # Check if the screenshot was captured successfully
  if [ -f "$tmp_file" ]; then
    # Copy the screenshot to the clipboard
    xclip -selection clipboard -t image/png -i "$tmp_file"

    echo "Screenshot captured and copied to clipboard."
  else
    echo "Error capturing the screenshot."
  fi
}

# FIXME
function xshellrp() {
  xshellrp --config ~/.config/linux-discord-rich-presencerc &&
}

function xup() {
  chmod +x "$1" && c
}

function mdir () {
  command mkdir -p "$@" && c "${@: -1}" && c
}

function hown() {
    for file in $@
    do
        cp $file ~/.local/bin/
    done
}

function ex()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

unrar() {
    if [ -z "$1" ]; then
        echo "Please provide a RAR file to extract."
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "The provided file does not exist."
        return 1
    fi

    unrar x "$1"
}

function untar() {
  if [ -f "$1" ]; then
    tar -xvf "$1" && c
  else
    echo "$1 is not a valid tar archive"
  fi
}

function z() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    clear && cd "$dir"
}

function unvim() {
  # rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
}

function ungit() {
  rmdir .git
  echo "WHAT ARE YOU DOING ?" && sleep 1 && rm .gitignore && c
}

function ungo() {
  rm go.mod
  echo "WHAT ARE YOU DOING ?" && sleep 1 && c
}

function uncargo() {
  # Check if a Cargo.toml file exists in the current directory
  if [ ! -f "Cargo.toml" ]; then
    echo "No Cargo.toml file found in the current directory."
    return 1
  fi

  # Remove the Cargo.toml and Cargo.lock files
  rm -f Cargo.toml Cargo.lock

  # Search for a src directory and rename it to unrusted-src
  if [ -d "src" ]; then
    mv src unrusted-src
    echo "src directory renamed to unrusted-src."
  else
    echo "No src directory found."
  fi
  c
}

function gen () {
  local count=1
  local prefix=${2%.*}

  while [[ $count -le $1 ]]; do
    touch "${prefix}${count}.${2#*.}"
    count=$(( count + 1 ))
  done
}

function ltree() {
  local dir="$1"
  local prompt="${2:-}"
  if [ -z "$prompt" ]; then
    lt "$dir" | less --prompt="e[1me[5mTHIS IS A BIG BOLD MESSAGEe[0m"
  else
    lt "$dir" | less --prompt="$prompt"
  fi
}

function explain() {
  local name=$1
  local def=$(declare -f $name 2>/dev/null)

  case "$name" in
    ltree)
      local desc="Recursive directory listing with optional custom prompt"
      ;;
    lfcd)
      local desc="cd to the parent directory containing a file or directory matching the given pattern"
      ;;
    c)
      local desc="Compile and run a C program with a single command"
      ;;
    *)
      local desc=""
      ;;
  esac

  if [[ -n "$desc" ]]; then
    echo -e "\033[0;33m$desc:\033[0m"
  fi

  if [[ -n "$def" ]]; then
    # echo -e "\033[0;33mDefined in current shell session:\033[0m"
    echo $def | pygmentize -f terminal256 -O style=native
  else
    local info=$(type -a $name 2>/dev/null)

    if [[ -n "$info" ]]; then
      echo -e "\033[0;33m$info:\033[0m"
      echo $(echo $info | cut -d ' ' -f 3-) | head -n 1 | pygmentize -f terminal256 -O style=native
    else
      echo "$name not found"
      return 1
    fi
  fi
}

function forx() {
  local n=$1
  shift
  for i in $(seq 1 $n); do
    eval "$@"
  done
}

function whilex() {
  i=$1
  max=$2
  cmd=$3

  while [ $i -le $max ]; do
    eval "$cmd"
    i=$((i+1))
  done
}

color() {
  # Check if color is set in terminal, otherwise get it from xresources
  if [[ -n "$TERM" ]]; then
    case "$1" in
      black)   color="\033[0;30m" ;;
      red)     color="\033[0;31m" ;;
      green)   color="\033[0;32m" ;;
      yellow)  color="\033[0;33m" ;;
      blue)    color="\033[0;34m" ;;
      purple)  color="\033[0;35m" ;;
      cyan)    color="\033[0;36m" ;;
      white)   color="\033[0;37m" ;;
      *)       color="\033[0m"     ;;
    esac
  elif [[ -n "$XTERM_VERSION" ]]; then
    case "$1" in
      black)   color="\033[0;30m" ;;
      red)     color="\033[0;31m" ;;
      green)   color="\033[0;32m" ;;
      yellow)  color="\033[0;33m" ;;
      blue)    color="\033[0;34m" ;;
      purple)  color="\033[0;35m" ;;
      cyan)    color="\033[0;36m" ;;
      white)   color="\033[0;37m" ;;
      *)       color="\033[0m"     ;;
    esac
  else
    color="\033[0m"
  fi

  # Read input from pipe and colorize it
  while read -r line; do
    echo -e "${color}${line}\033[0m"
  done
}

backup () {
    if [ -z "$1" ]; then
        echo -e "\033[0;31mError: Please specify a file or directory to backup\033[0m"
        return 1
    fi

    local backup_dir="$(pwd)/${1}-backup-$(date +%Y-%m-%d-%H-%M-%S)"
    cp -r "$1" "$backup_dir" && \
    echo -e "\033[0;32m✔ Success: Created backup in $backup_dir\033[0m" && \
    bat "$backup_dir"
}

function lsc() {
  local -A icons=(
    ["rust"]="\033[38;5;214;1m\033[0m"
    ["python"]="\033[38;5;108;1m\033[0m"
    ["haskel"]="\033[38;5;220;1m\033[0m"
    ["cpp"]="\033[38;5;33;1m\033[0m"
  )

  ls -1 --color=auto "$@" | awk '{print length, $0}' | sort -rn | awk -v icons="${icons[*]}" '
    BEGIN {
      split(icons, icon_arr, " ")
      for (i=1; i<=length(icon_arr); i+=2) {
        icon[icon_arr[i]] = icon_arr[i+1]
      }
      default_icon = "\033[38;5;245;1m\033[0m" # Default icon for other directories
      max_len = 0 # initialize variable for longest file name length
    }
    {
      # Get the icon for the current directory (if any)
      if ($0 in icon) {
        current_icon = icon[$0]
      } else {
        current_icon = default_icon
      }

      # Track the length of the longest file or directory name
      if (length($0) > max_len) {
        max_len = length($0)
      }

      # Print the output with the icon
      printf("%s %s\n", current_icon, $0)
    }
    END {
      # Calculate the amount of padding needed to center the text
      padding = int((term_cols - max_len) / 2)
      OFS = ""
      # Print the output with the icon, aligned to the center
      for (i=1; i<=NR; i++) {
        printf("%s %*s\n", $i, padding - length($i), "")
      }
    }
  ' | sed "s/\./🐱/g;s/\//🐾/g" | awk -v term_cols="$(tput cols)" '
    {
      print $0
    }
  '
}

#HACK cd into the clicked dir
function ccx() {
    local dir="$1"
    local full_dir
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    full_dir=$(realpath "$dir")
    clear && cd "$full_dir" && ls --color=always -1 | awk -v pwd="$full_dir" '{ printf "\033]8;;file://localhost" pwd "/" $0 "\007" $0 "\033]8;;\007\n" }'
}

function compile() {
    if [[ -z "$1" ]]; then
        echo "Usage: compile <file>"
        return 1
    fi

    case "${1##*.}" in
        c)
            gcc -Wall -Wextra -Wpedantic -std=c99 -O2 -o "${1%.*}" "$1" && "./${1%.*}"
            ;;
        cpp)
            g++ -Wall -Wextra -Wpedantic -std=c++17 -O2 -o "${1%.*}" "$1" && "./${1%.*}"
            ;;
        py)
            python "$1"
            ;;
        lua)
            lua "$1"
            ;;
        hs)
            ghc -O2 -o "${1%.*}" "$1" && "./${1%.*}"
            ;;
        cs)
            mcs "$1" && mono "${1%.*}.exe"
            ;;
        lisp)
            sbcl --script "$1"
            ;;
        *)
            echo "Error: Unsupported file type"
            return 1
            ;;
    esac
}

function img-resize() {
    if [ $# -ne 3 ]; then
        echo "Usage: xresize <input-file> <width> <height>"
        return 1
    fi

    local input_file="$1"
    local width="$2"
    local height="$3"
    local file_extension="${input_file##*.}"
    local output_file="${input_file%.*}${width}x${height}.${file_extension}"
    local lowercase_file_extension="$(echo "$file_extension" | tr '[:upper:]' '[:lower:]')"

    if [[ "${lowercase_file_extension}" =~ ^(jpg|jpeg|png)$ ]]; then
        convert "${input_file}" -resize "${width}x${height}" "${output_file}"
        echo "Resized ${input_file} to ${output_file}"
    else
        echo "Invalid file extension. Supported formats: jpg, jpeg, png"
        return 1
    fi
}

function render() {
  if [[ -z "$1" ]]; then
    echo "Usage: display <image_file>"
    return 1
  fi

  if ! command -v kitty >/dev/null; then
    echo "Error: 'kitty' terminal emulator is not installed or not in PATH."
    return 1
  fi

  if ! command -v icat >/dev/null; then
    echo "Error: 'icat' feature is not enabled in 'kitty'."
    return 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "Error: File '$1' not found."
    return 1
  fi

  kitty +kitten icat "$1"
}

rmdir() {
  if [ -d "$1" ]; then
    rm -rf "$1"
  else
    echo "Error: '$1' is not a directory"
  fi
}

function mvall() {
  # Get the destination path from the first argument
  dest_path="$1"

  # Create the destination directory if it doesn't exist
  mkdir -p "$dest_path"

  # Move all files and directories in the current directory to the destination directory, excluding .git
  rsync -av --exclude=".git" --remove-source-files . "$dest_path"
}

function cpall() {
  # Get the destination path from the first argument
  dest_path="$1"

  # Create the destination directory if it doesn't exist
  mkdir -p "$dest_path"

  # Copy all files and directories in the current directory to the destination directory, excluding .git
  rsync -av --exclude=".git" . "$dest_path"
}

function rmall () {
  current_dir=$(pwd)
  case "$1" in
    -f)  # remove all files
      noglob find "$current_dir" -mindepth 1 -maxdepth 1 -type f ! -name ".gitignore" -exec rm -f {} +
      ;;
    -d)  # remove all directories
      noglob find "$current_dir" -mindepth 1 -maxdepth 1 -type d ! -name ".git" -exec rm -rf {} +
      ;;
    *)  # remove all files and directories
      noglob find "$current_dir" -mindepth 1 -maxdepth 1 ! -name ".git" -exec rm -rf {} +
      ;;
  esac
}

here=$PWD

function delete_all_ssh_keys() {
    echo "Deleting all local SSH keys..."
    rm -rf ~/.ssh/*
    echo "All local SSH keys have been deleted."
}

function key() {
  case "$1" in
    list)
      # List all SSH keys with Dracula theme
      echo -e "\033[0;35m=== SSH Keys ===\033[0m"
      for file in ~/.ssh/*.pub; do
        echo -e "\033[0;32m$(basename "$file")\033[0m"
      done
      ;;
    edit)
      # Template for editing SSH keys
      echo -e "\033[0;36m=== Edit SSH Keys ===\033[0m"
      echo "TODO: Add your key edit code here"
      ;;
    *)
      # Invalid option
      echo -e "\033[0;31mInvalid option. Usage: key [list|edit]\033[0m"
      ;;
  esac
}

generate_ssh_key_interactive() {
    local email
    local key_name

    echo -e "\033[0;35m======= Generate SSH Key =======\033[0m"

    # Prompt for email
    echo -e "\033[0;36mEnter your email address:\033[0m"
    read email

    # Prompt for key name
    echo -e "\033[0;36mEnter a name for your SSH key:\033[0m"
    read key_name

    if [ -z "$email" ] || [ -z "$key_name" ]; then
        echo -e "\033[0;31mPlease provide an email address and a key name.\033[0m"
        return 1
    fi

    echo -e "\033[0;35m======= Generating SSH Key =======\033[0m"
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$HOME/.ssh/$key_name"

    echo -e "\033[0;35m======= SSH Key Generated =======\033[0m"
    echo -e "\033[0;32mPublic key: $HOME/.ssh/$key_name.pub\033[0m"
    echo -e "\033[0;32mPrivate key: $HOME/.ssh/$key_name\033[0m"

    echo -e "\033[0;35mTo use this SSH key, you can add it to your GitHub account or other remote systems.\033[0m"
}

function iso-init() {
  # Check if archiso package is installed
  if ! command -v mkarchiso &>/dev/null; then
    # Archiso package not found, prompt to install it
    read -p "The 'archiso' package is required but not installed. Do you want to install it? (y/n): " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
      # Install archiso package using sudo pacman
      sudo pacman -S archiso
    else
      echo "Aborted. 'archiso' package not installed."
      return 1
    fi
  fi

  # Set Dracula colorscheme
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  export LS_COLORS="$LS_COLORS:ow=1;36:"

  # Copy archiso configs
  sudo cp -r /usr/share/archiso/configs/releng/ "$here"
}

function iso-build {
  local script_dir="$(dirname "$0")"
  local releng_dir="$(realpath "$script_dir/releng")"
  local output_dir="$PWD/output"

  # Check if the releng_dir exists
  if [[ ! -d $releng_dir ]]; then
    echo -e "\033[31mError: $releng_dir is not a directory\033[0m"
    return 1
  fi

  # Create the output directory if it doesn't exist
  mkdir -p "$output_dir"

  # Build the ISO image
  sudo mkarchiso -v -w "$PWD/iso" -o "$output_dir" "$releng_dir"

  # Display a success message in green
  echo -e "\033[32mSuccess! ISO image has been built in $output_dir/\033[0m"
}

eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh)"

# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

function xrate144() {
  connected_display=$(xrandr | grep ' connected' | awk '{print $1}')
  xrandr --output "$connected_display" --mode 1920x1080 --rate 144
}

function xrate60() {
  local display=$(xrandr | grep ' connected' | awk '{print $1}')
  xrandr --output "$display" --mode 1920x1080 --rate 60
}

function pullpkg() {
  HELPER=${HELPER:-yay} # Set default AUR helper to yay if HELPER variable not defined
  for pkgname in $*; do
    git clone "https://aur.archlinux.org/$pkgname.git"
    cd "$pkgname"
    "$HELPER" --downloadonly --noredownload --noconfirm
    cd ..
  done
}

function pac-analizer() {
	echo -n "All Packages: "
	pacman -Q | wc -l
	echo -n "  Packages: "
	pacman -Qe | wc -l
	echo -n "    Official Packages: "
	pacman -Qen | wc -l
	echo -n "    AUR Packages: "
	pacman -Qem | wc -l
	echo -n "  Dependent Packages: "
	pacman -Qd | wc -l
	echo -n "    Official Dependent Packages: "
	pacman -Qdn | wc -l
	echo -n "    AUR Dependent Packages: "
	pacman -Qdm | wc -l
}

sbus_executed=false

function sbus () {
  if [ "$sbus_executed" = true ]; then
    echo "You just did that... zzzZZzzZZZ"
    :
  else
    # Add your sbus code here
    echo "Function sbus executed"
    # Set the flag variable to true
    sbus_executed=true
  fi
}

#FIXME
function freedom() {
  for package in $(pacman -Qq); do
    license=$(pacman -Qi $package | awk '/License/ { print $3 }')
    if [[ $license =~ "custom:..(noncommercial|nolicense|permissive)" || $license =~ "AGPL" || $license =~ "Apache" || $license =~ "Artistic" || $license =~ "BSD" || $license =~ "CC-BY" || $license =~ "CC-BY-NC" || $license =~ "CC-BY-ND" || $license =~ "CC-BY-SA" || $license =~ "CC-BY-NC-SA" || $license =~ "CDDL" || $license =~ "EPL" || $license =~ "GPL" || $license =~ "LGPL" || $license =~ "MIT" || $license =~ "MPL" || $license =~ "OpenSSL" || $license =~ "Python" || $license =~ "W3C" || $license =~ "Zlib" ]]; then
      echo -e "${package}\t\e[32mFREE\e[0m"
    else
      echo -e "${package}\t\e[31mPROPRIETARY\e[0m"
    fi
  done
}

function allfree() {
  for package in $(pacman -Qq); do
    is_free=$(pacman -Qi $package | grep "License" | grep -q "custom:..free")
    if [[ $is_free -eq 0 ]]; then
      echo -e "${package}\t\e[32mFREE\e[0m"
    else
      echo -e "${package}\t\e[31mPROPRIETARY\e[0m"
    fi
  done
}

function nofree() {
  for package in $(pacman -Qq); do
    license=$(pacman -Qi $package | awk '/License/ { print $3 }')
    if [[ $license =~ "custom:..free" ]]; then
      echo -e "${package}\t\e[32mFREE\e[0m"
    else
      echo -e "${package}\t\e[31mPROPRIETARY\e[0m"
    fi
  done
}

#HACK
envycontrol_menu() {
  local choice
  echo "Select an option:"
  select choice in \
    "Switch to Integrated graphics mode" \
    "Switch to Hybrid graphics mode" \
    "Switch to Nvidia graphics mode" \
    "Enable ForceCompositionPipeline on Nvidia mode" \
    "Enable Coolbits on Nvidia mode" \
    "Setup PCI-Express Runtime D3 (RTD3) Power Management on Hybrid mode" \
    "Restore default Xsetup file" \
    "Revert changes made by EnvyControl" \
    "Quit"
  do
    case $choice in
      "Switch to Integrated graphics mode")
        sudo envycontrol -s integrated
        break
        ;;
      "Switch to Hybrid graphics mode")
        sudo envycontrol -s hybrid
        break
        ;;
      "Switch to Nvidia graphics mode")
        read -p "Enter your Display Manager (gdm, gdm3, sddm, lightdm): " dm
        sudo envycontrol --dm $dm -s nvidia
        break
        ;;
      "Enable ForceCompositionPipeline on Nvidia mode")
        sudo envycontrol --force-comp -s nvidia
        break
        ;;
      "Enable Coolbits on Nvidia mode")
        read -p "Enter Coolbits value (default: 28): " coolbits
        sudo envycontrol --coolbits ${coolbits:-28} -s nvidia
        break
        ;;
      "Setup PCI-Express Runtime D3 (RTD3) Power Management on Hybrid mode")
        read -p "Enter RTD3 value (0-3, default: 2): " rtd3
        sudo envycontrol --rtd3 ${rtd3:-2} -s hybrid
        break
        ;;
      "Restore default Xsetup file")
        sudo envycontrol --reset-sddm
        break
        ;;
      "Revert changes made by EnvyControl")
        sudo envycontrol --reset
        break
        ;;
      "Quit")
        break
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

function set-wm() {
    local program_name="$1"
    local xinitrc_file="/etc/X11/xinit/xinitrc"
    if sudo sed -i "\$s|^exec.*|exec $program_name|" "$xinitrc_file"; then
        echo "Last 'exec' line updated in $xinitrc_file"
    else
        echo "No 'exec' line found in $xinitrc_file"
    fi
}

function start() {
  if [[ -z $1 ]]; then
    startx
  else
    set-wm "$1" && startx
  fi
}

function wm-set() {
    local program_name="$1"
    local xinitrc_file="/etc/X11/xinit/xinitrc"
    if sudo sed -i "\$s|^exec.*|exec $program_name|" "$xinitrc_file"; then
        echo "Last 'exec' line updated in $xinitrc_file"
    else
        echo "No 'exec' line found in $xinitrc_file"
    fi
}

xgeometry() {
  xwininfo_output=$(xwininfo -frame)
  x=$(echo "$xwininfo_output" | awk '/Absolute upper-left X:/ { print $4 }')
  y=$(echo "$xwininfo_output" | awk '/Absolute upper-left Y:/ { print $4 }')
  width=$(echo "$xwininfo_output" | awk '/Width:/ { print $2 }')
  height=$(echo "$xwininfo_output" | awk '/Height:/ { print $2 }')

  echo "X: $x"
  echo "Y: $y"
  echo "Width: $width"
  echo "Height: $height"
}

function xgeometry_focused() {
	focused_window_id=$(xdotool getwindowfocus)
	xwininfo_output=$(xwininfo -id "$focused_window_id")
	x=$(echo "$xwininfo_output" | awk '/Absolute upper-left X:/ { print $4 }')
	y=$(echo "$xwininfo_output" | awk '/Absolute upper-left Y:/ { print $4 }')
	width=$(echo "$xwininfo_output" | awk '/Width:/ { print $2 }')
	height=$(echo "$xwininfo_output" | awk '/Height:/ { print $2 }')
	echo "X: $x"
	echo "Y: $y"
	echo "Width: $width"
	echo "Height: $height"
}

function edit-keys() {
  nvim ~/.config/sxhkd/sxhkdrc
}

function c() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    clear && cd "$dir" && exa -la # &&  ls -l -a | wc -l
}

function dotfiles() {
  c ~/Desktop/pulls/dotfiles/$1
}

# Define color variables
typeset -A config
config=(
  show_hidden  true
)

# Autocompletion function
function _dotfiles() {
    local curcontext="$curcontext" state line
    typeset -A opt_args

    _arguments -C \
        '1: :->files' \
        '*:: :->other'

    case $state in
        files)
            local IFS=$'\n'
            local -a completions
            if [[ ${config[show_hidden]} == true ]]; then
              completions=($(ls -A ~/Desktop/pulls/dotfiles))
            else
              completions=($(ls ~/Desktop/pulls/dotfiles))
            fi
            _describe 'files' completions
            ;;
        other)
            ;;
    esac
}

# Register the function for autocompletion
compdef _dotfiles dotfiles

function sapo() {
  c ~/Desktop/scuola/sapo
}

function mate() {
  c ~/Desktop/scuola/
}

function conf() {
    local config_folder="$HOME/.config"

    if [ -z "$1" ]; then
        cd "$config_folder"
    else
        local target_folder="$config_folder/$1"
        if [ -d "$target_folder" ]; then
            cd "$target_folder"
        else
            echo -e "\e[1;31mError: Directory '$1' does not exist in '$config_folder'.\e[0m"
        fi
    fi
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && c "$dir"
    fi
}

function test() {
    c ~/Desktop/test/$1
}

function learn() {
    c ~/xos/learn/$1
}

function scripts() {
    c ~/xos/scripts/$1
}

function gclone() {
  clear
  if [ $# -lt 1 ]; then
    echo "Usage: gclone <repository> [directory]"
    return 1
  fi

  # Set the repository URL and directory name from the input arguments
  local repo="$1"
  local dir="$2"

  # Display the cloning image inside the terminal using kitty icat
  kitty +kitten icat ~/Desktop/xos/xassets/git.png

  # Use the name of the repository as the directory name if none is provided
  if [ -z "$dir" ]; then
    dir=$(basename "$repo" .git)
  fi

  # Clone the repository into the specified directory and change into the cloned directory
  git clone "$repo" "$dir" && c "$dir"
}

ginit() {
  # Check if `gh` and `git` commands are installed
  command -v gh >/dev/null 2>&1 || { echo >&2 "The 'gh' command is required. Please install it before running this function."; return 1; }
  command -v git >/dev/null 2>&1 || { echo >&2 "The 'git' command is required. Please install it before running this function."; return 1; }

  # Check if repository name is provided
  if [ -z "$1" ]; then
    echo "Please provide a repository name as an argument."
    return 1
  fi

  # Options
  local commit_message="first commit"
  local branch_name="main"

  # Check if directory size exceeds 2 GB
  if [ "$(du -sb . | cut -f1)" -gt $((2*1024*1024*1024)) ]; then
    echo "The directory size exceeds 2 GB. Aborting."
    return 1
  fi

  # Create the repository on GitHub
  echo "Creating repository $1 on GitHub..."
  gh repo create "$1" --public

  # Initialize the local Git repository
  echo "Initializing local Git repository..."
  git init

  # Copy the README.md file to the current directory
  # echo "Copying README.md file..."
  # cp ~/Desktop/test/smart-git/BLANK_README.md README.md
  # cp -R ~/Desktop/test/smart-git/images .


  # Add all files in current directory to the staging area
  echo "Adding all files to the staging area..."
  git add .

  # Commit the changes
  echo "Committing changes..."
  git commit -m "$commit_message"

  # Rename the default branch to main
  echo "Renaming default branch to $branch_name..."
  git branch -M "$branch_name"

  # Set the remote origin to the GitHub repository
  echo "Setting remote origin to GitHub repository..."
  git remote add origin "https://github.com/laluxx/$1.git"

  # Push the changes to the remote repository
  echo "Pushing changes to remote repository..."
  git push -u origin "$branch_name"

  echo "Done!"
}

#FIXME
function clone() {
    src_file="$1"
    dest_dir="$2"
    cp -r "$src_file" "$dest_dir"
    c "$dest_dir" && echo "Your files have been cloned! 🚀"
}

function fork() {
  repo_url=$1

  # Extract the repository name from the URL
  repo_name=${repo_url##*/}

  # Remove the ".git" extension if present
  repo_name=${repo_name%.git}

  # Fork the repository using the gh CLI
  gh repo fork $repo_url

  echo "Forked $repo_name"
}

function origin() {
  gh repo set-default
}

function pulls(){
  c ~/Desktop/pulls
}

#TODO
#0.0.0
function undo_last_command {
  # Check if we're running zsh
  if [[ -n "$ZSH_VERSION" ]]; then
    # Use fc command to access the command history in zsh.
    # The -ln options specify that we want to access the last command in the history list
    # (where "n" is the number of the command you want to access, and "-1" means the last command).
    eval $(fc -ln -1)
  else
    # If we're not running zsh, print an error message and exit.
    echo "This function only works in zsh."
    return 1
  fi
}

#TODO
function rmrepo() {
  repo_name="$1"
  gh repo delete "$repo_name" --yes
}

#TODO
function dd_iso() {
  # Define a function to show the lsblk output with custom formatting and color
  function show_lsblk() {
    lsblk --fs --output NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT | awk '{ printf "\e[1m%-20s %-10s %-10s %-10s %-20s\e[0m\n", $1, $2, $3, $4, $5 }'
  }

  # Define a function to show the ISO file description
  function show_iso_description() {
    if [[ -n $iso ]]; then
      echo -e "\e[1mISO file information:\e[0m"
      isoinfo -d -i "$iso" | sed 's/^/  /'
    fi
  }

  # Use fzf to select an ISO file from the ~/Downloads/iso directory
  iso=$(find ~/Downloads/iso -maxdepth 1 -type f -name "*.iso" | fzf --prompt "Select an ISO file: " \
    --preview-window=right:60% \
    --preview="echo -e \"\e[1mSelected ISO file:\e[0m\n  {}\"; show_iso_description")

  # Exit if no ISO file is selected
  if [[ -z $iso ]]; then
    echo "No ISO file selected."
    return
  fi

  # Use lsblk with custom formatting to select a disk to write to
  disk=$(lsblk --noheadings --list --output NAME,SIZE | fzf --prompt "Select a disk to write to: " \
    --preview-window=right:60% \
    --preview="echo -e \"\e[1mSelected disk:\e[0m\n  {}\"; show_lsblk | grep -E \"(^| ){}($| )\"")

  # Exit if no disk is selected
  if [[ -z $disk ]]; then
    echo "No disk selected."
    return
  fi

  # Print lsblk output with custom formatting and color
  show_lsblk

  # Prompt the user for confirmation before proceeding
  read -rp "Are you sure you want to write $iso to $disk? (y/N) " confirm
  if [[ ! $confirm =~ ^[yY]$ ]]; then
    echo "Aborting."
    return
  fi

  # Use dd to write the selected ISO file to the selected disk
  echo "Writing $iso to $disk..."
  sudo dd bs=4M if="$iso" of="/dev/$disk" status=progress conv=fsync oflag=direct
  echo "Done!"
}

function xos() {
    c ~/Desktop/xos/$1
}

function update-dotfiles() {
    dotfiles_path="$HOME/Desktop/pulls/dotfiles"

    rsync -a "$dotfiles_path"/. "$HOME"/
    echo "Updated dotfiles"
}

function xos-update() {
    xos_path="$HOME/xos"
    dotfiles_repo="https://github.com/laluxx/dotfiles.git"
    destination_dir="$HOME/Desktop/pulls/dotfiles"

    c "$xos_path"

    # Remove the existing dotfiles directory if it exists
    [[ -d dotfiles ]] && rm -rf dotfiles

    gclone "$dotfiles_repo" && cd dotfiles

    # Update destination directory to match the cloned dotfiles
    rsync -a . "$destination_dir"/
    echo "XOS updated"
    # want to ovverride ~/.config folder ? y/n #TODO
}

export GUM_INPUT_CURSOR_FOREGROUND="#FF0"
export GUM_INPUT_PROMPT_FOREGROUND="#9AEDFE"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="➜ "
export GUM_INPUT_WIDTH=80

function gum-commit(){
TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")

# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"

# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

# Commit these changes
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
}

function gum-prompt(){
    gum input --cursor.foreground "#FF0" --prompt.foreground "#0FF" --prompt "* " \
        --placeholder "What's up?" --width 80 --value "Not much, hby?"
}

function gum-input(){
    gum input > answer.txt
}

function gum-password(){
    gum input --password > password.txt
}

function gum-write(){
    gum write > story.txt
}

function gum-filter(){
    echo Strawberry >> flavors.txt
    echo Banana >> flavors.txt
    echo Cherry >> flavors.txt
    cat flavors.txt | gum filter > selection.txt
}

function gum-filter-limit(){
    cat flavors.txt | gum filter --limit 2
}

function gum-filter-no-limit(){
    cat flavors.txt | gum filter --no-limit
}

function gum-choose(){
    echo "Pick a card, any card..."
    CARD=$(gum choose --height 15 {{A,K,Q,J},{10..2}}" "{♠,♥,♣,♦})
    echo "Was your card the $CARD?"
}

function gum-choose-limit(){
    echo "Pick your top 5 songs."
    cat songs.txt | gum choose --limit 5
}

function gum-choose-no-limit(){
    echo "What do you need from the grocery store?"
    cat foods.txt | gum choose --no-limit
}

function gum-choose-100(){
    gum choose {1..100}
}

function gum-confirm(){
    gum confirm && rm file.txt || echo "File not removed"
}

function gum-file(){
    emacs $(gum file $HOME)
}

function gum-spin(){
    gum spin --spinner line --title "Buying Bubble Gum..." -- sleep 5
}

# gum table < flavors.csv | cut -d ',' -f 1

function gum-preatty-print(){
    gum style \
	    --foreground 212 --border-foreground 212 --border double \
	    --align center --width 50 --margin "1 2" --padding "2 4" \
	    'Bubble Gum (1¢)' 'So sweet and so fresh!'
}

# Define Color Schemes
typeset -A color_schemes
color_schemes=(
  'dracula' '#282A36 #F8F8F2 #FF79C6 #F8F8F2'
  'doom-one' '#282c34 #bbc2cf #98be65 #282c34'
  # Format 'name' 'background foreground selection selected_text'
)

# ZSH function for Instant Menu
instant_menu() {
  # Select the color scheme
  local -a colors
  IFS=' ' read -r -A colors <<< "${color_schemes[$1]}"

  # Generate menu
  programs=$(ls /usr/bin | sort -u)
  chosen=$(echo -e "$programs" | instantmenu -i -l 20 -h 30 -w 600 \
      -x $(( ($(xdotool getdisplaygeometry | cut -d ' ' -f1) - 600) / 2 )) \
      -y $(( ($(xdotool getdisplaygeometry | cut -d ' ' -f2) - 600) / 2 )) \
      -nb ${colors[1]} -nf ${colors[2]} -sb ${colors[3]} -sf ${colors[4]})

  # Run chosen program
  [[ -n $chosen ]] && $chosen &
}

# Usage: instant_menu 'dracula'
#        instant_menu 'doom-one'

function wal-set() {
  # Directory to search for wallpapers
  local dir=~/xos/wallpapers/static

  local wallpaper=$(find "$dir" \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f | fzf-tmux --color=16 --height 40% -m --reverse --ansi --cycle)

  # Check if a file was selected
  if [[ -n "$wallpaper" ]]; then
    # Set the wallpaper using wal
    wal -i "${wallpaper}" -q
    echo "Wallpaper set to ${wallpaper}"
  else
    echo "No wallpaper selected."
  fi
}
