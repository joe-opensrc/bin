#!/bin/bash

apps="gawk vim git dmenu w3m elinks wget grep less coreutils openssl tree"

apk add --update ${apps} # that's right, no quotes! Haxx0r l337! :)
