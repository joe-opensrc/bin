#!/bin/bash

#🗀 💽
echo -n "🗀 "
df -hl --output=avail / | tail -n1 | tr -d ' '
