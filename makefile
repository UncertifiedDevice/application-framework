#Compiler Parameters
cxxDebugFlags=-Wall	-fexceptions	-g	-std=c++17
cxxReleaseFlags=-Wall	-fexceptions	-O2	-std=c++17

cDebugFlags=-Wall	-fexceptions	-g
cReleaseFlags=-Wall	-fexceptions	-O2

cxxPlatformSources=$(shell find platform/$(TARGET)/src -name "*.cpp")
cPlatformSources=$(shell find platform/$(TARGET)/src -name "*.c")

cxxCommonSources=$(shell find src -name "*.cpp")
cCommonSources=$(shell find src -name "*.c")

cxxOverriddenSources=$(shell ./override.sh $(cxxPlatformSources) $(cxxCommonSources))
cOverriddenSources=$(shell ./override.sh $(cPlatformSources) $(cCommonSources))

#Linker Parameters
linkerDebugFlags= 
linkerReleaseFlags= 

linkerDebugLibraries=-s
linkerReleaseLibraries=-s

outputDirectory=bin

outputDebugFile=$(outputDirectory)/debug.out
outputReleaseFile=$(outputDirectory)/release.out

cxxDebugObjects=$(cxxOverriddenSources:%.cpp=%.od)
cxxReleaseObjects=$(cxxOverriddenSources:%.cpp=%.o)

cDebugObjects=$(cOverriddenSources:%.c=%.od)
cReleaseObjects=$(cOverriddenSources:%.c=%.o)

$(outputDirectory):
	mkdir $(outputDirectory)

%.od: %.cpp
	$(CXX)	$(cxxDebugFlags)	-c	$<	-o	$@

%.od: %.c
	$(CC)	$(cDebugFlags)	-c	$<	-o	$@

%.o: %.cpp
	$(CXX)	$(cxxReleaseFlags)	-c	$<	-o	$@

%.o: %.c
	$(CC)	$(cReleaseFlags)	-c	$<	-o	$@

debug:	$(cxxDebugObjects)	$(cDebugObjects)	$(outputDirectory)
	$(CXX)	$(linkerDebugFlags)	-o	$(outputDebugFile)	$(cxxDebugObjects)	$(cDebugObjects)	$(linkerDebugLibraries)

release:	$(cxxReleaseObjects)	$(cReleaseObjects)	$(outputDirectory)
	$(CXX)	$(linkerReleaseFlags)	-o	$(outputReleaseFile)	$(cxxReleaseObjects)	$(cReleaseObjects)	$(linkerReleaseLibraries)

all:
	$(MAKE)	-f make.mak debug
	$(MAKE)	-f make.mak release
