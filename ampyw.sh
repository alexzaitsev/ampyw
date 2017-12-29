#!/bin/bash

port="/dev/$(ls /dev | grep cu.wchusbserial)" # should be changed for non-MacOS
# check if device is connected
if [[ "${port}" == "/dev/" ]]; then
    echo "Device is not connected. Exiting..."
    exit
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
bold=$(tput bold)
normal=$(tput sgr0)

# check arguments
action=0
if [ $# -eq 1 ]; then
    if [[ "$1" == "--flash" || "$1" == "-f" ]]; then
        action=1
    elif [[ "$1" == "--pass" || "$1" == "-p" ]]; then
        echo "--pass command must be followed with ampy command"
        exit 1;
    fi
elif [ $# -gt 1 ]; then
    if [[ "$1" == "--pass" || "$1" == "-p" ]]; then
        action=2
    fi
fi

# show help
if [ $# -eq 0 ] || [ $action == 0 ] ; then
    echo -e "${RED}${bold}ampyw v0.1${normal}${NC}";
    echo -e "${GREEN}${bold}Usage:${normal}${NC}";
    echo "./ampyw.sh [COMMAND]";
    echo -e "${GREEN}${bold}Commands:${normal}${NC}";
    echo "--flash or -f = flashes all python files from the folder where this script is located";
    echo "--pass or -p = passes all following commands directly to ampy";
    echo -e "${GREEN}${bold}Examples:${normal}${NC}";
    echo "./ampyw.sh -f";
    echo "./ampyw.sh -p ls";
    echo "./ampyw.sh -p run boot.py";
    exit 1;
fi

# pass commands to ampy
if [ $action == 2 ]; then
    echo ">> ampy --port ${port} ${@:2}"
    eval "ampy --port ${port} ${@:2}"
    exit
fi

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename "$0"` 

# write all py files
for i in "${dir}"/*; do
    if [ -d "$i" ]; then
        echo -e "${RED}${bold}Skipping directory:${NC}${normal} $i"
    elif [ -f "$i" ]; then
        if [[ "$i" == *py ]]; then
            echo -e "${GREEN}${bold}Putting:${NC}${normal} $i"
            eval "ampy --port ${port} put \"$i\""
            sleep 3s
        elif [[ "$i" != "${dir}/${me}" ]]; then
            echo -e "${RED}${bold}Skipping:${NC}${normal} $i"
        fi
    fi
done
