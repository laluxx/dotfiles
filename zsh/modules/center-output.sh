ls -1 --color=auto | awk '{print length, $0}' | sort -rn | awk '{print $2}' | awk '
  BEGIN {
    # Define the lookup table for directory icons
    icons["rust"] = "\033[38;5;214;1m\033[0m"
    icons["python"] = "\033[38;5;108;1m\033[0m"
    icons["haskel"] = "\033[38;5;220;1m\033[0m"
    icons["cpp"] = "\033[38;5;33;1m\033[0m"
  }
  {
    # Get the icon for the current directory (if any)
    icon = icons[$0]
    if (!icon) {
      icon = "\033[38;5;245;1m\033[0m" # Default icon for other directories
    }

    # Print the output with the icon
    printf("%s %s\n", icon, $0)
  }' | sed "s/\./🐱/g;s/\//🐾/g" | awk -v term_cols="$(tput cols)" '
    {
      # Calculate the amount of padding needed to center the text
      padding = int((term_cols - length($0)) / 2)
      printf "%*s%s\n", padding, "", $0
    }'
