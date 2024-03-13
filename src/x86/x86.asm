section .data
seed           dd 0x43            ; la semilla
selected_bits  dd 3, 4, 5, 7      ; los bits seleccionados para el LFSR
size           dd 16              ; el tamaño de selected_bits por 4
steps          dd 40              ; numero de numeros pseudoaleatorios a generar por 4
max_bits       dd 8               ; numero de bits en el LFSR

section .text
global _start

_start:
  ;; iniciar variables temporales
  mov eax, 0 ;; variable temporal para cargar datos
  mov ebx, 0 ;; variable temporal para calculos
  mov ecx, 0 ;; variable temporal para calculos

  ;; preparar la mascara
  mov eax, [max_bits] ;; Load max_bits into eax
  mov cl, al          ;; Move al (lower 8 bits of eax) into cl for shift count
  mov ecx, 1
  shl ecx, cl         ;; Shift left 1 by the number of bits in cl
  dec ecx             ;; Subtract 1 from ecx to get the mask
  mov r11d, ecx       ;; Store the mask in r11d (32-bit part of r11)
  mov r12, 0x63 ;;  r13 es el register LFSR
  mov r13, 0 ;; r13 es el memory_counter
_end_for_memory_saver:
  syscall