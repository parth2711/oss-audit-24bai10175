#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Parth Jangir | Reg: 24BAI10175 | Course: OSS
# Description: Interactively generates a personalised open source
#              manifesto and saves it to a .txt file.
# Concepts: read, string concatenation, >/>>, date, alias via function

# Alias concept demonstration:
# In a live shell: alias today='date +%d-%B-%Y'
# In a script we use an equivalent function:
today() { date '+%d %B %Y'; }

OUTPUT="manifesto_$(whoami).txt"   # unique filename per user

echo "Answer three questions to generate your manifesto."
echo ""

# read: pauses execution and waits for user input
read -p "1. One open-source tool you use every day: " TOOL
read -p "2. In one word, what does freedom mean to you? " FREEDOM
read -p "3. One thing you would build and share freely: " BUILD

# Validate all three answers were provided
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "Please answer all three questions."; exit 1
fi

AUTHOR=$(whoami)
DATE=$(today)    # calls our alias-equivalent function

# > creates/overwrites file; >> appends each subsequent line
echo "============================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  By: $AUTHOR  |  $DATE" >> "$OUTPUT"
echo "============================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
# String concatenation: variables embedded in echo strings
echo "Every day I use $TOOL — and it costs me nothing." >> "$OUTPUT"
echo "Someone built it openly and shared it freely." >> "$OUTPUT"
echo "That choice, repeated by thousands, built the" >> "$OUTPUT"
echo "foundations that everything I do runs on." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "To me, freedom means $FREEDOM. In software that" >> "$OUTPUT"
echo "means the right to read, change, and pass it on." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "One day I want to build $BUILD and share it freely." >> "$OUTPUT"
echo "============================" >> "$OUTPUT"

echo "Manifesto saved to $OUTPUT"
cat "$OUTPUT"
