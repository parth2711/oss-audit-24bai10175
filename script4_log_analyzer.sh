#!/bin/bash
# Script 4: Log File Analyzer
# Author: Parth Jangir | Reg: 24BAI10175 | Course: OSS
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Description: Counts keyword occurrences in a log file and
#              prints the last 5 matches.

LOGFILE=$1             # $1 = first command-line argument
KEYWORD=${2:-"error"}  # $2 = second arg; defaults to 'error'
COUNT=0                # counter variable initialised to 0
LINE_NUM=0

if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"; exit 1
fi

# Do-while style retry: attempt up to 2 times
ATTEMPTS=0
while [ ! -f "$LOGFILE" ] && [ $ATTEMPTS -lt 2 ]; do
    ATTEMPTS=$((ATTEMPTS + 1))
    echo "WARNING: $LOGFILE not found. Attempt $ATTEMPTS..."
    LOGFILE="/var/log/syslog"   # fallback log file
done

if [ ! -f "$LOGFILE" ]; then echo "ERROR: No log file found."; exit 1; fi
if [ ! -s "$LOGFILE" ]; then echo "File is empty."; exit 0; fi

# while-read loop: reads file line by line
# IFS= preserves whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))
    # if-then inside loop: check for keyword match
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # increment counter
    fi
done < "$LOGFILE"

echo "Total lines : $LINE_NUM"
echo "Matches     : $COUNT occurrences of '$KEYWORD'"
echo ""

# Print last 5 matching lines using grep + tail
if [ $COUNT -gt 0 ]; then
    echo "Last 5 matches:"
    grep -i "$KEYWORD" "$LOGFILE" | tail -5
fi
