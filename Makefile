ASMFILES 	:= 	main.asm
OBJFILES 	:= 	main.o
TARGET   	:= 	main

NASM		:= 	nasm
LD		:= 	ld
CC		:= 	gcc-8

NASMFLAGS	:= 	-f macho64
GTKFLAGS 	:= 	-L/usr/local/Cellar/gtk+3/3.24.8/lib -lgtk-3 -lgobject-2.0
LDFLAGS		:= 	-no_pie -lSystem -lc $(GTKFLAGS)
CCFLAGS		:= 	`pkg-config --cflags --libs gtk+-3.0`

all: link

.PHONY: all link clean

link: $(OBJFILES)
	$(LD) $(LDFLAGS) -o $(TARGET) $^

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

%.o: %.c
	$(CC) -c -fno-asynchronous-unwind-tables -O2 $(CCFLAGS) -o $@ $<

clean:
	rm -rf $(OBJFILES) $(TARGET)
