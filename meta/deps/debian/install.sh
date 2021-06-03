#!/bin/bash

apps="gawk fzf vim git"

apt-get update 
apt-get install --no-install-recommends ${apps} # that's right, no quotes! Haxx0r l337! :)
