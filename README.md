## asm small programs collection

### how to run
```sh
nasm -f elf64 <name>.asm
ld <name>.o
./a.out
```
most programs will use the exit syscall, so if you want to check the output, you run `echo $?`

### todo
rewrite the binary search so that the function is in bsearch.asm and _start in bsearch_start.asm

### issues
change all `int 0x80` to `syscall`
