#Compiler Parameters
cxxDebugFlags:=-Wall	-fexceptions	-g	-std=c++17
cxxReleaseFlags:=-Wall	-fexceptions	-O2	-std=c++17

cDebugFlags:=-Wall	-fexceptions	-g
cReleaseFlags:=-Wall	-fexceptions	-O2

cxxOverriddenSources:=$(shell find source -name "*.cpp")
cOverriddenSources:=$(shell find source -name "*.c")

#Linker Parameters
linkerDebugFlags:= 
linkerReleaseFlags:= 

linkerDebugLibraries:= 
linkerReleaseLibraries:=-s

outputDirectory:=bin

outputDebugFile:=$(outputDirectory)/debug.out
outputReleaseFile:=$(outputDirectory)/release.out

cxxDebugObjects:=$(cxxOverriddenSources:%.cpp=%.od)
cxxReleaseObjects:=$(cxxOverriddenSources:%.cpp=%.o)

cDebugObjects:=$(cOverriddenSources:%.c=%.od)
cReleaseObjects:=$(cOverriddenSources:%.c=%.o)

$(outputDirectory):
	mkdir $(outputDirectory)	;

%.od: %.cpp
	$(CXX)	$(cxxDebugFlags)	-c	$<	-o	$@	;

%.od: %.c
	$(CC)	$(cDebugFlags)	-c	$<	-o	$@	;

%.o: %.cpp
	$(CXX)	$(cxxReleaseFlags)	-c	$<	-o	$@	;

%.o: %.c
	$(CC)	$(cReleaseFlags)	-c	$<	-o	$@	;

debug:	$(cxxDebugObjects)	$(cDebugObjects)	$(outputDirectory)
	$(CXX)	$(linkerDebugFlags)	-o	$(outputDebugFile)	$(cxxDebugObjects)	$(cDebugObjects)	$(linkerDebugLibraries)	;

release:	$(cxxReleaseObjects)	$(cReleaseObjects)	$(outputDirectory)
	$(CXX)	$(linkerReleaseFlags)	-o	$(outputReleaseFile)	$(cxxReleaseObjects)	$(cReleaseObjects)	$(linkerReleaseLibraries)	;

all:
	$(MAKE) debug
	$(MAKE) release	;
