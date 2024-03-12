.global _start

.data
seed:       .word 0x43 		// la semilla
selected_bits: .word 3,4,5,7// los bits seleccionados para el LFSR
size:       .word 16		// el tamano de selected_bits por 4
steps:      .word 400      	// numero de numeros pseudoaleatorios a generar por 4
max_bits:   .word 8  		// numero de bits en el LFSR
memory_address: .word 0x100	// numero de memoria para guardar los numeros pseudoaltearios

.text
_start:
	// este codigo se puede eliminar porque redudante
	mov r0, #0 // variable Temporal para cargar data
	mov r1, #0 // variable Temporal para calculos
	mov r2, #0 // variable Temporal para calculos
	
	// variables guardadas para _for_memory_saved
	ldr r0, =max_bits
	ldr r1, [r0]
	mov r2, #1
	lsl r4, r2, r1
	sub r4, #1 // r4 es la mask
	ldr r0, =seed
	ldr r5, [r0]
	and r5, r4 // r5 es el register LFSR
	mov r6, #0 // r6 es el memory_counter
	
_for_memory_saver:
	ldr r0, =steps
	ldr r1, [r0]
	cmp r1, r6 
  beq _end_for_memory_saver // compara si memory_counter ya hizo todos los steps
  ldr r0, =memory_address
  str r5, [r0, r6] // guarda el valor ultimo register lfsr
  // variables guardadas para _for_xor_lfsr
	mov r7, #0 // r7 es el xor_result
	mov r8, #0 // r8 es el bit_counter

_for_xor_lfsr:
  ldr r0,  =size
  ldr r1, [r0]
  cmp r1, r8
  beq _end_for_xor_lfsr // compara si memory_counter ya hizo todos bits
  
  ldr r0, =selected_bits
  ldr r1, [r0, r8] // obtiene la posicion a extraer el bit
  
  ldr r0, =max_bits
  ldr r2, [r0]
  sub r2, r1
  sub r2, #1 // calculo posicion del bit para hacer Logical Right-Shifter
  
  lsr r1, r5, r2 // obtiene el bit

  and r1, #1 // hace el bit obtenido se encuentre en LSB

  eor r7, r1 // hace el calculo con el anterior xor
  
  add r8, #4
  b _for_xor_lfsr 

_end_for_xor_lfsr:
  mov r2, #1
  lsr r1, r5, r2
  mov r5, r1 // hace espacio en register en el MSB para el nuevo bit

  ldr r0, =max_bits
  ldr r1, [r0]
  sub r1, #1 // obtengo maximo menos 1
  lsl r2, r7, r1   
  mov r7, r2 // al bit calculado que se mueva al MSB

  orr r5, r7   // agrego el nuevo bit en registro
  and r5, r4 // aplica la mascara

  add r6,#4
  b _for_memory_saver;

_end_for_memory_saver:
	
	mov r7, #1
	swi 0
