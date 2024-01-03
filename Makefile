MAKEFLAGS += --silent

OUTDIR		:= out
ISODIR		:= iso
SRCDIR		:= ukrnl

OUTNAME		:= uOS32.iso

QEMUFLAGS	:= -cdrom
QEMUDEBUGFLAGS	:= $(QEMUFLAGS) -S -gdb tcp::8000

all: kernel

clean:
	for dir in $(SRCDIR); do	\
		cd $$dir && make clean;	\
		cd ..;			\
	done

build:
	for dir in $(SRCDIR); do	\
		cd $$dir && make;	\
		cd ..;			\
	done

build_iso:
	grub2-mkrescue -o $(OUTDIR)/$(OUTNAME) $(ISODIR)

kernel: build build_iso

run: kernel
	qemu-system-x86_64 $(QEMUFLAGS) $(OUTDIR)/$(OUTNAME)


debug:
	echo type \"target remote localhost:8000\" in gdb.
	qemu-system-x86_64 $(QEMUDEBUGFLAGS)

# view:

raw:
	hexdump -C $(OUTDIR)/$(IMAGE)
