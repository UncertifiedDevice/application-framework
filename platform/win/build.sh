#!/bin/bash
PLATSRCC = shell find platform/win -name "*.c"
PLATSRCCXX = shell find platform/win -name "*.cpp"
mingw32-make all
