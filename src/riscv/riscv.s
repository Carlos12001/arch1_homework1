.data
seed: .word 0x43 		# la semilla
selected_bits: .word 3,4,5,7 # los bits seleccionados para el LFSR
size:       .word 16		# el tamano de selected_bits por 4
steps:      .word 40      	# numero de numeros pseudoaleatorios a generar por 4
max_bits:   .word 8  		# numero de bits en el LFSR

.text
.global _start

_start:
  ## este codigo se puede eliminar porque redudante
  li t0, 0 ## variable temporal para cargar data
  li t1, 0 ## variable temporal para calculos
  li t2, 0 ## variable temporal para calculos
  	
	
  ## variables guardadas para _for_memory_saved
  lw t0, max_bits
  li t1, 1
  sll s0, t1, t0
  addi s0, s0, -1 ## s0 es la mask
  lw t0, seed
  mv s1, t0
  and s1, s1, s0 ## s1 es el register LFSR
  li s2, 0 ## s2 es el memory_counter
  
_for_memory_saver:
  lw t0, steps
  beq t0, s2, _end_for_memory_saver ## compara si memory_counter ya hizo todos los steps
  sw s1,  0x100(s2) ## guarda o almacena register lfsr (s1) en 0x100+memory_counter
  
  
  ## variables guardadas para _for_xor_lfsr
  li s3, 0 ## s3 es el xor_result
  li s4, 0 ## s4 es el bit_counter

_for_xor_lfsr:  
  lw t0, size
  beq t0, s4, _end_for_xor_lfsr ## compara si memory_counter ya hizo todos bits
  
  lw t0, selected_bits 
  
  la t0, selected_bits ## carga la direccion de selected_bits 
  add t0, t0, s4       ## calcula la direccion sumando la base y el offset
  lw t1, 0(t0)         ## obtiene la posicion a extraer el bit
  
  lw t0, max_bits
  mv t2, t0
  sub t2, t2, t1
  addi t2, t2, -1 ## calculo posicion del bit para hacer Logical-Right-Shifter
  
  srl t1, s1, t2 ## obtiene el bit
  andi t1, t1, 1 ## hace el bit obtenido se encuentre en LSB
  
  xor s3, s3, t1 ## hace el calculo con el anterior xor
  
  addi s4, s4, 4 ## incrementa el counter_bits (s4)
  j _for_xor_lfsr ## siguiente iteracion
  
_end_for_xor_lfsr: 
  li t2, 1
  srl t1, s1, t2
  mv s1, t1 ## hace espacio en register en el MSB para el nuevo bit
  
  lw t0, max_bits
  addi t1, t0, -1 ## obtengo maximo menos 1
  sll t2, s3, t1
  mv s3, t2 ## al bit calculado que se mueva al MSB
  
  or s1, s1, s3 ## agrego el nuevo bit en registro
  and s1, s1, s0 ## aplica la mascara
  
  addi s2, s2, 4 ## incrementa el counter_memory (s2)
  j _for_memory_saver ## siguiente iteracion
   
_end_for_memory_saver:
  li a7, 93          ## carga el numero de la llamada al sistema para exit en a7
  li a0, 0           ## carga el codigo de salida en a0, 0 indica exito
  ecall              ## ejecuta la llamada al sistema
