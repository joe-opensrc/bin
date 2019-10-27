#!/bin/bash

df -hl --output=avail / | tail -n1 | tr -d ' '
