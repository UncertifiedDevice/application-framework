DBGLINKFLAGS = 	
RLSLINKFLAGS = 	

DBGFLAGSCXX =	-Wall	-fexceptions	-g	-std=c++17
RLSFLAGSCXX =	-Wall	-fexceptions	-O2	-std=c++17

DBGFLAGSC =	-Wall	-fexceptions	-g
RLSFLAGSC =	-Wall	-fexceptions	-O2

DBGLIBS = -s
RLSLIBS = -s

DIROUT = bin
DBGOUT = bin/debug.out
RLSOUT = bin/release.out

SOURCESCXX := $(shell find . -name "*.cpp")
SOURCESC := $(shell find . -name "*.c")
DBGOBJECTSCXX = $(SOURCESCXX:%.cpp=%.od)
RLSOBJECTSCXX = $(SOURCESCXX:%.cpp=%.o)
DBGOBJECTSC = $(SOURCESC:%.c=%.od)
RLSOBJECTSC = $(SOURCESC:%.c=%.o)
DBGPLATFORMOBJECTSCXX = $(PLATSRCCXX:%.cpp=%.od)
RLSPLATFORMOBJECTSCXX = $(PLATSRCCXX:%.cpp=%.o)
DBGPLATFORMOBJECTSC = $(PLATSRCC:%.c=%.od)
RLSPLATFORMOBJECTSC = $(PLATSRCC:%.c=%.o)

$(DIROUT):
	mkdir $(DIROUT)
	
%.od: %.cpp
	$(CXX)	$(DBGFLAGSCXX)	-c	$<	-o	$@
	
%.od: %.c
	$(CC)	$(DBGFLAGSC)	-c	$<	-o	$@

%.o: %.cpp
	$(CXX)	$(RLSFLAGSCXX)	-c	$<	-o	$@
	
%.o: %.c
	$(CC)	$(RLSFLAGSC)	-c	$<	-o	$@

debug: $(DBGOBJECTSCXX) $(DBGOBJECTSC) $(DIROUT)
	$(CXX)	$(DBGLINKFLAGS)	-o	$(DBGOUT)	$(DBGOBJECTSCXX)	$(DBGPLATFORMOBJECTSCXX)	$(DBGOBJECTSC)	$(DBGPLATFORMOBJECTSC)	$(DBGLIBS)
	
release: $(RLSOBJECTSCXX) $(RLSOBJECTSC) $(DIROUT)
	$(CXX)	$(RLSLINKFLAGS)	-o	$(RLSOUT)	$(RLSOBJECTSCXX)	$(RLSPLATFORMOBJECTSCXX)	$(RLSOBJECTSC)	$(RLSPLATFORMOBJECTSC)	$(RLSLIBS)
	
all:
	$(info	source	$(SOURCESCXX)	$(SOURCESC))
	$(info	debug	$(DBGOBJECTSCXX)	$(DBGOBJECTSC))
	$(info	release	$(RLSOBJECTSCXX)	$(RLSOBJECTSC))
	$(MAKE)	debug
	$(MAKE)	release
