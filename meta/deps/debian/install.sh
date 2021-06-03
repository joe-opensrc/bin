#!/bin/bash

apps="fzf git"

apt-get update 
apt-get install --no-install-recommends "${apps}"
