# [Containerize your assembly language code](https://www.goglides.dev/bkpandey/containerize-your-assembly-language-code-4k4c)
Repositório para guardar exs e anotações sobre Assembly x86 na disciplina de Infraestrutura Hardware Software.

Rodar o comando abaixo para buildar o Dockerfile que está na pasta:
```
$ docker build -t <nome_da_imagem> .

$ docker build -t ihs .
```

E também voltar para o mesmo utilizando o comando:

```
$ docker attach <ID_do_container>
```

OBS: Para pegar o ID do container com uma das opções:

```
$ docker container ls -a
$ docker images
```

## Compilando arquivos

Para criar um arquivo Hello:

```
vim nome_do_arquivo.asm
```

Escreve o arquivo e salva apertando ESC e escrevendo:

```
:wq!
```

Após isso poderemos rodar o nosso programa. Um exemplo de um arquivo .asm pode ser:

```
;; Programa Hello World
section .text
global _start

_start:
        mov     edx,len                             ;comprimento da mensagem
        mov     ecx,msg                             ;mensagem a ser escrita
        mov     ebx,1                               ;descritor de arquivo (stdout)
        mov     eax,4                               ;número da system call
; (sys_write)
        int     0x80                                ;call kernel

        mov     eax,1                               ;numero da syscall
; (sys_exit)
        int     0x80                                ;call kernel

section     .data
        msg     db  'Hello, world!',0xa                 ;nossa string lindona
        len     equ $ - msg                             ;comprimento da lindona
```

Depois que salvar esse arquivo, para compilar:

```
nasm file.asm -o file.bin
```

E depois:
```
qemu-system-i386 file.bin

qemu-system-i386 -drive format=raw,file=file.bin -boot d
```

## Volumes - Assembly image - Lembrar de alterar para a pasta volume que está aqui

```
$ docker container run -ti --mount type=bind,src=C:/volume,dst=/volume ihs
```
* Para o notebook ZBOOK:

```
$ docker container run -ti --mount type=bind,src=C:\Users\victo\Desktop\IHS\volume,dst=/volume ihs

$ docker container run -ti -p 5900:5900 --mount type=bind,src=C:\Users\victo\Desktop\IHS\volume,dst=/volume ihs
```
OBS: ```C:\Users\victo\Desktop\IHS\volume``` é a pasta que eu criei no meu diretório.

### Removendo imagem

```
docker images
```
</br>

* Depois executar o comando para remover:

```

```

### Abrindo o resultado no localhost

* Provavelmente a saída de output foi algo como:

```
root@dec37a996352:/volume/Atividade_pratica_1# qemu-system-i386 file.bin
WARNING: Image format was not specified for 'file.bin' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
VNC server running on ::1:5900


root@dec37a996352:/volume/Atividade_pratica_1# qemu-system-i386 -drive format=raw,file=file.bin
VNC server running on ::1:5900
```

* Preciso instalar algo para olhar na porta especificadao, no caso 5900. Instalei o [RealVNC Viewer](https://www.realvnc.com/en/connect/download/viewer/?__lai_s=0.018333333333333333&__lai_sr=0-4&__lai_sl=l).

