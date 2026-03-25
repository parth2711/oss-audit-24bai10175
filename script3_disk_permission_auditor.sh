#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Parth Jangir | Reg: 24BAI10175 | Course: OSS
# Description: Uses a for loop to audit system directories and
#              Python-specific paths for permissions and disk usage.

# Array of directories to audit
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib")

echo "DIRECTORY AUDIT REPORT"
echo "----------------------"

# for loop: iterates over each element of the array
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # awk extracts specific fields from ls -ld output
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        # du -sh gives human-readable size; 2>/dev/null suppresses errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-18s => %s %s %s | %s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "$SIZE"
    else
        echo "  $DIR does not exist"
    fi
done

# Python-specific paths audit
echo ""
echo "PYTHON PATHS"
PYTHON_PATHS=("/usr/bin/python3" "/usr/lib/python3" "/usr/local/lib/python3")
for PYPATH in "${PYTHON_PATHS[@]}"; do
    if [ -e "$PYPATH" ]; then
        PERMS=$(ls -ld "$PYPATH" | awk '{print $1}')
        SIZE=$(du -sh "$PYPATH" 2>/dev/null | cut -f1)
        printf "  %-35s => %s | %s\n" "$PYPATH" "$PERMS" "$SIZE"
    else
        printf "  %-35s => NOT FOUND\n" "$PYPATH"
    fi
done
