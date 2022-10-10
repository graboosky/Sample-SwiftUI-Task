#!/bin/bash

set -e
LOG_FILE="./setup.log"
[ -e ${LOG_FILE} ] && rm ${LOG_FILE}
touch ${LOG_FILE}

# functions
run_command() {
    printf "${2}..."
    echo "############################ ${2} (${1}) #####################################" >> ${LOG_FILE}
    eval ${1} >> ${LOG_FILE} 2>&1 || printf "Error, look into '${LOG_FILE}' file\n"
    printf "Done\n"
}

exists() {
    command -v $1 >/dev/null 2>&1
}

setup_after_clone() {
    install_brew_if_needed
    install_swiftlint_if_needed
    install_swiftgen_if_needed
}

install_brew_if_needed() {
    if exists brew; then
        echo "Brew already installed"
    else
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
    fi
}

install_swiftlint_if_needed() {
    if exists swiftlint; then
        echo "SwiftLint aleady installed"
    else
        run_command "brew install swiftlint" "Installing SwiftLint"
    fi
}

install_swiftgen_if_needed() {
    if exists swiftgen; then
        echo "SwiftGen aleady installed"
    else
        run_command "brew install swiftgen" "Installing SwiftGen"
    fi
}

#run
setup_after_clone
