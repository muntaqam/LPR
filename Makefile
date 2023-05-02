# OS identification from: https://stackoverflow.com/questions/714100/os-detecting-makefile
OS := $(shell uname -s)

ifeq ($(OS), Darwin) 
  INCLUDE_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/include
  LIB_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/lib
endif
ifeq ($(OS), Linux) 
  INCLUDE_PATH := /util/criterion/include
  LIB_PATH := /util/criterion/lib/x86_64-linux-gnu
endif

CC = gcc
CFLAGS = -Wall -std=c11 -ggdb 
pyramid.o: pyramid.c pyramid.h
	$(CC) -c $(CFLAGS) pyramid.c

test1.o: test1.c pyramid.c
	$(CC) $(CFLAGS) -c  test1.c 

tests.o: tests.c pyramid.h
	$(CC) -c $(DEBUG) $(CFLAGS) -I $(INCLUDE_PATH) tests.c

test2.o: pyramid.c test2.c 
	$(CC) $(CFLAGS) -o test2.c

tests:  pyramid.o tests.o
	$(CC) $(DEBUG) $(CFLAGS) -L $(LIB_PATH) -I $(INCLUDE_PATH) -o tests pyramid.o tests.o -lcriterion
test1: pyramid.o test1.o
	$(CC) $(CFLAGS) -o test1 test1.o pyramid.o

.PHONY: clean
clean:
	rm -rf *~ *.o tests runner *.dSYM
