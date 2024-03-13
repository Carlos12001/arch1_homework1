section .data
seed           dd 0x43            ; la semilla
selected_bits  dd 3, 4, 5, 7      ; los bits seleccionados para el LFSR
size           dd 16              ; el tamaño de selected_bits por 4
steps          dd 40              ; numero de numeros pseudoaleatorios a generar por 4
max_bits       dd 8               ; numero de bits en el LFSR

section .text
global _start

_start:
  mov rax, 3
  mov rbx, 7
_presuma:
  add rax, rbx
_suma:
  mov rax, 60
  mov rdi, 0
  syscall