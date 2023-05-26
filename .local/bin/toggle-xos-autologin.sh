#!/bin/bash
AutoLogin() {
  service_file="/etc/systemd/system/getty.target.wants/getty@tty1.service"

  echo "Enter the username:"
  read username

  if [[ -w "$service_file" ]]; then
    if grep -q "ExecStart=-/sbin/agetty -a $username --noclear %I \$TERM" "$service_file"; then
      sed -i "s|ExecStart=-/sbin/agetty -a $username --noclear %I \$TERM|ExecStart=-/sbin/agetty --noclear %I \$TERM|g" "$service_file"
      echo -e "\e[31mOFF\e[0m"
    else
      sed -i "s|ExecStart=-/sbin/agetty --noclear %I \$TERM|ExecStart=-/sbin/agetty -a $username --noclear %I \$TERM|g" "$service_file"
      echo -e "\e[32mON\e[0m"
    fi
    systemctl daemon-reload
  else
    echo "Cannot access $service_file. Run the script with sudo or as root."
  fi
}
AutoLogin
