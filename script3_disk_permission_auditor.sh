#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: Piyush Aggarwal | Reg No: 24BCE10387
# Course: Open Source Software | OSS NGMC Capstone
# Purpose: Loop through key Linux system directories, report
#          their size, owner, and permissions. Also checks the
#          Linux kernel source/config directories specifically.
# =============================================================

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR"
echo "  Student: Piyush Aggarwal | Reg: 24BCE10387"
echo "  Date   : $(date '+%d %B %Y %H:%M:%S')"
echo "============================================================"
echo ""

# --- List of important system directories to audit ---
# These directories are standard across all Linux systems
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo "[ SYSTEM DIRECTORY AUDIT ]"
echo "------------------------------------------------------------"
printf "%-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (type user group)" "SIZE"
echo "------------------------------------------------------------"

# --- For loop: iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner user, and owner group using awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # Get human-readable disk usage; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "%-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory doesn't exist on this system
        printf "%-20s %-35s\n" "$DIR" "[NOT FOUND on this system]"
    fi
done

echo "------------------------------------------------------------"
echo ""

# --- Check Linux Kernel specific directories ---
echo "[ LINUX KERNEL — SPECIAL DIRECTORY CHECK ]"
echo "------------------------------------------------------------"

# Array of kernel-related directories and config files
KERNEL_PATHS=(
    "/boot"
    "/lib/modules"
    "/proc/version"
    "/proc/cmdline"
    "/etc/modprobe.d"
    "/usr/src"
)

for KPATH in "${KERNEL_PATHS[@]}"; do
    if [ -d "$KPATH" ]; then
        # It's a directory — show permissions and size
        PERMS=$(ls -ld "$KPATH" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$KPATH" 2>/dev/null | cut -f1)
        echo "  DIR  : $KPATH"
        echo "         Permissions: $PERMS | Size: $SIZE"
    elif [ -f "$KPATH" ]; then
        # It's a file — show its content (useful for /proc/version etc.)
        echo "  FILE : $KPATH"
        echo "         Content: $(cat $KPATH 2>/dev/null | head -1)"
    else
        echo "  PATH : $KPATH => [NOT FOUND]"
    fi
    echo ""
done

# --- Show currently loaded kernel modules (top 10) ---
echo "[ CURRENTLY LOADED KERNEL MODULES (top 10) ]"
echo "------------------------------------------------------------"
if command -v lsmod &>/dev/null; then
    # lsmod lists currently loaded modules; awk skips the header line
    lsmod | awk 'NR>1 {printf "  %-25s Size: %s\n", $1, $2}' | head -10
else
    echo "  lsmod not available on this system."
fi

echo ""

# --- Disk usage summary for entire filesystem ---
echo "[ FILESYSTEM DISK USAGE SUMMARY ]"
echo "------------------------------------------------------------"
# df -h shows human-readable sizes for all mounted filesystems
df -h | awk 'NR==1 {print "  "$0} NR>1 {print "  "$0}' | head -10

echo ""
echo "============================================================"
echo "  Audit complete. Linux kernel modules and system dirs"
echo "  are owned by root for security — principle of least privilege."
echo "============================================================"
