#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOP=$DIR/..

# set operating system
if [[ "$(uname)" == "Darwin" ]]; then
    OS="Mac"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    OS="Linux"
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
    OS="MinGW"
fi

case $OS in
    Mac)
        SED=gsed
        ;;
    *)
        SED=sed
        ;;
esac



find . -type f -name '*.vim' | xargs -I{} $SED -i 's/fzf#exec/skim#exec/g;s/fzf#run/skim#run/g;s/+m/--no-multi/g' {}
