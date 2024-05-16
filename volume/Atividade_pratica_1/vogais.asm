; Int 10h
; https://en.wikipedia.org/wiki/INT_10H#:~:text=INT%2010h%2C%20INT%2010H%20or,vector%20that%20provides%20video%20services.

; nasm vogais.asm -o file.bin
; qemu-system-i386 file.bin

ORG 0x7C00
BITS 16             ; Seta que vamos utilizar o modo real - 16 bits
    jmp start       ; Da um jmp para a função de start.

palavra_input: db "andre antonio joao", 0x0D, 0x0A, 0                ; 0x0D, 0x0A, 0 - É o código de quebra de linha
frase_de_resposta: db "A quantidade de vogais nessa string : ", 0x0D, 0x0A, 0

; vogais: db "aeiou",0x0D, 0x0A, 0

; Em hexadecimal
; a = 0x61
; e = 0x65
; i = 0x69
; o = 0x6f
; u = 0x75

start:
    xor ax, ax                      ; Vai zerar o conteúdo desses registradores
    mov ds, ax                      ; Vai zerar o conteúdo desses registradores
    mov es, ax                      ; Vai zerar o conteúdo desses registradores
    mov ss, ax                      ; Vai zerar o conteúdo desses registradores
    mov cx, ax

    ; mov si, palavra_input         ; Armazena o conteúdo de msg para o ponteiro de string si
    mov si, frase_de_resposta
    call print_string               ; Chama a função de printar a string - Que é a frase.

    mov si, palavra_input           ; Manda o ponteiro de string SI olhar a palavra que queremos analizar.
    call cont_vogais

    xor ax, ax                      ; Vai zerar o conteúdo do registrador AX
    mov ax, cx                      ; Move o número 101 para o registrador AX
    call print_number               ; Chama a função de print - Ele vai ler a partir do conteúdo que está em AX

end:
    jmp $               ; Vai retornar para a main

print_string:
.loop:              ; Define um loop
    lodsb           ; Carrega em AL o "hello_world"
    or al, al       ; O xor ax, ax vai zerar - O que o or vai fazer?
    jz .done        ; Condicional que vai acontecer SE or retornar 0

    ; Ficam juntos por causa do condicional INT 10h
    mov ah, 0x0E    ; 0x0E = 14 - Move 14 para o registrador AH (8 bits)
    int 0x10        

    jmp .loop       ; Coloca para repetir o loop
.done:
    ret             ; Vai retornar para a main

cont_vogais:
.loop:              ; Define um loop
    lodsb           ; Carrega em AL o "hello_world"
    
    or al, al       ; O xor ax, ax vai zerar - O que o or vai fazer?
    jz .done        ; Desvio condicional - SE "or al, al" ANTERIOR definiu al como 0 (ou seja: chegou no final da string) pularemos para o done.
    
    ; cmp: Atribui essa resposta no registrador AX?
    ; Não usamos o jmp porque é incondicional ou seja, vai acontecer se chegar nesse ponto, não queremos isso.
    cmp al, 0x61        ; 'a'
    je .vogal           ; jump if cmp == 0, ou seja, for uma vogal

    cmp al, 0x65        ; 'e'
    je .vogal

    cmp al, 0x69        ; 'i'
    je .vogal

    cmp al, 0x6f        ; 'o'
    je .vogal

    cmp al, 0x75        ; 'u'
    je .vogal
    
    jmp .loop       ; Coloca para repetir o loop
.vogal:
    inc cx          ; Incrementa o contador que ta guardado em CX
    jmp .loop       ; Manda voltar para o .loop para terminar a palavra, quando chegar em 0 ai vai dar jmp para .done
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
