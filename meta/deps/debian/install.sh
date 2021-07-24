#!/bin/bash

apps="gawk fzf vim git links2 w3m elinks wget grep tree"

apt-get update 
apt-get install --no-install-recommends ${apps} # that's right, no quotes! Haxx0r l337! :)
