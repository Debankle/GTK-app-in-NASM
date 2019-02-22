bits 64

global _main

%include "gtk.inc"


section .bss
    window:     resq 1


section .rodata
    signal:
    .destroy:   db  "destroy", 0

    title:      db  "My GTK+3 Window!", 0


section .text


    _destroy_window:
        jmp _gtk_main_quit

    _main:
        push rbp
        mov rbp, rsp

        xor rdi, rdi
        xor rsi, rsi
        call _gtk_init

        xor rdi, rdi
        call _gtk_window_new
        mov qword [ rel window ], rax

        mov rdi, qword [ rel window ]
        mov rsi, title
        call _gtk_window_set_title

        mov rdi, qword [ rel window ]
        mov rsi, GTK_WIN_WIDTH
        mov rdx, GTK_WIN_HEIGHT
        call _gtk_window_set_default_size

        mov rdi, qword [ rel window ]
        mov rsi, GTK_WIN_POS_CENTER
        call _gtk_window_set_position

        mov rdi, qword [ rel window ]
        mov rsi, signal.destroy
        mov rdx, _destroy_window
        xor rcx, rcx
        xor r8d, r8d
        xor r9d, r9d
        call _g_signal_connect_data

        mov rdi, qword [ rel window ]
        call _gtk_widget_show

        call _gtk_main

        call _exit
