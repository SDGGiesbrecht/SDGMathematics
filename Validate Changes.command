#!/bin/sh

# Find and enter repository.
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PrintHeader () {
    printf "\n\e[0;34m$1\e[0m\n\n"
}
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Refreshing workspace..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

WORKSPACE_STATUS=""
if sh ./Refresh\ Workspace.command ; then
    WORKSPACE_STATUS="--workspace-up-to-date"
fi
if ! sh .Development\ Tools/SDG/Development\ Tools/Validate\ Changes.sh "${WORKSPACE_STATUS}"; then
    echo "Failed!"
    exit 1
fi
