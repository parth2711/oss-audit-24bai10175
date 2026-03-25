#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Parth Jangir | Reg No: 24BAI10175
# Course: Open Source Software | Chosen Software: Python
# Description: Checks if a FOSS package is installed, shows
#              its version/license, and prints a philosophy
#              note based on the package name.
# Usage: ./script2_package_inspector.sh
#        (default package is python3)
# ============================================================

# --- Package to inspect (Python is the primary focus) ---
PACKAGE="python3"

echo "============================================================"
echo "            FOSS PACKAGE INSPECTOR"
echo "============================================================"
echo ""

# --- Detect package manager and check installation ---
# Different distros use different package managers
if command -v rpm &>/dev/null; then
    # RPM-based distros: Fedora, RHEL, CentOS
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    # Debian-based distros: Ubuntu, Debian, Mint
    PKG_MANAGER="dpkg"
else
    echo "ERROR: No supported package manager found (rpm or dpkg)."
    exit 1
fi

echo "  Package Manager : $PKG_MANAGER"
echo "  Checking for    : $PACKAGE"
echo ""

# --- Check if package is installed ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # rpm -q returns 0 if installed, non-zero if not
    if rpm -q $PACKAGE &>/dev/null; then
        INSTALLED=true
        VERSION=$(rpm -qi $PACKAGE | grep "^Version" | awk '{print $3}')
        LICENSE_INFO=$(rpm -qi $PACKAGE | grep "^License" | awk '{print $3}')
        SUMMARY=$(rpm -qi $PACKAGE | grep "^Summary" | cut -d: -f2 | xargs)
    else
        INSTALLED=false
    fi
else
    # dpkg -l lists installed packages; grep finds our package
    if dpkg -l $PACKAGE 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        VERSION=$(dpkg -l $PACKAGE | grep "^ii" | awk '{print $3}')
        LICENSE_INFO="PSF-2.0"   # dpkg doesn't always expose license
        SUMMARY="Interactive high-level object-oriented language"
    else
        INSTALLED=false
    fi
fi

# --- Print result based on whether package is found ---
if [ "$INSTALLED" = true ]; then
    echo "  STATUS  : ✔ $PACKAGE is INSTALLED"
    echo "  Version : $VERSION"
    echo "  License : $LICENSE_INFO"
    echo "  Summary : $SUMMARY"
else
    echo "  STATUS  : ✘ $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install Python on your system, run:"
    echo "    RPM-based (Fedora/RHEL) : sudo dnf install python3"
    echo "    DEB-based (Ubuntu)      : sudo apt install python3"
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"

# --- case statement: prints a philosophy note per package ---
case $PACKAGE in
    python3|python)
        echo "  Python: Born in 1991 by Guido van Rossum during a Christmas"
        echo "  holiday project. Designed to be readable and freely shared."
        echo "  The PSF License allows even commercial use without copyleft,"
        echo "  making Python the language that everyone is free to build on."
        ;;
    httpd|apache2)
        echo "  Apache: The web server that democratised the internet."
        echo "  No one company owns it — it belongs to the community."
        ;;
    mysql|mysql-server)
        echo "  MySQL: An example of dual-licensing — GPL for open use,"
        echo "  commercial license for proprietary products. A pragmatic"
        echo "  bridge between FOSS values and business reality."
        ;;
    vlc)
        echo "  VLC: Built by students at École Centrale Paris who wanted"
        echo "  to stream video freely. LGPL/GPL — proof that students"
        echo "  can build tools the whole world uses."
        ;;
    git)
        echo "  Git: Created by Linus Torvalds in 2005 after BitKeeper"
        echo "  revoked its free licence for the Linux project. Open source"
        echo "  enabling open source — a perfect recursive story."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Exists because Netscape released its source code in 1998"
        echo "  rather than letting the web become a proprietary garden."
        ;;
    *)
        echo "  '$PACKAGE': Every open-source package you install carries"
        echo "  the decision of someone to share their work freely."
        echo "  That choice compounds into the infrastructure of the world."
        ;;
esac

echo ""
echo "============================================================"
