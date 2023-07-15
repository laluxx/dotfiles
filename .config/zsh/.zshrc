if [ -z "$NEOFETCH_RUN_ONCE" ] && [ $(pgrep -cx kitty) -eq 1 ] ; then
    neofetch
fi

function path() {
  local dir_list=$(echo $PATH | sed "s/:/\\n/g")

  # ANSI escape codes for colors and styles
  local highlight_open='\033[1;33m[\033[0m'    # Bold Yellow [
  local highlight_close='\033[1;33m]\033[0m'   # Bold Yellow ]
  local highlight_single_quote='\033[1;31m'\''\033[0m' # Bold Red '

  # Printing the list with colors
  printf "EnvPath${highlight_open}\n"
  printf "${highlight_single_quote}%s${highlight_single_quote},\n" $dir_list | sed "s|^ |/|; s|^|  |"
  printf "${highlight_close}\n"
}

export PATH="$PATH:$HOME/.config/emacs/bin"
export PATH="$PATH:$HOME/.cargo/bin"

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

export ROFI_THEME="/home/l/.cache/wal/colors-rofi-dark.rasi"

source ~/xos/.env_secrets

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # PACMAN path
# source $HOME/.config/zsh/plug/fzf-keybindings.plugins.zsh

# source ~/.cache/wal/colors.sh

#Enable colors and change fallback prompt:
autoload -U colors && colors

# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS1="%{$fg[red]%}[%{$fg_bold[white]%}ERROR%{$fg[red]%}]%{$reset_color%} "

# Fetch all plugins in dir
plugins=(`echo $(ls $ZSH/plugins | sed -z 's/\n/ /g')`)

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
bindkey -s '^e' 'pcmanfm\n'

# below opens a new terminal in current dir
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

# Below to change autosuggestion options
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,bg=#292D3E,bold,underline"	# To get colored completion text
bindkey '^[[Z' autosuggest-accept   # shift tab to accept ghost text
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

export LESS_TERMCAP_mb=$(tput bold; tput setaf 39)
export LESS_TERMCAP_md=$(tput bold; tput setaf 45)
export LESS_TERMCAP_me=$(tput sgr0)

function mdl() {
    local original_dir=$(pwd)
    cd ~/Music

    for url in "$@"; do
        yt-dlp --extract-audio --audio-format mp3 -i --ignore-config  --no-part --no-warnings -w -c -R 15 --output "%(title)s.%(ext)s" "$url"
    done

    cd "$original_dir"
}

declare -A image_map=(
  ["test"]="$HOME/xos/xassets/test.png"
  # ["test"]="$HOME/xos//.png"
  # ["test"]="$HOME/xos//.jpg"
)
# rust, doom, lua, bash, c++, c, haskell, python, test
# .doom.d, emacs, doom, xwal, nix, go, debian, head
# docker, web, react, cutefish, awesome, xos, ai, deepin, welcome, default

function render() {
    display_info=false
    suppress_errors=false

    # Check if there are no arguments
    if [[ $# -eq 0 ]]; then
        echo "Usage: render [-i | --info] [-n | --no-errors] <image_file1> [<image_file2> ...]"
        return 1
    fi

    # Check if the first argument is -i or --info
    if [[ $1 == "-i" ]] || [[ $1 == "--info" ]]; then
        display_info=true
        shift # remove the first argument, so image_file arguments start from $1
    fi

    # Check if the first argument is -n or --no-errors
    if [[ $1 == "-n" ]] || [[ $1 == "--no-errors" ]]; then
        suppress_errors=true
        shift # remove the first argument, so image_file arguments start from $1
    fi

    # Check if 'kitty' is installed
    if ! command -v kitty > /dev/null; then
        echo "Error: 'kitty' terminal emulator is not installed or not in PATH."
        return 1
    fi

    # Loop through the image files
    for image_file in "$@"; do
        # Check if file exists
        if [[ ! -f "$image_file" ]]; then
            if ! $suppress_errors; then
                echo "Error: File '$image_file' not found."
            fi
            continue
        fi

        # Display info if flag is set
        if $display_info; then
            # Get the file size in bytes
            file_size_bytes=$(du -b "$image_file" | cut -f1)
            # Convert file size to kilobytes
            file_size_kb=$((file_size_bytes / 1024))

            # Get image dimensions
            dimensions=$(identify -format "%wx%h" "$image_file" 2>/dev/null)

            # Display file information in color in a single line
            echo -e "\033[1;36m$image_file \033[1;33m[$file_size_kb KB]\033[1;32m [$dimensions]\033[0m"
        fi

        # Render the image
        kitty +kitten icat "$image_file"
    done
}

render_pwd() {
  local path_parts=("${(@s:/:)PWD}") # Split the current path into an array
  local dir=""
  for part in "${path_parts[@]}"; do
    if [[ -n "${image_map[$part]}" ]]; then
      dir="$part"
    fi
  done

  if [[ -n "$dir" ]]; then
    render -n "${image_map[$dir]}"
  else
    render -n "${image_map["default"]}"
  fi
}

render_pwd # run once

#HACK custo function and aliases should work
diffrun() {
        [ -z "$1" ] && { echo "Usage: drun <command> [file/directory]"; return 1; }
        local cmd="$1"
        local target="${2:-$PWD}"
        [ ! -e "$target" ] && { echo "Error: File or directory '$target' not found."; return 1; }
        echo "Monitoring size of '$target' for changes..."
        local prev_size=$(du -sb "$target" | awk '{print $1}')
        while sleep 1; do
            local size=$(du -sb "$target" | awk '{print $1}')
            if [ "$prev_size" -ne "$size" ]; then
            prev_size="$size"
            zsh -c $cmd
            fi
        done
    }

function t() {
    if [[ $# -eq 0 || $# -gt 2 ]]; then
        echo "Usage: t <filename> [<extension>]"
        return 1
    fi

    local filename="$1"
    local ext="$2"
    local template_path=~/xos/config/t/${ext}.${ext}

    # If extension is not specified, just touch the file
    if [[ -z $ext ]]; then
        touch "$filename"
    else
        if [[ ! -f $template_path ]]; then
            echo "Unsupported file type: $ext"
            return 1
        fi

        local final_filename="${filename}.${ext}"
        cp "$template_path" "$final_filename"
    fi
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

penv() {
    case "$1" in
        -s|--source)
            if [ -n "$2" ]; then
                # Create the virtual environment
                python3 -m venv "$2"

                # Source the virtual environment
                source "$2/bin/activate"
            else
                echo "Please provide a name for the environment."
            fi
            ;;
        -d|--delete)
            if [ -n "$2" ]; then
                # Check if in the environment
                if [[ "$VIRTUAL_ENV" == *"$2"* ]]; then
                    echo "Please deactivate the environment before deleting it."
                else
                    # Ask for confirmation before deleting the virtual environment
                    echo "Are you sure you want to delete the virtual environment $2? [y/N] "
                    read confirm
                    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                        rm -rf "$2"
                        echo "Virtual environment $2 deleted."
                    else
                        echo "Operation canceled."
                    fi
                fi
            else
                echo "Please provide the name of the environment to delete."
            fi
            ;;
        -l|--list)
            # List all virtual environments in the current directory
            echo "Virtual environments in the current directory:"
            find . -type d -name "bin" -exec dirname {} \; 2>/dev/null
            ;;
        -q|--quit)
            # Deactivate the current environment
            if [ -n "$VIRTUAL_ENV" ]; then
                deactivate
            else
                echo "No virtual environment is active."
            fi
            ;;
        *)
            echo "Usage:"
            echo "  penv -s, --source <env_name>  # Create and source a virtual environment"
            echo "  penv -d, --delete <env_name>  # Delete a virtual environment"
            echo "  penv -l, --list               # List all virtual environments in the current directory"
            echo "  penv -q, --quit               # Deactivate the current environment"
            ;;
    esac
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

function hown() {
    for file in $@
    do
        cp $file ~/.local/bin/
    done
}

function hownfont() {
    # Set target directory (you may need to adjust this depending on your system)
    target_dir=~/.fonts

    # Create the target directory if it doesn't exist
    [[ -d $target_dir ]] || mkdir -p $target_dir

    if [[ $1 == '-a' ]]; then
        # Find all font files in current directory and subdirectories
        for file in $(find . -iname '*.ttf' -o -iname '*.otf'); do
            # Copy each file to the target directory
            cp $file $target_dir
        done
    else
        # Copy the specified file to the target directory
        cp $1 $target_dir
    fi

    # Update the font cache (needed on some systems)
    fc-cache -f -v
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

function ungit() {
  rmdir .git
  echo "WHAT ARE YOU DOING ?" && sleep 1 && rm .gitignore && c
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

color() {
    local input
    read input
    local color_code

    # Check if the argument is a number
    if [[ $1 =~ ^[0-9]+$ ]]; then
        color_code=$1
    else
        # Convert color name to color code
        case "$1" in
            black) color_code=0 ;;
            red) color_code=1 ;;
            green) color_code=2 ;;
            yellow) color_code=3 ;;
            blue) color_code=4 ;;
            magenta) color_code=5 ;;
            cyan) color_code=6 ;;
            white) color_code=7 ;;
            *) color_code=7 ;; # Default to white if unknown color name
        esac
        color_code=$((color_code + 30))
    fi

    # Print colored text
    echo -e "\033[${color_code}m${input}\033[0m"
}

