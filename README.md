# Linear Feedback Shift Register (LFSR) Guide

## English

A Linear Feedback Shift Register (LFSR) is a shift register that moves
bits linearly according to a feedback mechanism. It's widely used in
fields such as cryptography, pseudo-random number generation,
and digital signal processing due to its efficiency in generating
sequences of bits. The basic operation involves shifting bits and applying
a feedback function that modifies the state of the register.

### How it Works

Initialization: The LFSR is initialized with a seed value in the binary register.
Feedback Function: From the current state of the binary register, specific bits
are selected and used in an XOR operation to create a new bit.
Shifting: The result of the XOR operation is added to the start of the
register (left side), while the last bit of the register (right side)
is removed and can be output as part of the generated sequence.

### Example

Consider a register initialized with 1010. We apply an XOR operation to
bits 0 and 2 (numbering starts from 0 on the left).

# Linear Feedback Shift Register (LFSR) Example

| Step | NewRegister | XOR Operation OldRegister | Output |
| ---- | ----------- | ------------------------- | ------ |
| 0    | 1010        | ----------                | -      |
| 1    | 0101        | 0 ⊕ 0 = 0                 | 0      |
| 2    | 0010        | 0 ⊕ 0 = 0                 | 1      |
| ...  | ...         | ...                       | ...    |

The register shifts right, the result of the XOR operation is inserted
on the left, and the rightmost bit is output.

## Español

Una Registro de Desplazamiento con Retroalimentación Lineal (LFSR por
sus siglas en inglés) es un registro de desplazamiento que mueve bits
linealmente de acuerdo con un mecanismo de retroalimentación. Es ampliamente
utilizado en campos como criptografía, generación de números pseudoaleatorios
y procesamiento de señales digitales debido a su eficiencia en generar
secuencias de bits. La operación básica involucra desplazar bits y aplicar
una función de retroalimentación que modifica el estado del registro.

### Cómo Funciona

Inicializaron: El LFSR se inicializa con un valor semilla en el registro
binario.
Función de Retroalimentación: Del estado actual del registro binario, se
seleccionan bits específicos y se utilizan en una operación XOR para
crear un nuevo bit.
Desplazamiento: El resultado de la operación XOR se agrega al inicio del
registro (lado izquierdo), mientras que el último bit del registro
(lado derecho) se elimina y puede ser emitido como parte de la secuencia
generada.

### Ejemplo

Considere un registro inicializado con 1010. Aplicamos una operación XOR
a los bits 0 y 2 (la numeración comienza desde 0 a la izquierda).

| Step | NewRegister | XOR Operation OldRegister | Output |
| ---- | ----------- | ------------------------- | ------ |
| 0    | 1010        | ----------                | -      |
| 1    | 0101        | 0 ⊕ 0 = 0                 | 0      |
| 2    | 0010        | 0 ⊕ 0 = 0                 | 1      |
| ...  | ...         | ...                       | ...    |

El registro se desplaza hacia la derecha, el resultado de la operación XOR
se inserta a la izquierda y el bit más a la derecha se emite.
