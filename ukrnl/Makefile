MAKEFLAGS += --silent

CC	:= i686-elf-g++
LD	:= i686-elf-g++
AS	:= i686-elf-as

OUTDIR	:= ../iso/boot

OBJS	:= kmain
LDSCRPT	:= linker.ld
BINNAME	:= ukrnl.bin

CCFLAGS	:= -ffreestanding -O2 -Wall -Wextra	\
	   -fno-exceptions -fno-rtti -c -march=i686
LDFLAGS	:= -ffreestanding -O2 -nostdlib -lgcc
ASFLAGS	:= 

all: multiboot $(OBJS) link

clean:
	rm *.o

multiboot:
	$(AS) $(ASFLAGS) multiboot.asm -o multiboot.o

$(OBJS):
	$(CC) $(CCFLAGS) $@.cpp 

link:
	$(LD) -T $(LDSCRPT) -o $(OUTDIR)/$(BINNAME) $(LDFLAGS)		\
		multiboot.o $(addsuffix .o,$(OBJS))
	if grub2-file --is-x86-multiboot $(OUTDIR)/$(BINNAME); then	\
		echo multiboot confirmed;				\
	fi