colortest() {
    echo '256-Color Mode:' | color 14

    # Display color numbers
    for i in {0..255}; do
        print -Pn "%F{$i}${(l:4::0:)i}%f "
        if ((i % 16 == 15)); then
            echo
        fi
    done
}

# Declare an associative array to keep track of included functions
typeset -A included

zconvert() {
    local name=$1

    # Check if function has already been included
    if [[ -n "${included[$name]}" ]]; then
        return
    fi

    # Try to retrieve it as a function
    local func=$(declare -f $name)

    # If it's not a function, try to get it as an alias
    if [[ -z "$func" ]]; then
        func=$(alias $name | sed -E "s/^alias $name='(.*)'/\1/")
        if [[ -z "$func" ]]; then
            echo "No such function or alias: $name"
            return 1
        else
            # Convert alias to function
            func="$name() {\n$func\n}"
        fi
    fi

    # Mark function as included
    included[$name]=1

    # Find function or alias calls in the function's body
    local commands=$(echo "$func" | sed -n -E "s/^[[:space:]]*([a-zA-Z0-9_]+).*/\1/p")

    for command in $commands; do
        # Skip if command is a shell built-in or exists in PATH
        if [[ $(type -t "$command") != "file" ]]; then
            zconvert "$command"
        fi
    done

    # Write the function to the file
    echo "$func" >> "$name"_standalone.zsh

    # Add shebang to the start of the file
    sed -i '1i#!/usr/bin/env zsh' "$name"_standalone.zsh

    # Make the file executable
    chmod +x "$name"_standalone.zsh
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

copied=()
copy() {
  local display_list=false
  local clear_list=false

  # Process options
  while getopts ":lc" opt; do
    case $opt in
      l)
        display_list=true
        ;;
      c)
        clear_list=true
        ;;
      \?)
        echo "Invalid option: -$OPTARG"
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1)) # Remove options from argument list

  # Display copied list
  if $display_list; then
    if [[ ${#copied[@]} -eq 0 ]]; then
      echo "No items have been copied yet."
    else
      echo "Previously copied items:"
      printf '%s\n' "${copied[@]}"
    fi
    return 0
  fi

  # Clear copied list
  if $clear_list; then
    copied=()
    echo "Cleared the list of copied items."
    return 0
  fi

  # If no arguments are provided, use fzf to select files/directories
  if [[ $# -eq 0 ]]; then
    local selected_items=$(ls -A | fzf -m)
    if [[ -n $selected_items ]]; then
      while IFS= read -r item; do
        local source=$(realpath "$item")
        if [[ -e $source ]]; then
          copied+=("$source")
          echo "Copied: $source"
          echo -n "$source" | xclip -selection clipboard # Copy the path to clipboard
        else
          echo "The specified path does not exist: $source"
        fi
      done <<< "$selected_items"
    fi
    return 0
  fi

  # Process file paths
  while [[ $# -gt 0 ]]; do
    local source=$(realpath "$1") # Convert to absolute path

    if [[ ! -e $source ]]; then
      echo "The specified path does not exist: $source"
    else
      copied+=("$source")
      echo "Copied: $source"
      echo -n "$source" | xclip -selection clipboard # Copy the path to clipboard
    fi
    shift
  done
}

paste() { # paste copied dirs/files in other dir
  local destination=$PWD
  local move=false
  if ! command -v fzf &> /dev/null; then
    echo "fzf is required but not installed. Aborting."
    return 1
  fi
  while getopts ":mh" opt; do
    case $opt in
      m)
        move=true
        ;;
      h)
        echo "Usage: paste [-m] [-h] (move)"
        return 0
        ;;
      \?)
        echo "Invalid option: -$OPTARG"
        return 1
        ;;
    esac
  done
  if [[ ${#copied[@]} -eq 0 ]]; then
    echo "No items have been copied yet."
    return 1
  fi
  selected_items=$(printf "%s\n" "${copied[@]}" | splittedfzf --multi)
  if [[ -z "$selected_items" ]]; then
    echo "No items selected. Aborting."
    return 1
  fi
  if [[ $# -gt 0 ]]; then
    destination="$1"
    shift
  fi
  if [[ ! -d $destination ]]; then
    echo "The destination path is not a valid directory: $destination"
    return 1
  fi
  while read -r item; do
    if $move; then
      if [[ -e $item ]]; then
        mv -f "$item" "$destination" 2>/dev/null
        echo "Moved: $item to $destination"
      fi
    else
      if [[ -e $item ]]; then
        cp -rf "$item" "$destination" 2>/dev/null
        echo "Copied: $item to $destination"
      fi
    fi

    # Remove the pasted/moved item from the 'copied' array
    copied=("${copied[@]/$item}") # This line replaces the item with an empty string
    copied=(${copied[@]}) # This line removes empty strings from the array
  done <<< "$selected_items"
}
alias splittedfzf='fzf-tmux -x --height ${FZF_TMUX_HEIGHT:-40%} -m --reverse --ansi'

function mdir () {
  command mkdir -p "$@" && c "${@: -1}" && c
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

function ssh-delete-all-keys() {
    echo "Deleting all local SSH keys..."
    rm -rf ~/.ssh/*
    echo "All local SSH keys have been deleted."
}

function ssh-key-generate-interactive() {
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
  sudo cp -r /usr/share/archiso/configs/releng/ "$PWD"
}

function iso-build {
  local script_dir="$(dirname "$0")"
  local releng_dir="$(realpath "$script_dir/releng")"
  local previous_dir="$(realpath "$script_dir/..")"
  local output_dir="$PWD/output"

  # Check if the releng_dir exists
  if [[ ! -d $releng_dir ]]; then
    # Try to find it in the previous directory
    releng_dir="$previous_dir/releng"
    if [[ -d $releng_dir ]]; then
      echo -e "\033[33mWarning: The releng directory was not found in the initial location. However, it has been found in $releng_dir\033[0m"
      l2 "$previous_dir"
      echo -e -n "\033[32mIs it OK to proceed with this directory? (y/n): \033[0m"
      read answer
      if [[ $answer != "y" ]]; then
        echo -e "\033[31mAborted\033[0m"
        return 1
      fi
    else
      echo -e "\033[31mError: $releng_dir is not a directory\033[0m"
      return 1
    fi
  fi

  # Create the output directory if it doesn't exist
  mkdir -p "$output_dir" 2>/dev/null

  # Build the ISO image
  sudo mkarchiso -v -w "$PWD/iso" -o "$output_dir" "$releng_dir" 2>/dev/null

  # Check if mkarchiso command was successful
  if [ $? -eq 0 ]; then
    # Display a success message in green
    echo -e "\033[32mSuccess! ISO image has been built in $output_dir/\033[0m"
  else
    # Display an error message in red
    echo -e "\033[31mError: ISO image creation failed!\033[0m"
    return 1
  fi
}

eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh)"

function xrate() {
  if [ "$#" -ne 1 ] || ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Usage: xrate [refresh rate]"
    return 1
  fi

  local refresh_rate=$1
  local connected_display=$(xrandr | grep ' connected' | awk '{print $1}')

  xrandr --output "$connected_display" --mode 1920x1080 --rate "$refresh_rate"
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

# get() {
#   no_reinstall=0
#   while getopts "n" opt; do
#     case ${opt} in
#       n)
#         no_reinstall=1
#         ;;
#       \?)
#         echo "Invalid option: $OPTARG" 1>&2
#         ;;
#     esac
#   done
#   shift $((OPTIND -1))

#   for pkg in "$@"
#   do
#     if [[ $no_reinstall -eq 1 && $(yay -Qe $pkg 2>/dev/null) ]]
#     then
#       echo "Package $pkg is already installed and no reinstall is needed."
#     else
#       if yay -S "$pkg"
#       then
#         echo "Package $pkg installed successfully with yay."
#       else
#         echo "yay could not find the package $pkg."
#       fi
#     fi
#   done
# }

get() {
  PACKAGE=$1
  FLAG=$2

  # If no-reinstall flag is specified, check if the package is already installed
  if [[ "$FLAG" == "--no-reinstall" ]]; then
    if pacman -Qs "$PACKAGE" > /dev/null ; then
      echo "$PACKAGE is already installed"
      return 0
    fi
  fi

  # If not installed or if no-reinstall flag is not specified, install the package
  if ! yay -S --noconfirm "$PACKAGE" ; then
    echo "Error installing $PACKAGE"
  fi
}

getall() {
  FILE_PATH="${1}.txt"

  if [ ! -f "$FILE_PATH" ]; then
    echo "File $FILE_PATH does not exist."
    return 1
  fi

  while IFS= read -r PACKAGE
  do
    get "$PACKAGE" --no-reinstall
  done < "$FILE_PATH"
}

pacexport() {
  # Assign the second argument to the output directory, default to the current directory
  OUTPUT_DIRECTORY=${2:-$(pwd)}

  # Check if output directory exists
  if [ ! -d "$OUTPUT_DIRECTORY" ]; then
    echo "Directory $OUTPUT_DIRECTORY does not exist. Creating..."
    mkdir -p "$OUTPUT_DIRECTORY"
  fi

  # Get the list of all explicitly installed packages, format it for easier parsing
  PACKAGES=$(yay -Qqe)

  # Write the output to a file
  echo "$PACKAGES" > "${OUTPUT_DIRECTORY}/${1}.txt"

  echo "Packages exported to ${OUTPUT_DIRECTORY}/${1}.txt"
}

function pacanalize() {
    # Fetch package data
    local all=$(pacman -Q | wc -l)
    local pkg=$(pacman -Qe | wc -l)
    local official_pkg=$(pacman -Qen | wc -l)
    local aur_pkg=$(pacman -Qem | wc -l)
    local dep_pkg=$(pacman -Qd | wc -l)
    local official_dep_pkg=$(pacman -Qdn | wc -l)
    local aur_dep_pkg=$(pacman -Qdm | wc -l)

    # Show spinner
    gum spin --title="Analyzing packages 🚀" -- sleep 1

    # Display the data with styling
    gum style --bold "All Packages: $all"
    gum style "  Packages: $pkg"
    gum style "    Official Packages: $official_pkg"
    gum style "    AUR Packages: $aur_pkg"
    gum style "  Dependent Packages: $dep_pkg"
    gum style "    Official Dependent Packages: $official_dep_pkg"
    gum style "    AUR Dependent Packages: $aur_dep_pkg"
}

pacinfo() {
    if [ $# -eq 0 ]; then
        echo "Error: Please provide at least one package name." | color red
        return 1
    fi

    for pkg in "$@"; do
        local info=$(pacman -Qi $pkg)

        if [ -z "$info" ]; then
            echo "Error: Package '$pkg' not found." | color red
            continue
        fi

        echo -e "\n═══════════════════════════════════════" | color blue
        echo " Package Information for $pkg " | color blue
        echo -e "═══════════════════════════════════════\n" | color blue

        echo "$info" | while read -r line; do
            case "$line" in
                Name*)
                    echo "$line" | color green;;
                Version*)
                    echo "$line" | color purple;;
                Description*)
                    echo "$line" | color yellow;;
                Architecture*)
                    echo "$line" | color cyan;;
                URL*)
                    echo "$line" | color blue;;
                Licenses*)
                    echo "$line" | color green;;
                Groups*)
                    echo "$line" | color yellow;;
                Provides*)
                    echo "$line" | color cyan;;
                Depends*)
                    echo "$line" | color purple;;
                Optional*)
                    echo "$line" | color red;;
                Conflicts*)
                    echo "$line" | color red;;
                Installed*)
                    echo "$line" | color cyan;;
                *)
                    echo "$line" | color white;;
            esac
        done
    done
}

_pacinfo() {
    local state line
    typeset -A opt_args

    _arguments -C \
        '1: :->packages' \
        '*:: :->other'

    case $state in
        packages)
            local -a completions
            completions=($(pacman -Qq))
            _describe 'packages' completions
            ;;
        other)
            ;;
    esac
}

# Register the _pacinfo function for autocompletion with pacinfo
compdef _pacinfo pacinfo

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

function start() {
  if [[ -z $1 ]]; then
    startx
  else
    set-wm "$1" && startx
  fi
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

function autologin() {
        if [[ "$1" == "info" ]]; then
            local tty_number="1"
            local service_file="/etc/systemd/system/getty@tty${tty_number}.service.d/autologin.conf"
            if [[ -f "$service_file" ]]; then
                echo "Auto-login enabled"
            else
                echo "Auto-login disabled"
            fi
        else
            local tty_number="1"
            local service_dir="/etc/systemd/system/getty@tty${tty_number}.service.d"
            local service_file="$service_dir/autologin.conf"
            local current_user=$(whoami)
            if [[ -f "$service_file" ]]; then
                sudo rm "$service_file" && \
                sudo systemctl daemon-reload && \
                echo "Auto-login disabled for tty${tty_number}"
            else
                if [[ ! -d "$service_dir" ]]; then
                    sudo mkdir -p "$service_dir"
                fi
                echo "[Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin $current_user --noclear %I $TERM" | sudo tee "$service_file" > /dev/null
                sudo systemctl daemon-reload && \
                echo "Auto-login enabled for tty${tty_number} with user $current_user"
            fi
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

function xgeometry-focus() {
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

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && c "$dir"
    fi
}

function c() {
    local dir="$1"
    if [[ -z "$dir" ]]; then
        dir="."
    fi

    clear
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
    cd "$dir"

    if [[ "$PWD" == "$HOME" ]]; then
        exa -la
    elif [[ "$PWD" == "$HOME/xos" ]]; then
        exa -la
    elif [[ "$PWD" == "$HOME/Desktop/test" ]]; then
        exa -la
    elif [[ "$PWD" == "$HOME/Desktop/pulls/dotfiles/.config" ]]; then
        exa -la
    else
        local subdir
        local use_l=false
        for subdir in $(find . -maxdepth 1 -type d)
        do
            if [[ $(find $subdir -maxdepth 1 -type d | wc -l) -eq 1 && $(find $subdir -maxdepth 1 -type f | wc -l) -gt 0 ]]; then
                use_l=true
                break
            fi
        done

        if [[ "$use_l" == true ]]; then
            l
        else
            lsd
        fi
    fi
}

# ls() {
#     local dir="$1"
#     if [[ -z "$dir" ]]; then
#         dir="."
#     fi

#     if [[ "$PWD" == "$HOME" ]]; then
#         exa -la
#     elif [[ "$PWD" == "$HOME/xos" ]]; then
#         lsd --tree --depth=2
#     else
#         local subdir
#         local use_l=false
#         for subdir in $(find . -maxdepth 1 -type d)
#         do
#             if [[ $(find $subdir -maxdepth 1 -type d | wc -l) -eq 1 && $(find $subdir -maxdepth 1 -type f | wc -l) -gt 0 ]]; then
#                 use_l=true
#                 break
#             fi
#         done

#         if [[ "$use_l" == true ]]; then
#             l
#         else
#             lsd
#         fi
#     fi
# }

function test() {
    c ~/Desktop/test/$1/$2/$3
}

function script() {
    c ~/xos/script/$1/$2/$3
}

function xos() {
    c ~/xos/$1/$2/$3
}

function dotfiles() {
  c ~/Desktop/pulls/dotfiles/$1/$2/$3
}

function conf() {
  local x=~/.config
  for arg in $@; do
    x+="/$arg"
  done
  if [ -d "$x" ]; then
    cd "$x"
  else
    echo "Directory not found: $x"
  fi
}

_conf() {
  local curcontext="$curcontext" state line
  _path_files -W "$HOME/.config/" && return
  return 1
}
compdef _conf conf

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

gitgo() {
    # Check if inside a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Extract the remote repository URL
        remote_url=$(git config --get remote.origin.url)
        # Convert git URL to HTTPS URL if needed
        if [[ "$remote_url" == git@github.com:* ]]; then
            remote_url=${remote_url/git@github.com:/https://github.com/}
            remote_url=${remote_url%.git}
        fi
        # Open the remote URL in the default web browser
        xdg-open "$remote_url"
    else
        # If not inside a git repository, open the GitHub homepage
        xdg-open "https://github.com"
    fi
}

alias ggo='gitgo'

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

function clone() {
    local github_account="laluxx"
    git clone "https://github.com/${github_account}/$1.git"
}

function origin() {
  gh repo set-default
}

#TODO
function rmrepo() {
  repo_name="$1"
  gh repo delete "$repo_name" --yes
}

function pulls(){
  c ~/Desktop/pulls/$1/$2/$3
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

function xos-update() {
    local xos_path="$HOME/xos"
    local dotfiles_repo="https://github.com/laluxx/dotfiles.git"
    local destination_dir="$HOME/Desktop/pulls/dotfiles"

    # Silently change to the xos directory
    cd "$xos_path" || return 1

    # Remove the existing dotfiles directory if it exists
    [[ -d dotfiles ]] && rm -rf dotfiles

    # Clone the dotfiles repository
    git clone --quiet "$dotfiles_repo" dotfiles || return 1

    # Rsync the dotfiles directory to your local repository
    rsync -a "$xos_path/dotfiles/" "$destination_dir/"

    echo "XOS updated"

    # Call the update-dotfiles function to sync to home directory
    update-dotfiles
}

function update-dotfiles() {
    dotfiles_path="$HOME/Desktop/pulls/dotfiles"

    rsync -a "$dotfiles_path"/. "$HOME"/
    echo "Updated dotfiles"
}

function xos-doctor() {
    sudo lynis audit system
}

# export GUM_INPUT_CURSOR_FOREGROUND=""
export GUM_INPUT_PROMPT_FOREGROUND="#A3F7FF"
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

wal-set () {
    local dir=~/xos/wallpapers/static
    local wallpaper=$(find "$dir" \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f | fzf --height 40% -m --reverse --ansi --cycle)
    if [[ -n "$wallpaper" ]]
    then
        wal -i "${wallpaper}" -q
    else
        echo "No wallpaper selected."
    fi

    theme pywal
}

qr-gen() {       if [ -z "$1" ]; then
        echo "Usage: qrgen <text_or_url>"
        return 1
      fi
      local input="$1"
      local api_url="https://qrenco.de/$input"
      curl -s $api_url || echo "Failed to generate QR Code."
    }

qr-scan() {
    # Create a temporary file to store the screenshot
    tmpfile=$(mktemp /tmp/qr-scan.XXXXXX.png)

    # Take a screenshot of a selected region and save it to the temporary file
    maim -s "$tmpfile"

    # Scan the QR code in the screenshot
    url=$(zbarimg --raw --quiet "$tmpfile")

    # Remove the temporary file
    rm "$tmpfile"

    # Open the URL in the default web browser
    if [ -n "$url" ]; then
        xdg-open "$url"
    else
        echo "No QR code found"
    fi
}

g() {
    if [ "$#" -eq 1 ]; then
        kitty +kitten hyperlinked_grep "$1" | less
    else
        echo "Usage: g <search_text>"
    fi
}

img-rotate() {
    local image_file="$1"
    local rotate_degree=0
    local rotate_step=90

    local temp_file="temp_$image_file"
    cp "$image_file" "$temp_file"

    while true; do
        render "$temp_file"

        read -rsk1 input

        if [[ "$input" == "j" ]]; then
            ((rotate_degree += rotate_step))
            convert "$temp_file" -rotate $rotate_step "$temp_file"
        elif [[ "$input" == "k" ]]; then
            ((rotate_degree -= rotate_step))
            convert "$temp_file" -rotate -$rotate_step "$temp_file"
        elif [[ "$input" == "q" || "$input" == $'\e' ]]; then
            cp "$temp_file" "${rotate_degree}degree-$image_file"
            break
        fi
    done

    mm "$temp_file"
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

hue() {
    local image_file="$1"
    local hue_shift=0
    local hue_step=5

    local temp_file="temp_$image_file"

    while true; do
        convert "$image_file" -modulate 100,100,$((100 + hue_shift)) "$temp_file"
        render "$temp_file"

        read -rsk1 input

        if [[ "$input" == "j" ]]; then
            ((hue_shift += hue_step))
        elif [[ "$input" == "k" ]]; then
            ((hue_shift -= hue_step))
        elif [[ "$input" == "q" || "$input" == $'\e' ]]; then
            cp "$temp_file" "${hue_shift}hue-$image_file"
            break
        fi
    done

    rm "$temp_file"
}

pal-gen() {
  # Get the list of palettes
  local palettes="$(lutgen -p 2>&1)"

  # Allow the user to select palettes using fzf (multiple selections allowed).
  local selected_palettes=$(echo "$palettes" | tr ',' '\n' | fzf --multi)

  # Check if the user made a selection
  if [ -z "$selected_palettes" ]; then
    echo "No palette selected"
    return
  fi

  # Generate a LUT image for each selected palette
  # Here we use a while loop to read through newline-separated values
  while read -r palette; do
    if [ -n "$palette" ]; then
      local trimmed_palette=$(echo $palette | xargs) # Remove leading/trailing whitespaces
      echo "Generating LUT for $trimmed_palette"
      lutgen -p $trimmed_palette -o "${trimmed_palette}_lut.png"
    fi
  done <<< "$selected_palettes"
}

pal () {
   local palettes=("catppuccin-frappe" "catppuccin-latte" "catppuccin-macchiato" "catppuccin-mocha" "catppuccin-oled" "adventuretime" "material-palenight-base16" "palenighthc" "tokyonight-moon" "tokyonight-night" "doomone" "cupcake-base16" "dracula" "espresso" "rose-pine" "rose-pine-dawn" "rose-pine-moon" "mocha-light-terminal-sexy" "mocha-base16" )
    local selected_palettes selected_images apply_wallpaper=false

    while getopts "w" opt; do
        case $opt in
            w) apply_wallpaper=true ;;
            \?) echo "Invalid option: -$OPTARG"
                echo "Usage: pal-apply [-w]"
                return 1 ;;
        esac
    done

    shift $((OPTIND - 1))

    # Select multiple palettes with fzf
    selected_palettes=$(echo "${palettes[@]}" | tr ' ' '\n' | fzf --multi --prompt='Choose palettes: ')

    if [ -z "$selected_palettes" ]; then
        echo "No palettes selected. Exiting."
        return 1
    fi

    # Convert the selected palettes to an array
    selected_palettes=(${(f)selected_palettes})

    selected_images=$(find . -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) | fzf --multi --prompt='Choose images to modify: ')

    if [ -z "$selected_images" ]; then
        echo "No images selected. Exiting."
        return 1
    fi

    # Loop through selected images
    for image in ${(f)selected_images}; do
        # Render the original image only once
        echo "Rendering original image: $image"
        render "$image"

        # Loop through selected palettes
        for palette in "${selected_palettes[@]}"; do
            # Change the output_image format here
            local output_image="${palette}_$(basename "$image")"
            lutgen -p "$palette" apply "$image" -o "$output_image"
            echo "Modified image saved as $output_image"
            echo "Rendering modified image: $output_image"
            render "$output_image"
        done
    done

    if [ "$apply_wallpaper" = true ]; then
        # Note: Only the last modified image will be set as wallpaper
        echo "Setting the last modified image as wallpaper"
        wal -i "$output_image"
    fi
}

renderall() {
    # Set the nullglob option for zsh
    setopt nullglob

    # Loop through jpg and png image files
    for image_file in *.{jpg,png}; do
        # Get the file size in bytes
        file_size_bytes=$(du -b "$image_file" | cut -f1)
        # Convert file size to kilobytes
        file_size_kb=$((file_size_bytes / 1024))

        # Get image dimensions
        dimensions=$(identify -format "%wx%h" "$image_file" 2>/dev/null)

        # Display file information in color in a single line
        # File name in bright cyan, size in yellow, and dimensions in green
        echo -e "\033[1;36m$image_file \033[1;33m[$file_size_kb KB]\033[1;32m [$dimensions]\033[0m"

        # Render the image using 'kitty +kitten icat'
        kitty +kitten icat "$image_file"
    done
}

define () {
    local name=$1
    local def=$(declare -f $name 2>/dev/null)

    if [[ -z "$def" ]]
    then
        echo "$name not found"
        return 1
    fi

    local temp_file_dir="/tmp"
    local temp_file="${temp_file_dir}/${name}.zsh"

    echo "$def" > $temp_file
    nvim $temp_file

    local zshrc_file="${HOME}/Desktop/pulls/dotfiles/.config/zsh/.zshrc.org"

    local start_line=$(grep -n "^* $name" $zshrc_file | cut -d : -f 1)
    if [[ -n "$start_line" ]]
    then
        # Change this line to find the end line of the function's definition
        local end_line=$(grep -n -m 1 -A 1 "^* $name" $zshrc_file | tail -n 1 | cut -d : -f 1)
        if [[ -z "$end_line" ]]
        then
            end_line=$(wc -l < $zshrc_file)
        fi
        sed -i "${start_line},${end_line}d" "$zshrc_file"
    fi

    echo "* $name" >> $zshrc_file
    echo '#+begin_src shell' >> $zshrc_file
    cat $temp_file >> $zshrc_file
    echo '#+end_src' >> $zshrc_file

    rm -vI -f $temp_file

    emacsclient -e "(progn (require 'org) (find-file \"${zshrc_file}\") (org-babel-tangle))"

    update-dotfiles
    exec zsh
}



delete() {
	local name=$1
	local zshrc_file="${HOME}/Desktop/pulls/dotfiles/.config/zsh/.zshrc.org"

	# If no function name is given, get the name of the last function defined
	if [[ -z "$name" ]]; then
		name=$(grep -oP "^* \K\w+" $zshrc_file | tail -n 1)
	fi

	# Get the last start line
	local start_line=$(grep -n "^* $name" $zshrc_file | cut -d : -f 1 | tail -n 1)

	if [[ -n "$start_line" ]]
	then
		# Get lines for "#+end_src" occurring after the function start line
		local end_lines=$(awk -v start="$start_line" 'NR >= start && /#\+end_src/ {print NR}' "$zshrc_file")
		# Select the first of these as the end line
		local end_line=$(echo "$end_lines" | head -n 1)

		# If no end line found, set it to last line of file
		[[ -z "$end_line" ]] && end_line=$(wc -l < "$zshrc_file")

		# Deletes the function from the zshrc file
		sed -i "${start_line},${end_line}d" "$zshrc_file"
	else
		echo "Function $name not found in $zshrc_file"
		return 1
	fi

	# Unsets the function from the current session
	unset -f $name

	# Tangle org file
	emacsclient -e "(progn (require 'org) (find-file \"${zshrc_file}\") (org-babel-tangle))"

	update-dotfiles
	exec zsh
}

typetune-new-theme () {
    destination_directory_base="$HOME/xos/typetune/switches"
    file_types=("ogg" "wav")

    ls $HOME/.local/share/osu-stable/Skins | fzf -m | while IFS= read -r theme_name; do
        if [ -z "$theme_name" ]
        then
            echo "No themes chosen"
            return 1
        fi

        destination_directory="$destination_directory_base/$theme_name"
        mkdir -p "$destination_directory"

        for file_type in "${file_types[@]}"; do
            cp -iv "$HOME/.local/share/osu-stable/Skins/$theme_name/key-delete.${file_type}" \
                   "$HOME/.local/share/osu-stable/Skins/$theme_name/key-press-1.${file_type}" \
                   "$HOME/.local/share/osu-stable/Skins/$theme_name/key-press-2.${file_type}" \
                   "$HOME/.local/share/osu-stable/Skins/$theme_name/key-press-3.${file_type}" \
                   "$HOME/.local/share/osu-stable/Skins/$theme_name/key-press-4.${file_type}" \
                   "$HOME/.local/share/osu-stable/Skins/$theme_name/key-press.${file_type}" \
                   "$destination_directory" 2>/dev/null
        done
    done
}

function typetune-get-sounds() {
    # Specify the source directory
    local source_dir=~/.local/share/osu-stable/Skins/

    # Use rsync to recursively copy .ogg and .wav files
    sync -avm --include='*.wav' --include='*.ogg' -f 'hide,! */' "$source_dir" .
}

brutepaste() {
    current=$(xkb-switch -p)
    setxkbmap us -option caps:none
    xdotool type "$(xclip -o)" && sleep 1
    trap "setxkbmap $current -option caps:none" 0
}

theme() {
  local themes=(
    "palenight"
    "dracula"
    "catppuccin"
    "pywal"
    "rose"
    "oxocarbon"
  )

  local selected_theme

  if [[ -z $1 ]]; then
    selected_theme=$(printf '%s\n' "${themes[@]}" | splittedfzf)
  else
    selected_theme=$1
  fi

  # Save the selected theme name to a file
  echo $selected_theme > ~/xos/theme/.theme

  # Update the fzf theme
  fzf_theme $selected_theme

  # Update the kitty theme if it is not default
  if [ "$selected_theme" != "default" ]; then
    kitty +kitten themes --reload-in=all $selected_theme
  fi
}

fzf_theme() {
  local selected_theme=$1

  case $selected_theme in
    "palenight")
      export FZF_DEFAULT_OPTS="\
      --color=bg+:#292D3E,bg:#292D3E,spinner:#C792EA,hl:#82AAFF \
      --color=fg:#EEFFFF,header:#82AAFF,info:#89DDFF,pointer:#C792EA \
      --color=marker:#C792EA,fg+:#EEFFFF,prompt:#89DDFF,hl+:#82AAFF"
      ;;
    "dracula")
      export FZF_DEFAULT_OPTS="\
      --color=bg+:#282A36,bg:#282A36,spinner:#8BE9FD,hl:#ff79c6 \
      --color=fg:#f8f8f2,header:#BD93F9,info:#8be9fd,pointer:#50fa7b \
      --color=marker:#50fa7b,fg+:#f8f8f2,prompt:#8be9fd,hl+:#ff79c6"
      ;;
    "catppuccin")
      export FZF_DEFAULT_OPTS="\
      --color=bg+:#101213,bg:#101213,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      ;;
    "oxocarbon")
      export FZF_DEFAULT_OPTS="\
      --color=bg+:#161616,bg:#161616,spinner:#FFE585,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#33B1FF,pointer:#FF7EB6 \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      ;;
    "rose")
      export FZF_DEFAULT_OPTS="\
      --color=bg+:#191724,bg:#191724,spinner:#9CCFD8,hl:#EB6F92 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#EABBB9,pointer:#F6C177 \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#C4A7E7"
      ;;
    "pywal")
      export FZF_DEFAULT_OPTS="--color=16"
      ;;
    *)
      echo "Unknown theme. Please specify one of: PALENIGHT, DRACULA, CATPPUCCIN, DEFAULT."
      ;;
  esac
}

if [ -f ~/xos/theme/.theme ]; then
  theme $(cat ~/xos/theme/.theme)
fi
