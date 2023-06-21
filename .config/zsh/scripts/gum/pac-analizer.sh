#!/usr/bin/env bash

# Function to analyze packages
pac_analizer_glam() {
    # Start a spinner while fetching package data
    gum spin "Analyzing packages 🚀" -- bash -c "
    all=$(pacman -Q | wc -l)
    pkg=$(pacman -Qe | wc -l)
    official_pkg=$(pacman -Qen | wc -l)
    aur_pkg=$(pacman -Qem | wc -l)
    dep_pkg=$(pacman -Qd | wc -l)
    official_dep_pkg=$(pacman -Qdn | wc -l)
    aur_dep_pkg=$(pacman -Qdm | wc -l)
    "

    # Display the data with styling
    gum style --bold "All Packages: $all"
    gum style "  Packages: $pkg"
    gum style "    Official Packages: $official_pkg"
    gum style "    AUR Packages: $aur_pkg"
    gum style "  Dependent Packages: $dep_pkg"
    gum style "    Official Dependent Packages: $official_dep_pkg"
    gum style "    AUR Dependent Packages: $aur_dep_pkg"
}

# Run the function
pac_analizer_glam
