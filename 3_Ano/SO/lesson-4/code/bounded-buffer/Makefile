CXX = g++
CXXFLAGS = -Wall -ggdb -pthread

TARGETS = bb-unsafe bb-safe 
OBJS = thread.o utils.o

.PHONY:	all clean cleanall

all: $(TARGETS)

bb-unsafe: main.o fifo-unsafe.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

bb-safe: main.o fifo-mon-safe.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

*.o:	*.h

clean:
	rm -f *.o

cleanall:	clean
	rm -f $(TARGETS) 


ex2: ex2.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

ex3: ex3.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)
