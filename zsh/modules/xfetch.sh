#!/bin/zsh

# Define colors
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_WHITE='\033[0;37m'
COLOR_RESET='\033[0m'

# Define separator character
SEPARATOR=" ~ "

# Define information to be fetched
INFORMATION=(
  'os' 'fetch_os'
  'shell' 'fetch_shell'
  'wm' 'fetch_wm'
  'uptime' 'fetch_uptime'
  'gtk' 'fetch_gtk'
  'cpu' 'fetch_cpu'
  'memory' 'fetch_memory'
  'hostname' 'fetch_hostname'
  'kernel' 'fetch_kernel'
  'packages' 'fetch_packages'
  'terminal' 'fetch_terminal'
)

# Define arrays to store fetched data
declare -A OS
declare -A SHELL
declare -A WM
declare -A UPTIME
declare -A GTK
declare -A CPU
declare -A MEMORY
declare -A HOSTNAME
declare -A KERNEL
declare -A PACKAGES
declare -A TERMINAL

# Define helper functions

# Output colored blocks for terminal colors
col() {
  printf '  '
  for i in 1 2 3 4 5 6; do
    printf '\033[9%sm%s' "$i" "${colourblocks:-▅▅}"
  done
  printf '\033[0m\n'
}

# Print a piece of information with an optional separator
print() {
  printf "${COLOR_YELLOW}%6s${COLOR_RESET}%b%s\n" \
    "$1" "$SEPARATOR" "$2"
}

# Fetch functions for each piece of information

fetch_os() {
  local wm=$XDG_CURRENT_DESKTOP
  [ "$wm" ] || wm=$DESKTOP_SESSION
  OS=(name="$ID" wm="$wm")
}

fetch_shell() {
  SHELL=(name="${SHELL##*/}")
}

fetch_wm() {
  local wm
  [ "$wm" ] ||
  for i in /proc/*/comm; do
    read -r c < "$i"
    case $c in
      *bar*|*rc) ;;
      awesome|xmonad*|qtile|sway|i3|[bfo]*box|*wm*) wm=${c%%-*}; break;;
    esac
  done
  WM=(name="${wm##*/}")
}

fetch_uptime() {
  IFS=. read -r uptime _ < /proc/uptime
  d=$((uptime / 60 / 60 / 24))
  up=$(printf %02d:%02d $((uptime / 60 / 60 % 24)) $((uptime / 60 % 60)))
  [ "$d" -gt 0 ] && up="${d}d $up"
  UPTIME=(value="$up")
}

fetch_gtk() {
  local gtk
  while read -r line; do
    eq "$line" 'gtk-theme*' && gtk=${line##*=} && break
  done < "${XDG_CONFIG_HOME:=$HOME/.config}/gtk-3.0/settings.ini"
  GTK=(theme="${gtk# }")
}


fetch_mem() {
  # Try to get the memory information from /proc/meminfo
  local mem
  while read -r line; do
    case $line in
      MemTotal:*) mem=${line##*: } ;;
    esac
  done < /proc/meminfo

  # If /proc/meminfo didn't work, try the `sysctl` command on macOS
  if [ -z "$mem" ]; then
    case $(uname -s) in
      Darwin)
        mem=$(sysctl -n hw.memsize 2>/dev/null)
        ;;
    esac
  fi

  # If we still don't have memory information, return an empty string
  [ -n "$mem" ] && printf '%sB\n' "$mem" || echo ""
}

fetch_host() {
  # Try to get the hostname from /etc/hostname
  local hostname
  if [ -f /etc/hostname ]; then
    hostname=$(< /etc/hostname)
  else
    # If /etc/hostname doesn't exist, use the output of the `hostname` command
    hostname=$(hostname)
  fi

  # If we still don't have a hostname, return an empty string
  [ -n "$hostname" ] && echo "$hostname" || echo ""
}

fetch_os() {
  # Try to get the OS information from the `lsb_release` command
  local os
  if command -v lsb_release > /dev/null; then
    os=$(lsb_release -d | awk -F'\t' '{print $2}')
  else
    # If `lsb_release` is not available, try to get the OS information from /etc/os-release
    if [ -f /etc/os-release ]; then
      os=$(awk -F= '/^PRETTY_NAME=/ {print $2}' /etc/os-release)
    else
      # If /etc/os-release doesn't exist, use the output of the `uname` command
      os=$(uname -s -r -m)
    fi
  fi

  # If we still don't have OS information, return an empty string
  [ -n "$os" ] && echo "$os" || echo ""
}

fetch_packages() {
  # Try to get the number of installed packages from the `dpkg-query` command on Debian-based systems
  local pkgs
  if command -v dpkg-query > /dev/null; then
    pkgs=$(dpkg-query -f '${binary:Package}\n' -W 2> /dev/null | wc -l)
  else
    # If `dpkg-query` is not available, try to get the number of installed packages from the `pkg_info` command on FreeBSD
    if command -v pkg_info > /dev/null; then
      pkgs=$(pkg_info -a 2> /dev/null | wc -l)
    else
      # If `pkg_info` is not available, try to get the number of installed packages from the `pkg_info` command on OpenBSD
      if command -v pkg_info > /dev/null; then
        pkgs=$(pkg_info -q 2> /dev/null | wc -l)
      else
        # If we still don't have package information, return an empty string
        pkgs=""
      fi
    fi
  fi

  echo "$pkgs"
}

fetch_cpu() {
  local vendor
  local cpu

  # Try to get the CPU information from /proc/cpuinfo
  while read -r line; do
    case $line in
      vendor_id*) vendor=${line##*: } ;;
      model\ name*) cpu=${line##*: } ;;
    esac
  done < /proc/cpuinfo

  # If /proc/cpuinfo didn't work, try /var/run/dmesg.boot for FreeBSD and OpenBSD
  if [ -z "$vendor" ] || [ -z "$cpu" ]; then
    case $(uname -s) in
      FreeBSD)
        while read -r line; do
          case $line in
            CPU:*)
              cpu=${line#CPU: }
              cpu=${cpu%%@*}
              cpu=${cpu%%[[:space:]]*}
              ;;
            *Origin=*)
              vendor=${line#*Origin=\"}
              vendor=${vendor%%\"*}
              ;;
          esac
        done < /var/run/dmesg.boot
        ;;
      OpenBSD)
        while read -r line; do
          case $line in
            *CPU0*)
              cpu=${line##*: }
              cpu=${cpu%%@*}
              cpu=${cpu%%[[:space:]]*}
              ;;
            *Authentic*)
              vendor=${line#*Authentic }
              vendor=${vendor%% *}
              ;;
          esac
        done < /var/run/dmesg.boot
        ;;
    esac
  fi

  # If both /proc/cpuinfo and /var/run/dmesg.boot failed, try the `sysctl` command
  if [ -z "$vendor" ] || [ -z "$cpu" ]; then
    case $(uname -s) in
      Darwin)
        vendor=$(sysctl -n machdep.cpu.vendor)
        cpu=$(sysctl -n machdep.cpu.brand_string)
        ;;
      OpenBSD)
        vendor=$(sysctl -n hw.vendor 2>/dev/null)
        cpu=$(sysctl -n hw.product 2>/dev/null)
        ;;
    esac
  fi

  # Shorten the vendor and cpu strings for better formatting
  vendor=${vendor##*Genuine}
  vendor=${vendor##*Authentic}
  cpu=${cpu%% @*}
  cpu=${cpu##CPU }
  cpu=${cpu##*AMD }
  cpu=${cpu%% with*}

  # Save the vendor and cpu information to the CPU array
  CPU[vendor]=$vendor
  CPU[model]=$cpu
}


