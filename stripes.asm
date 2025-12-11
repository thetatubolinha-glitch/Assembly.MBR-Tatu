; Code by TatuBolinha-Glitch, in github, see the liscense
    
    BITS    16
    ORG    0x7c00

        ;--=Graphic=--;
        mov     ax, 13h ;---= VGA mode, 255 colors =---;
        int     0x10
        mov     ax, 0xA000
        mov     es ,ax
        xor     di, di ;-= di = 0 -=;
        xor     dx, dx ;-= DX = 0 =-;
        ;--=Graphic=--;

        ;--= Effects =--;

            mov     al, $2F ;--= Initial color --=;

            ;==============+First effect+==============; ->
            Effect:     stosb ;--= "Effect" routine =--; ->
                inc     al ;--= for loop infinity =--; -> 
                inc     dx ;--= for loop infinity =--; ->
                cmp     dx, 200 ;--= Compare DX, 200=-; ->
                je      Reset ;--= dx > 200 = go to "Reset" routine =--; ->
                cmp     al, $2F ;--= Compare al, $2F --=; ->
                je      ResetClr ;--= al > $2F = go to "ResetClr" routine =--; ->
                jmp     VAW ;--= Go to VAW routine =--; ->
                jmp     Something ;--= Go to SOMETHING routine =--; ->
                jmp     Nothing ;--= Go to NOTHING routine =--; ->
                loop    Effect ;--= Loop routine "Effect" =--; ->
            ;==============+First effect end+==============;

            ;====+Reset routine+====;
            Reset:      stosb ;-= Reset routine =-;
                mov     dx, 1 ;-= Dx = 1 =-;
                mov     al,$20 ;-= AL = $20 =-;
                jmp     Effect ;-= Go to  "Effect" routine =-;
            ;====+Reset routine end+====;


            ;====+ResetClr routine+====;
            ResetClr:   stosb ;-= ResetClr routine -=;
                mov     al,$20 ;-= AL = $20 =-;
                jmp     Effect ;-= Go to "Effect" routine =-;
            ;====+ResetClr routine+====;
            
            ;====+VAW routine+====;
            VAW: stosb ;--= VAW routine =--;     
                inc     dx ;--= For infinity loop =--;
                add     al, $10 ;--= add al + $10 =--;
                cmp     al, $2F ;--= Compare al, $2F =--;
                je      ResetClr ;--= If resetClr > $2F =--;
                xor     dx, dx ;--= dx = 0 =--;
                xor     cx, cx ;--= cx = 0 =--;
                jmp     Effect ;--= Go to Effect routine =--;
            ;====+VAW routine end+====;

            ;====+Something routine+====;
            Something: stosb ;--= Something routine =--;
                xor     cx, cx ;--= cx = 0 =--;
                xor     dx, dx  ;--= dx = 0 =--;
                add     al, $2F ;--= al + $2F =--;
                jmp     Effect ;--= Go to Effect routine =--;
                loop Something ;--= Loop routine =--;
            ;====+Something routine end+====;
            
            ;====+Nothing routine+====;
            Nothing: stosb ;--= Nothing routine =--;
                xor     al, al ;--= al = 0 =--;
                mov     al, $20 ;--= al > $20 =--;
                jmp Effect ;--= Go to Effect routine =--;
            ;====+Nothing routine end+====;
        
        ;--= Effects end =--;

        times       510 - ($-$$) db 0

        dw          0xAA55
