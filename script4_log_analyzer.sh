#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: Piyush Aggarwal | Reg No: 24BCE10387
# Course: Open Source Software | OSS NGMC Capstone
# Purpose: Read a log file line by line, count occurrences of
#          a keyword, and display a summary with last 5 matches.
# Usage: ./script4_log_analyzer.sh [logfile] [keyword]
#        e.g. ./script4_log_analyzer.sh /var/log/syslog error
#        e.g. ./script4_log_analyzer.sh /var/log/kern.log kernel
# =============================================================

echo "============================================================"
echo "         LOG FILE ANALYZER"
echo "  Student: Piyush Aggarwal | Reg: 24BCE10387"
echo "  Date   : $(date '+%d %B %Y %H:%M:%S')"
echo "============================================================"
echo ""

# --- Accept log file as first argument, keyword as second ---
LOGFILE=$1
KEYWORD=${2:-"error"}    # Default keyword is 'error' if not specified

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  [USAGE] No log file specified."
    echo "  Syntax: ./script4_log_analyzer.sh <logfile> [keyword]"
    echo ""
    echo "  Trying common Linux log files automatically..."
    echo ""

    # Auto-detect available log files (differ between distros)
    for TRYFILE in /var/log/syslog /var/log/messages /var/log/kern.log /var/log/dmesg; do
        if [ -f "$TRYFILE" ]; then
            echo "  Found: $TRYFILE — using this file."
            LOGFILE=$TRYFILE
            break
        fi
    done

    # If still no file found after auto-detection
    if [ -z "$LOGFILE" ]; then
        echo "  No standard log file found. Creating a sample log for demo..."
        # Create a temporary demo log file to demonstrate the script
        LOGFILE="/tmp/demo_kernel.log"
        cat > "$LOGFILE" << 'ENDLOG'
Mar 30 10:01:01 myhost kernel: [    0.000000] Linux version 6.5.0-generic
Mar 30 10:01:02 myhost kernel: [    0.000001] Command line: BOOT_IMAGE=/boot/vmlinuz
Mar 30 10:01:03 myhost kernel: [    0.000100] error: ACPI BIOS error found
Mar 30 10:01:04 myhost kernel: [    0.001000] WARNING: possible circular locking
Mar 30 10:01:05 myhost kernel: [    0.002000] error: failed to load module i915
Mar 30 10:01:06 myhost kernel: [    1.000000] systemd[1]: Starting kernel modules
Mar 30 10:01:07 myhost kernel: [    1.001000] error: module not found: floppy
Mar 30 10:01:08 myhost kernel: [    2.000000] USB device connected
Mar 30 10:01:09 myhost kernel: [    2.001000] error: device timeout on /dev/sda
Mar 30 10:01:10 myhost kernel: [    3.000000] Network interface eth0 up
ENDLOG
        echo "  Demo log created at: $LOGFILE"
    fi
fi

echo ""

# --- Check if log file exists and is readable ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] File '$LOGFILE' not found. Exiting."
    exit 1
fi

# Check if file is empty using -s (true if file has size > 0)
if [ ! -s "$LOGFILE" ]; then
    echo "  [WARNING] The file '$LOGFILE' is empty."
    echo "  Retrying — waiting 2 seconds for file to populate..."
    sleep 2   # Simulate a do-while retry pause
    # Check again after the pause
    if [ ! -s "$LOGFILE" ]; then
        echo "  [ERROR] File is still empty after retry. Exiting."
        exit 1
    fi
fi

echo "[ SCANNING LOG FILE ]"
echo "  File   : $LOGFILE"
echo "  Keyword: '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------"

# --- Counter variable to track matches ---
COUNT=0
LINE_COUNT=0

# --- While-read loop: read log file one line at a time ---
while IFS= read -r LINE; do
    LINE_COUNT=$((LINE_COUNT + 1))    # Increment total line counter

    # Check if current line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))          # Increment match counter
    fi
done < "$LOGFILE"                     # Feed the file into the while loop

echo ""
echo "[ RESULTS ]"
echo "  Total lines scanned : $LINE_COUNT"
echo "  Keyword matches     : $COUNT"
echo "  Match percentage    : $(echo "scale=1; $COUNT * 100 / $LINE_COUNT" | bc 2>/dev/null || echo 'N/A')%"
echo ""

# --- Show the last 5 matching lines ---
echo "[ LAST 5 LINES CONTAINING '$KEYWORD' ]"
echo "------------------------------------------------------------"
if [ "$COUNT" -gt 0 ]; then
    # Use grep to filter matches, then tail to get last 5
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH; do
        echo "  >> $MATCH"
    done
else
    echo "  No lines matched the keyword '$KEYWORD'."
fi

echo ""

# --- Bonus: Summary of all unique keywords found in the log ---
echo "[ COMMON LOG KEYWORDS FOUND IN THIS FILE ]"
echo "------------------------------------------------------------"
for CHECK_WORD in "error" "warning" "fail" "critical" "kernel" "module"; do
    # Count how many times each keyword appears (case-insensitive)
    WORD_COUNT=$(grep -ic "$CHECK_WORD" "$LOGFILE" 2>/dev/null || echo 0)
    printf "  %-12s : %d occurrences\n" "$CHECK_WORD" "$WORD_COUNT"
done

echo ""
echo "============================================================"
echo "  Log analysis complete. Open-source kernel logs are"
echo "  transparent — anyone can audit what their system does."
echo "============================================================"
