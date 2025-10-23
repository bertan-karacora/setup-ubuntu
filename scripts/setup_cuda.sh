#!/usr/bin/env bash

set -e -u -o pipefail

readonly path_repo="$(dirname $(dirname $(realpath $BASH_SOURCE)))"
source "$path_repo/libs/system_utils.sh"

show_help() {
    echo "Usage:"
    echo "  ./setup_cuda.sh [-h|--help]"
    echo
    echo "Setup CUDA."
    echo
}

parse_args() {
    local arg=""
    while [[ "$#" -gt 0 ]]; do
        arg="$1"
        shift
        case $arg in
        -h | --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option $arg"
            exit 1
            ;;
        esac
    done
}

cleanup() {
    rm cuda*.deb
}

# Check for versions manually:
# See https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local
setup_cuda() {
    echo "Setting up CUDA..."

    if is_installed cuda-toolkit-12-8; then
        echo "CUDA already installed"
        return 0
    fi

    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg --install cuda-keyring_1.1-1_all.deb
    sudo apt-get update
    sudo apt-get --quiet --assume-yes install cuda-toolkit-12-8
    
    cleanup

    echo "Setting up CUDA finished"
}

setup_cudnn() {
    echo "Setting up cuDNN..."

    if is_installed cudnn9-cuda-12; then
        echo "cuDNN already installed"
        return 0
    fi

    sudo apt-get --quiet --assume-yes update
    sudo apt-get --quiet --assume-yes install zlib1g
    sudo apt-get --quiet --assume-yes install cudnn9-cuda-12

    echo "Setting up cuDNN finished"
}

setup_tensorrt() {
    echo "Setting up TensorRT..."

    if is_installed tensorrt; then
        echo "TensorRT already installed"
        return 0
    fi

    sudo apt-get --quiet --assume-yes update
    sudo apt-get --quiet --assume-yes install tensorrt

    echo "Setting up TensorRT finished"
}

main() {
    parse_args "$@"
    setup_cuda
    setup_cudnn
    setup_tensorrt
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
