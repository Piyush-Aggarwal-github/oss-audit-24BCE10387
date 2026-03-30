#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: Piyush Aggarwal | Reg No: 24BCE10387
# Course: Open Source Software | OSS NGMC Capstone
# Purpose: Check if a FOSS package is installed, display its
#          version and license, and print a philosophy note
#          using a case statement.
# Usage: ./script2_package_inspector.sh [package-name]
#        e.g. ./script2_package_inspector.sh git
# =============================================================

# --- Use command-line argument if provided, else default to 'git' ---
# The Linux Kernel itself isn't a user-space package;
# 'git' and other kernel-adjacent tools are used to demonstrate.
PACKAGE=${1:-"git"}

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR"
echo "  Student: Piyush Aggarwal | Reg: 24BCE10387"
echo "============================================================"
echo "  Inspecting package: $PACKAGE"
echo ""

# --- Detect package manager (rpm-based or debian-based) ---
# This makes the script portable across different Linux distros
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    PKG_MANAGER="unknown"
fi

echo "[ PACKAGE MANAGER DETECTED: $PKG_MANAGER ]"
echo ""

# --- Check if package is installed using if-then-else ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based systems (Fedora, RHEL, CentOS)
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  STATUS: $PACKAGE is INSTALLED."
        echo ""
        echo "[ PACKAGE DETAILS ]"
        # Use grep with extended regex to pull key fields
        rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
            awk -F': ' '{printf "  %-10s: %s\n", $1, $2}'
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install (Fedora/RHEL): sudo dnf install $PACKAGE"
        echo "  To install (CentOS):      sudo yum install $PACKAGE"
    fi

elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # Debian-based systems (Ubuntu, Debian, Kali)
    if dpkg -l "$PACKAGE" &>/dev/null 2>&1 | grep -q "^ii"; then
        echo "  STATUS: $PACKAGE is INSTALLED."
        echo ""
        echo "[ PACKAGE DETAILS ]"
        # Extract version and description
        dpkg -l "$PACKAGE" | grep "^ii" | \
            awk '{printf "  Version : %s\n  Package : %s\n", $3, $2}'
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install (Ubuntu/Debian): sudo apt install $PACKAGE"
    fi

else
    # Fallback: try 'which' to check if the binary exists
    echo "  Package manager not detected. Checking binary..."
    if command -v "$PACKAGE" &>/dev/null; then
        echo "  STATUS: $PACKAGE binary found at: $(which $PACKAGE)"
        # Try to get version using --version flag
        VERSION=$("$PACKAGE" --version 2>/dev/null | head -1)
        echo "  Version info: $VERSION"
    else
        echo "  STATUS: $PACKAGE not found on this system."
    fi
fi

echo ""

# --- Case statement: print philosophy notes about FOSS packages ---
echo "[ OPEN SOURCE PHILOSOPHY NOTE ]"
case "$PACKAGE" in
    git)
        echo "  Git: Created by Linus Torvalds in 2005 after BitKeeper"
        echo "  revoked its free license for Linux kernel developers."
        echo "  Git embodies FOSS — a tool born from the refusal to"
        echo "  accept proprietary dependency."
        ;;
    linux | kernel)
        echo "  Linux Kernel: The foundation of modern computing."
        echo "  GPL v2 ensures the kernel stays free forever —"
        echo "  every user who receives the binary also has the"
        echo "  right to receive and modify the source code."
        ;;
    httpd | apache2)
        echo "  Apache HTTP Server: Powers ~30% of all websites globally."
        echo "  The Apache License 2.0 allows commercial use without"
        echo "  requiring derivative works to be open-sourced."
        ;;
    mysql | mariadb)
        echo "  MySQL/MariaDB: A dual-license model — GPL for open"
        echo "  source use, commercial license for proprietary apps."
        echo "  MariaDB forked from MySQL after Oracle's acquisition."
        ;;
    firefox)
        echo "  Firefox: Mozilla's fight for an open, non-corporate web."
        echo "  MPL 2.0 allows mixing with proprietary code, making it"
        echo "  accessible to a wider range of contributors."
        ;;
    python3 | python)
        echo "  Python: Governed by the PSF License — permissive and"
        echo "  community-driven. No single company controls Python;"
        echo "  it grows through PEPs and community consensus."
        ;;
    vlc)
        echo "  VLC: Born in a French university dorm room. Students"
        echo "  needed a streaming tool — they built one and shared it."
        echo "  Now plays virtually every media format on earth."
        ;;
    libreoffice)
        echo "  LibreOffice: A community fork of OpenOffice after Oracle"
        echo "  acquired Sun Microsystems. Proof that open source"
        echo "  communities can rescue software from corporate neglect."
        ;;
    *)
        echo "  $PACKAGE: An open-source tool contributing to the"
        echo "  global commons of freely available software."
        echo "  Check opensource.org for its license freedoms."
        ;;
esac

echo ""
echo "============================================================"
echo "  'Given enough eyeballs, all bugs are shallow.' — ESR"
echo "============================================================"
