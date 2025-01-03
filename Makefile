# Makefile for building the C++ program

CC = g++
CFLAGS = -Wall -g
TARGET = trig_function

all: $(TARGET)

$(TARGET): main.o TrigFunction.o
	$(CC) -o $(TARGET) main.o TrigFunction.o

main.o: main.cpp TrigFunction.h
	$(CC) $(CFLAGS) -c main.cpp

TrigFunction.o: TrigFunction.cpp TrigFunction.h
	$(CC) $(CFLAGS) -c TrigFunction.cpp

clean:
	rm -f *.o $(TARGET)
