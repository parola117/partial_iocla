CC=gcc
CFLAGS = -g -Wall -fno-PIC
NASM = nasm
AFILES = file.asm
OBJS = $(AFILES:.asm=.o)
ASM_FLAGS = -f elf64 -g
LD=gcc
LDFLAGS = -g -no-pie
BINARIES = file

all : $(BINARIES)

file: $(OBJS) obfuscated.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean: 
	rm -f file.o $(BINARIES) *.s
	rm -f *~ 
