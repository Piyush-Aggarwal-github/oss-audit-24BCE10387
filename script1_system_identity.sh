#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: Piyush Aggarwal | Reg No: 24BCE10387
# Course: Open Source Software | OSS NGMC Capstone
# Purpose: Display a welcome screen with system information
#          and identify the OS license (Linux Kernel = GPL v2)
# =============================================================

# --- Student and software variables ---
STUDENT_NAME="Piyush Aggarwal"
REG_NO="24BCE10387"
SOFTWARE_CHOICE="Linux Kernel"
LICENSE="GNU General Public License v2 (GPL v2)"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version
ARCH=$(uname -m)                            # Machine architecture
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y')           # Formatted date
CURRENT_TIME=$(date '+%H:%M:%S')           # Current time
HOSTNAME=$(hostname)                        # System hostname

# --- Detect Linux distribution name ---
# /etc/os-release is the standard file for distro info
if [ -f /etc/os-release ]; then
    DISTRO=$(grep ^PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Display the welcome banner ---
echo "============================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT         "
echo "============================================================"
echo "  Student  : $STUDENT_NAME ($REG_NO)"
echo "  Software : $SOFTWARE_CHOICE"
echo "  Date     : $CURRENT_DATE  |  Time: $CURRENT_TIME"
echo "============================================================"
echo ""

# --- System information section ---
echo "[ SYSTEM INFORMATION ]"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Architecture  : $ARCH"
echo "  Hostname      : $HOSTNAME"
echo ""

# --- User information section ---
echo "[ USER INFORMATION ]"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo ""

# --- Uptime and load ---
echo "[ UPTIME & LOAD ]"
echo "  System Uptime : $UPTIME"
echo "  Load Average  : $(cat /proc/loadavg | awk '{print $1, $2, $3}')"
echo ""

# --- License message ---
echo "[ OPEN SOURCE LICENSE ]"
echo "  This system runs the Linux Kernel."
echo "  License: $LICENSE"
echo "  The GPL v2 ensures that the source code remains"
echo "  freely available to all users and that any"
echo "  modifications must also be shared openly."
echo ""
echo "============================================================"
echo "  'Free as in freedom, not free as in free beer.' — RMS"
echo "============================================================"
