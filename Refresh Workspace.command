#!/bin/bash

# Refresh Workspace.command
#
# This source file is part of the SDG open source projects.
#
# Copyright ©2016–2017 Jeremy David Giesbrecht and the SDG contributors.
#
# Soli Deo gloria
#
# Licensed under the Apache License, Version 2.0
# See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

# !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!
# THIS IS A SHARED FILE FROM THE REPOSITORY AT https://github.com/SDGGiesbrecht/SDG.
# CHANGES MUST BE MADE THERE.
# !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!! !!!!!!!

# Find and enter repository.
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
# Configuration Constants
MIN_JAZZY_VER_STR="0.7.4"
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
# Flags
TRUE="True"
FALSE="False"
if [[ "$@" == *"--travis"* ]]; then
    TRAVIS=$TRUE
else
    TRAVIS=$FALSE
fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
   exit 0
fi
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

PrintLine () {
    printf "$1\n"
}
PrintHeader () {
    PrintLine "\n\e[0;34m$1\e[0m\n"
}
PrintError () {
    PrintLine "\n\e[0;31m$1\e[0m\n"
}
PrintPromptLine () {
    PrintLine "\e[0;33m$1\e[0m"
}
PrintPrompt () {
    PrintPromptLine ""
    PrintPromptLine "Attempting to run the following command."
    PrintPromptLine "An administrator password may be required."
    PrintPromptLine ""
    PrintPromptLine "$1"
    PrintPromptLine ""
    PrintPromptLine "For more information, see $2"
    PrintPromptLine ""
}
PrintResult () {
    PrintLine "\e[0;32m$1\e[0m"
}

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Checking for development tool updates..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

DEV_TOOLS=".Development Tools"
if [ ! -d "${DEV_TOOLS}" ]; then
    mkdir "${DEV_TOOLS}"
fi
cd "${DEV_TOOLS}"

SDG="SDG"
if [ ! -d "${SDG}" ]; then
    git clone https://github.com/SDGGiesbrecht/SDG
fi
cd "${SDG}"
git pull
cd ../..

REFRESH_WORKSPACE_CHANGES=$(diff -ar "Refresh Workspace.command" ".Development Tools/SDG/Refresh Workspace.command")
if [ "$REFRESH_WORKSPACE_CHANGES" != "" ]; then
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Updating “Refresh Workspace.command”..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    rm -f .Refresh\ Workspace.command
    cp ".Development Tools/SDG/Refresh Workspace.command" "Refresh Workspace.command"

    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Running updated version of “Refresh Workspace.command”..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    bash "Refresh Workspace.command"
    exit $?
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating file headers..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

if [ "$TRAVIS" == "$TRUE" ]; then
    cp -rf Sources OriginalSources
    cp -rf Tests OriginalTests
fi

cd ".Development Tools/SDG/Update File Headers"
swift build
cd ../../..
.Development\ Tools/SDG/Update\ File\ Headers/.build/debug/Update\ File\ Headers

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating Git’s list of ignored files..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -f .gitignore
cp ".Development Tools/SDG/.gitignore" .gitignore

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating Git attributes..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -f .gitattributes
cp ".Development Tools/SDG/.gitattributes" .gitattributes

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating licence..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -f LICENSE.md
cp ".Development Tools/SDG/LICENSE.md" LICENSE.md

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating contributing guidelines..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -f CONTRIBUTING.md
cp ".Development Tools/SDG/CONTRIBUTING.md" CONTRIBUTING.md

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Checking for updates to SwiftLint (Code proofreader)..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

PrintLine "Checking for Homebrew...\n"
HomebrewIsPresent () {
    if brew --version; then
        return 0
    else
        return 1
    fi
}
if HomebrewIsPresent; then
    PrintLine "\nHomebrew is already installed."
else
    PrintLine "\nHomebrew is not installed yet."
    PrintLine "Installing Homebrew..."
    PrintPrompt "/usr/bin/ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"" "http://brew.sh"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    if HomebrewIsPresent; then
        PrintLine "\nInstallation of Homebrew succeeded."
    else
        PrintError "\nInstallation of Homebrew failed."
        exit 1
    fi
fi

PrintLine "Checking for SwiftLint...\n"
SwiftLintIsPresent () {
    if swiftlint version; then
        return 0
    else
        return 1
    fi
}
if SwiftLintIsPresent; then
    PrintLine "\nSwiftLint is already installed."
