# Setup Ubuntu

A collection of useful scripts and configs for a quick setup of Ubuntu systems.

## Setup

Download this repository. Since setting up git is part of this, you could use wget:

```bash
cd ~
sudo apt install unzip wget
wget https://github.com/bertan-karacora/setup-ubuntu/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
mv setup-ubuntu-main setup-ubuntu
```

Make sure to give execution permission for the setup script:

```bash
cd setup-ubuntu
chmod +x setup.sh
```

## Installation

1. Run the setup script (without sudo, you do require sudo rights and might be prompted for a password):

    ```bash
    ./setup.sh
    ```

Restart your shell to have it take effect.

## Usage

The system has been setup for you.

You can now use the bash_aliases from `bash_aliases.sh.template`, the functions in any file in the `libs` directory, and the scripts in the `scripts` directory.
