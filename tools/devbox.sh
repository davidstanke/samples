#!/bin/bash

# Script to initialize a GCE VM to use as a developer environment (w/ VS Code remote shell)
# This should be idempotent; it will be set as the startup script for the instance and will run
# on reboot.

mkdir -p ~/gitroot/davidstanke
alias groot="cd ~/gitroot"
alias grood="cd ~/gitroot; cd davidstanke"
