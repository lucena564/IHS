; comentarios

ORG 0x7C00
BITS 16             ; Seta que vamos utilizar o modo real - 16 bits
    jmp start       ; Da um jmp para a função de start.

msg: db "hello world", 0x0D, 0x0A, 0

start:
    xor ax, ax      ; Vai zerar o conteúdo desses registradores
    mov ds, ax      ; Vai zerar o conteúdo desses registradores
    mov es, ax      ; Vai zerar o conteúdo desses registradores
    mov ss, ax      ; Vai zerar o conteúdo desses registradores

    mov si, msg         ; Armazena o conteúdo de msg para o ponteiro de string si
    call print_string   ; Chama a função de printar a string

    xor ax, ax          ; Vai zerar o conteúdo do registrador AX
    mov ax, 101         ; Move o número 101 para o registrador AX
    call print_number   ; Chama a função de print - Ele vai ler a partir do conteúdo que está em AX

end:
    jmp $               ; Vai retornar para a main


print_string:
.loop:              ; Define um loop
    lodsb           ; ??????????????
    or al, al       ; O xor ax, ax vai zerar - O que o or vai fazer?
    jz .done        ; ??????????????
    mov ah, 0x0E    ; 0x0E = 14 - Move 14 para o registrador AH (8 bits)
    int 0x10        ; ??????????????
    jmp .loop       ; Coloca para repetir o loop
.done:
    ret             ; Vai retornar para a main


print_number:
    mov bx, 10      ; Coloca 10 para o registrador BX - Base Adress
    mov cx, 0       ; Coloca 0 para o registrador  CX - Count
.loop1:
    mov dx, 0
    div bx
    ; resposta vai ta no ax, resto no dx
    add dx, 48
    push dx
    inc cx
    cmp ax, 0
    jne .loop1
.loop2:
    pop ax
    mov ah, 0x0E
    int 0x10
    loop .loop2
.done:
    ret             ; Vai retornar para a main



; assinatura de boot - O boot loader PRECISA ter esse tamanho de 510

    times 510-($-$$) db 0
    dw 0xAA55
