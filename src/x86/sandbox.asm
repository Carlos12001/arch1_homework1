section .data
seed           dd 0x43            ; la semilla
selected_bits  dd 3, 4, 5, 7      ; los bits seleccionados para el LFSR
size           dd 16              ; el tamaño de selected_bits por 4
steps          dd 40              ; numero de numeros pseudoaleatorios a generar por 4
max_bits       dd 8               ; numero de bits en el LFSR

section .text
global _start

_start
  ;; Inicializacion de variables (omitido en x86-64, no es necesario)

  ;; Preparar la mascara (s0)
  movl max_bits(%rip), %eax
  movl $1, %edx
  shl %cl, %edx        ;; sll en RISC-V es equivalente a shl en x86-64
  sub $1, %edx
  mov %edx, %esi       ;; s0 es la mascara

  ;; Inicializar LFSR (s1) con semilla & mascara
  movl seed(%rip), %eax
  and %esi, %eax
  mov %eax, %edi       ;; s1 es el registro LFSR

  ;; Inicializar contador de memoria (s2)
  xor %ecx, %ecx       ;; s2 es el contador de memoria

_for_memory_saver:
  ;; Comprobar si se alcanzaron todos los pasos
  movl steps(%rip), %eax
  cmp %ecx, %eax
  je _end_for_memory_saver

  ;; Guardar el valor actual del LFSR en memoria
  mov %edi, 0x100(%rcx)

  ;; Inicializar el resultado de XOR (s3) y el contador de bits (s4)
  xor %edx, %edx       ;; s3 es el resultado XOR
  xor %ebx, %ebx       ;; s4 es el contador de bits

_for_xor_lfsr:
  ;; Comprobar si se procesaron todos los bits
  movl size(%rip), %eax
  cmp %ebx, %eax
  je _end_for_xor_lfsr

  ;; Cargar direccion de selected_bits y obtener bit seleccionado
  lea selected_bits(%rip), %eax
  add %ebx, %eax
  mov (%eax), %eax
  movl max_bits(%rip), %edx
  sub %eax, %edx
  sub $1, %edx
  shr %cl, %edi        ;; srl en RISC-V es equivalente a shr en x86-64
  and $1, %edi
  xor %edx, %edi       ;; XOR entre el resultado anterior y el bit actual

  ;; Incrementar el contador de bits y continuar
  add $4, %ebx
  jmp _for_xor_lfsr

_end_for_xor_lfsr:
  ;; Preparar el registro LFSR para el nuevo bit
  mov $1, %edx
  shr %cl, %edi
  movl max_bits(%rip), %eax
  sub $1, %eax
  shl %cl, %edx
  or %edx, %edi
  and %esi, %edi       ;; Aplicar mascara

  ;; Incrementar contador de memoria y repetir
  add $4, %ecx
  jmp _for_memory_saver

_end_for_memory_saver:
  ;; Salir del programa
  mov $60, %eax    ;; syscall para exit en x86-64
  xor %edi, %edi   ;; Codigo de salida 0
  syscall
