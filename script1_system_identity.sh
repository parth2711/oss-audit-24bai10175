#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Parth Jangir | Reg No: 24BAI10175
# Course: Open Source Software | Chosen Software: Python
# Description: Displays a welcome screen with system info
#              and license details about the OS.
# ============================================================

# --- Student Info (fill in before submission) ---
STUDENT_NAME="Parth Jangir"
REG_NUMBER="24BAI10175"
SOFTWARE_CHOICE="Python"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                          # Linux kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Formatted date
CURRENT_TIME=$(date '+%H:%M:%S')            # Current time

# --- Linux kernel license (always GPL v2) ---
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Display the report ---
echo "============================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT         "
echo "============================================================"
echo ""
echo "  Student  : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------"
echo "  LICENSE"
echo "------------------------------------------------------------"
echo "  This system runs the Linux kernel, which is covered by:"
echo "  $OS_LICENSE"
echo ""
echo "  Python (your audited software) is covered by:"
echo "  Python Software Foundation License v2 (PSF-2.0)"
echo "  It is a permissive license — free to use, modify, and"
echo "  distribute, even in proprietary products."
echo ""
echo "============================================================"
echo "  'With enough eyeballs, all bugs are shallow.'"
echo "                              — Eric S. Raymond"
echo "============================================================"
