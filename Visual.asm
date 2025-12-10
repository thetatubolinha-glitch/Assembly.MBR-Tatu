    [bits   16]
    [org    0x7c00]

        ;----Graphic----;
        mov     ax, 13h ; VGA mode 255 colors
        int     0x10

        mov     ax, 0xA000
        mov     es, ax

        xor     di, di
        xor     dx, dx ; DX = 0
        xor     cx, cx ; CX = 0
        ;----Graphic----;

            mov     al, $20 ;-- Initial color --;

            pattern: stosb ;-- Routine --;
            inc     al ;-- Add al --;
            cmp     al, $2F ;-- Compare it with $2F --;
            je      Reset ;-- If it's bigger, it jumps to Reset --;
            cmp     cx, 320 ;-- Compare cx with 320 --;
            je      Stop ;-- if it is greater than 320, it will go to Stop --;
            loop    pattern ;-- Loop Routine --;

            Reset: stosb ;-- Reset Routine --;
            mov     al, $20 ;-- Move al to $20 (reset colors) --;
            jmp     pattern ;-- Return to pattern --;

            Stop: ;-- Stop pattern --;
            jmp     Stop ;-- Stop loop --;

    times 510 - ($-$$) db 0
    dw 0xAA55
