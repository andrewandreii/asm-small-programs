## asm small programs collection

### how to run
```sh
nasm -f elf64 <name>.asm
ld <name>.o
./a.out
```
most programs will use the exit syscall, so if you want to check the output, you run `echo $?`
