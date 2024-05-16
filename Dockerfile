# Use an existing base image as the starting point
FROM ubuntu:20.04 AS build

# Update the package list and install Vim
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim && \
    rm -rf /var/lib/apt/lists/*

# Install NASM from Ubuntu repositories
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nasm

# Install QEMU
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    qemu-system-x86

# Limpar o cache do apt-get para reduzir o tamanho da imagem final
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Defina o diretório de trabalho
# WORKDIR /volume/Atividade_pratica_1
WORKDIR /volume/Atividade_pratica_1

EXPOSE 5900

# # Copie seus arquivos para o contêiner
# COPY kernel.asm .
# COPY vogais.asm .

# # Compile seu código assembly
# RUN nasm vogais.asm -o file.bin
# RUN qemu-system-i386 file.bin

# # CMD padrão
# CMD ["qemu-system-i386", "file.bin"]
