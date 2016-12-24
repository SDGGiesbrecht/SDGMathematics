#!/bin/bash

# Find and enter repository.
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PrintHeader () {
    printf "\n\e[0;34m$1\e[0m\n\n"
}
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••
PrintHeader "Checking for development tool updates..."
# ••••••• ••••••• ••••••• ••••••• ••••••• •••••••• ••••••••

# Create “Development Tools” folder.
DEV_TOOLS=".Development Tools"
if [ ! -d "${DEV_TOOLS}" ]; then
    mkdir "${DEV_TOOLS}"
fi
cd "${DEV_TOOLS}"

# Create “Development Tools” folder.
SDG="SDG"
if [ ! -d "${SDG}" ]; then
    git clone https://github.com/SDGGiesbrecht/SDG
fi
cd "${SDG}"
git pull

cd ../..
if ! bash .Development\ Tools/SDG/Development\ Tools/Refresh\ Workspace.sh "$1"; then
    # Note failure for Validate Changes.command.
    exit 1
fi
