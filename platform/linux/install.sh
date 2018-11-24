#!/bin/bash
if [ "$compiler" = "gcc" ]; then
	sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test;
	sudo apt-get update -qq;
	sudo apt-get install -qq g++-7;
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50;
fi
