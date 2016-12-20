#!/bin/sh

# Find and enter repository.
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PrintHeader () {
    printf "\n\e[0;34m$1\e[0m\n"
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
if ! sh .Development\ Tools/SDG/Development\ Tools/Refresh\ Workspace.sh; then
    # Note failure for Validate Changes.command.
    exit 1
fi