else
    PrintLine "\nSwiftLint is not installed yet."

    PrintLine "Installing SwiftLint...\n"
    brew install swiftlint

    if SwiftLintIsPresent; then
        PrintLine "\nInstallation of SwiftLint succeeded."
    else
        PrintError "Installation of SwiftLint failed."
        exit 1
    fi
fi

PrintLine "Updating SwiftLint..."
if brew outdated | grep -q swiftlint; then
    brew upgrade swiftlint
fi

PrintLine "Updating rule list..."
rm -f .swiftlint.yml
cp ".Development Tools/SDG/.swiftlint.yml" .swiftlint.yml

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Checking for updates to Jazzy (Documentation Generator)..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

PrintLine "Checking for Jazzy...\n"
JazzyIsPresent () {
    if jazzy --version; then
        return 0
    else
        return 1
    fi
}
if JazzyIsPresent; then
    PrintLine "\nJazzy is already installed."
else
    PrintLine "\nJazzy is not installed yet."

    PrintLine "Installing Jazzy...\n"
    PrintPrompt "sudo gem install jazzy" "https://github.com/realm/jazzy"
    sudo gem install jazzy

    if JazzyIsPresent; then
        PrintLine "\nInstallation of Jazzy succeeded."
    else
        PrintError "Installation of Jazzy failed."
        exit 1
    fi
fi

PrintLine "Updating Jazzy..."
PrintPrompt "sudo gem update jazzy" "https://github.com/realm/jazzy"
sudo gem update jazzy

Version () {
    echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
}

MIN_JAZZY_VER=$(Version $MIN_JAZZY_VER_STR)
PrintLine "Minimum required version of Jazzy: ${MIN_JAZZY_VER_STR}"

JAZZY_VER_STR=$(jazzy --version | sed -n "s/.*\([0–9]\)/\1/p")
JAZZY_VER=$(Version $JAZZY_VER_STR)
PrintLine "Available version of Jazzy: $JAZZY_VER_STR"

if [ $JAZZY_VER -lt $MIN_JAZZY_VER ]; then
    # Current release of Jazzy is insufficient.

    PrintLine "\nThe available system install of Jazzy does not have all required features."
    PrintLine "A separate development build of Jazzy will be used until the system catches up."

    cd ".Development Tools"
    if [ ! -d jazzy ]; then
        PrintLine "\nDownloading Jazzy...\n"
        git clone https://github.com/realm/jazzy
    fi

    PrintLine "\nUpdating Jazzy...\n"
    cd jazzy
    git pull

    PrintLine "\nRefreshing Jazzy...\n"
    bundle install
    PrintLine "\nJazzy is ready."
    cd ../..
else
    if [ -d ".Development Tools/jazzy" ]; then
        PrintLine "\nThe dedicated development build of Jazzy is no longer necessary."
        PrintLine "Removing it...\n"
        rm -rf ".Development Tools/jazzy"
        PrintLine "\nDedicated build removed. The system install will be used from now on."
    fi
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Updating Travis CI configuration..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -f .travis.yml
cp ".Development Tools/SDG/.travis.yml" .travis.yml

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Refreshing dependencies..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
swift build --clean=dist
swift build --clean
swift build

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Refreshing Xcode project..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
FindXcodeProj () {
    find . -maxdepth 1 -name "*.xcodeproj"
}
XCODE_PROJ=$(FindXcodeProj)
rm -rf $XCODE_PROJ
# Temporary: Remove documentation (until it can be otherwise excluded from the Xcode project)
rm -rf build
if [ "$TRAVIS" == "$TRUE" ]; then
    cp -rf docs originaldocs
fi
rm -rf docs
# End Temporary
swift package generate-xcodeproj --enable-code-coverage
XCODE_PROJ=$(FindXcodeProj)
if grep -q swiftlint "${XCODE_PROJ}/project.pbxproj"; then
    PrintLine "SwiftLint already configured."
else
    PrintLine "Configuring SwiftLint..."
    sed -i '' -e '/   objects = {/a\
SWIFTLINT = {\
    isa = PBXShellScriptBuildPhase;\
    shellPath = /bin/sh;\
    shellScript = swiftlint;\
};' "${XCODE_PROJ}/project.pbxproj"
    sed -i '' -e '/         buildPhases = (/a\
SWIFTLINT,' "${XCODE_PROJ}/project.pbxproj"

fi
PrintLine "Xcode is ready."

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintResult "\nWorkspace refreshed and ready."
XCODE_PROJ_NAME=${XCODE_PROJ:2}
PrintResult "Open “${XCODE_PROJ_NAME}” to work on the project.\n"
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
