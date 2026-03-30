#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: Piyush Aggarwal | Reg No: 24BCE10387
# Course: Open Source Software | OSS NGMC Capstone
# Purpose: Interactively collect answers from the user and
#          generate a personalised open source manifesto,
#          saved to a .txt file.
# =============================================================

# --- Alias concept demonstration ---
# In a real shell session you would define: alias today='date "+%d %B %Y"'
# Here we achieve the same result via a function (portable in scripts)
today() {
    date '+%d %B %Y'
}

# --- Banner ---
echo "============================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "  Student: Piyush Aggarwal | Reg: 24BCE10387"
echo "  Course : Open Source Software | Linux Kernel Audit"
echo "============================================================"
echo ""
echo "  This script will ask you three questions and compose"
echo "  your personal open source philosophy statement."
echo ""
echo "------------------------------------------------------------"

# --- Interactive user input using 'read' ---
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs — ensure none are empty ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  [ERROR] All three answers are required. Please re-run the script."
    exit 1
fi

# --- Build metadata ---
DATE=$(today)                          # Using our alias-style function
AUTHOR=$(whoami)                       # Current user's login name
OUTPUT="manifesto_${AUTHOR}.txt"       # Output filename includes username

echo "------------------------------------------------------------"
echo "  Generating your manifesto..."
echo ""

# --- Compose and write the manifesto to a file using > and >> ---
# First line uses > to create/overwrite the file
echo "============================================================" > "$OUTPUT"
echo "         OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Author : Piyush Aggarwal (24BCE10387)" >> "$OUTPUT"
echo "  User   : $AUTHOR" >> "$OUTPUT"
echo "  Date   : $DATE" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- String concatenation to build the manifesto paragraph ---
# Each variable is woven into a flowing philosophical statement
PARA1="I believe in the power of open collaboration. Every day, I rely on $TOOL — "
PARA1+="a tool that exists not because a corporation decided to sell it, but because "
PARA1+="someone chose to share it. That choice changed the world."

PARA2="To me, freedom means $FREEDOM. In the context of software, freedom is not "
PARA2+="just the ability to run a program — it is the right to understand it, improve it, "
PARA2+="and pass those improvements on to others. The Linux Kernel, released under the "
PARA2+="GPL v2, is the greatest demonstration of this principle in human history."

PARA3="One day, I intend to build $BUILD and release it freely. Not because I expect "
PARA3+="nothing in return, but because I understand that I am standing on the shoulders "
PARA3+="of thousands of contributors who built before me without asking for my permission "
PARA3+="or my money. I owe that same generosity to whoever comes next."

PARA4="Open source is not a business model or a licensing technicality. It is a "
PARA4+="philosophy — the belief that knowledge shared multiplies, while knowledge hoarded "
PARA4+="decays. The Linux Kernel proved this at the scale of an operating system. "
PARA4+="I intend to prove it at the scale of my career."

# --- Write paragraphs to file ---
echo "$PARA1" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA2" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA3" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA4" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "  'What one programmer can do in one month, two programmers" >> "$OUTPUT"
echo "   can do in two months.' — Fred Brooks" >> "$OUTPUT"
echo "  'But what the open-source community can do together has" >> "$OUTPUT"
echo "   no comparable quote — because it has no comparable limit.'" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Confirmation and display ---
echo "  [SUCCESS] Manifesto saved to: $OUTPUT"
echo ""
echo "------------------------------------------------------------"
echo "  YOUR MANIFESTO:"
echo "------------------------------------------------------------"
echo ""

# Use cat to display the saved file
cat "$OUTPUT"

echo ""
echo "============================================================"
echo "  Manifesto generation complete."
echo "  File location: $(pwd)/$OUTPUT"
echo "============================================================"
