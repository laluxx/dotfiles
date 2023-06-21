#!/usr/bin/env bash

# Define the OS and distro (you may need to adjust this as per your requirement)
os_release=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

# Function to search packages on Debian
search_debian() {
  local query="$1"
  local packages
  packages=$(apt-cache search "$query" | awk '{print $1}' | gum table --columns package --separator ' ')
  local chosen_package
  chosen_package=$(echo "$packages" | gum choose --prompt "Select a package to install")
  if [ -n "$chosen_package" ]; then
    sudo apt-get install "$chosen_package"
  fi
}

# Function to search packages on Arch
search_arch() {
  local query="$1"
  local packages
  packages=$(pacman -Ss "$query" | awk -F' ' '/^extra/ || /^community/ {print $2}' | gum table --columns package --separator ' ')
  local chosen_package
  chosen_package=$(echo "$packages" | gum choose --prompt "Select a package to install")
  if [ -n "$chosen_package" ]; then
    sudo pacman -S "$chosen_package"
  fi
}

# Main function to search packages based on the OS
search_packages() {
  local query
  query=$(gum input --prompt "Enter the package name to search")
  case "$os_release" in
    Debian*)
      search_debian "$query"
      ;;
    Arch*)
      search_arch "$query"
      ;;
    *)
      echo "Unsupported OS"
      ;;
  esac
}

# Execute the main function
search_packages
