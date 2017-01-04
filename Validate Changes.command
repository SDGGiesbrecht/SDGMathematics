#!/bin/bash

# Validate Changes.command
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
# (none yet)
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
# Flags
FAIL="Fail"
SUCCEED="Succeed"
TRUE="True"
False="False"
if [[ "$@" == *"--travis"* ]]; then
    TRAVIS=$TRUE
else
    TRAVIS=$FALSE
fi
if [[ "$@" == *"--skip-refresh"* ]]; then
    SKIP_REFRESH=$TRUE
else
    SKIP_REFRESH=$FALSE
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

Success () {
    PrintLine "\e[0;32m$1\e[0m"
}
Failure () {
    PrintLine "\e[0;31m$1\e[0m"
}
IndividualSuccess () {
    Success "✓ $1"
}
IndividualFailure () {
    Failure "✗ $1"
}

if [ "$SKIP_REFRESH" == "$TRUE" ]; then
    WORKSPACE_STATUS=$SUCCEED
else
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Refreshing workspace..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    WORKSPACE_STATUS=$FAIL
    if bash ./Refresh\ Workspace.command "$1" ; then
        WORKSPACE_STATUS=$SUCCEED
    fi
fi

VALIDATE_CHANGES_CHANGES=$(diff -ar "Validate Changes.command" ".Development Tools/SDG/Validate Changes.command")
if [ "$VALIDATE_CHANGES_CHANGES" != "" ]; then
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Updating “Validate Changes.command”..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    rm -f ".Validate Changes.command"
    cp ".Development Tools/SDG/Validate Changes.command" "Validate Changes.command"

    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Running updated version of “Validate Changes.command”..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    if [ "$TRAVIS" == "$TRUE" ]; then
        bash "Validate Changes.command" "--travis" "--skip-refresh"
    else
        bash "Validate Changes.command" "--skip-refresh"
    fi
    exit $?
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Running unit tests..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    eval "$(curl -sL https://gist.githubusercontent.com/kylef/5c0475ff02b7c7671d2a/raw/9f442512a46d7a2af7b850d65a7e9bd31edfb09b/swiftenv-install.sh)"
    swift -version
    if swift build --verbose; then
        if swift test; then
            Success "Tests succeed."
            exit 0
        else
            Failure "Tests failed."
            exit 1
        fi
    else
        Failure "Build failed."
        exit 1
    fi
fi

swift build
UNIT_TESTS=$FAIL
if swift test; then
    UNIT_TESTS=$SUCCEED
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Proofreading code..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PROOFREAD=$FAIL
if swiftlint lint --strict; then
    PROOFREAD=$SUCCEED
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Regenerating documentation..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

rm -rf build
rm -rf docs
DOCUMENTATION=$FAIL
if [ -d ".Development Tools/jazzy" ]; then
    PrintLine "Using development build of jazzy...\n"
    if .Development\ Tools/jazzy/bin/jazzy --clean --use-safe-filenames; then
        touch docs/.nojekyll
        DOCUMENTATION=$SUCCEED
    fi
else
    PrintLine "Using system installation of jazzy...\n"
    if jazzy --clean --use-safe-filenames; then
        DOCUMENTATION=$SUCCEED
    fi
fi

DOCUMENTATION_VALID=$FAIL
if [ "$TRAVIS" == "$TRUE" ]; then
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Validating documentation..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    rm -rf docs/docsets
    rm -f docs/undocumented.json
    DIFFERENCES=$(diff -ar docs Originals/docs)
    if [ "$DIFFERENCES" == "" ]; then
        DOCUMENTATION_VALID=$SUCCEED
    else
        echo "$DIFFERENCES"
    fi
fi

FILE_HEADERS_VALID=$FAIL
if [ "$TRAVIS" == "$TRUE" ]; then
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
    PrintHeader "Validating file headers..."
    # ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

    DIFFERENCES=$(diff -ar Sources Originals/Sources; diff -ar Tests Originals/Tests)
    if [ "$DIFFERENCES" == "" ]; then
        FILE_HEADERS_VALID=$SUCCEED
    else
        echo "$DIFFERENCES"
    fi
fi

# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Summary"
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

STATUS=$SUCCEED

if [ "$WORKSPACE_STATUS" == "$SUCCEED" ]; then
    IndividualSuccess "Workspace up to date."
else
    IndividualFailure "Workspace out of date. Please run “Refresh Workspace.command”."
    STATUS=$FAIL
fi

if [ "$UNIT_TESTS" == "$SUCCEED" ]; then
    IndividualSuccess "Unit tests pass."
else
    IndividualFailure "Unit tests fail. (See above for details.)"
    STATUS=$FAIL
fi

if [ "$PROOFREAD" == "$SUCCEED" ]; then
    IndividualSuccess "Code passes proofreading tests."
else
    IndividualFailure "Code fails proofreading tests. (See above for details.)"
    STATUS=$FAIL
fi

if [ "$DOCUMENTATION" == "$SUCCEED" ]; then
    IndividualSuccess "Documentation regenerated."
else
    IndividualFailure "Documentation regeneration failed. (See above for details.)"
    STATUS=$FAIL
fi

if [ "$TRAVIS" == "$TRUE" ]; then
    if [ "$DOCUMENTATION_VALID" == "$SUCCEED" ]; then
        IndividualSuccess "Documentation valid."
    else
        IndividualFailure "Travis CI thinks the documentation doesn’t match. Try regenerating documentation with “Validate Changes.command”."
        STATUS=$FAIL
    fi
fi

if [ "$TRAVIS" == "$TRUE" ]; then
    if [ "$FILE_HEADERS_VALID" == "$SUCCEED" ]; then
        IndividualSuccess "File headers valid."
    else
        IndividualFailure "Travis CI thinks the file headers are invalid. Try refreshing the workspace with “Refresh Workspace.command”."
        STATUS=$FAIL
    fi
fi

PrintLine ""
if [ "$STATUS" == "$FAIL" ]; then
    Failure "It looks like there are a few things left to fix.\n"
    exit 1
else
    Success "It looks like this is ready for a pull request!\n"
fi
