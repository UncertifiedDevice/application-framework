#!/bin/bash
choco install msys2
(echo ; echo "y" ) | pacman -S msys2-devel
