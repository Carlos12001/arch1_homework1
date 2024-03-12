#include <stdio.h>
#include <stdlib.h>

void print_binary(int number, int bits) {
  int mask = 1 << (bits - 1);  // Places a 1 in the most significant position
                               // within the bit limit
  for (int i = 1; i <= bits; ++i) {
    putchar((number & mask) ? '1' : '0');  // Prints 1 or 0 based on the mask
    if (i % 4 == 0 && i != bits) putchar(' ');
    mask >>= 1;  // Shifts the mask one bit to the right
  }
}

void print_memory(int* numbers, int count, int bits) {
  int binaryLength = bits + bits / 4 - 1;
  int tabsForBinary = binaryLength / 4 + 1;
  printf("i\tbin");
  for (int j = 0; j < tabsForBinary; j++) printf("\t");
  printf("hex\n");

  for (int i = 0; i < count; ++i) {
    printf("%d\t", i);  // Prints the index
    print_binary(
        numbers[i],
        bits);  // Calls auxiliary function to print the number in binary
    printf("\t0x%X\n", numbers[i]);  // Prints the number in hexadecimal
  }
}

/// The seed
const int seed = 0x43;

// The power of the LFSR
int selected_bits[] = {3, 4, 5, 7};
const int size = sizeof(selected_bits) / sizeof(int);

// Num of generate pseudorandom numbers
const int steps = 100;

// Num of bits in the LFSR
const int max_bits = 8;

int main() {
  // Variables temporales
  int* temp1 = selected_bits;  // variable para cargar constantes
  int temp2 = 0;               // variable para hacer calculos
  int temp3 = 0;               // variable para hacer calculos

  // Variables guardadas para el for_memory_saver
  temp2 = max_bits;
  int _mask = 1 << temp2;
  _mask = _mask - 1;  // se guarda
  temp2 = seed;
  int _register =
      temp2 & _mask;  // se guarda y asegura que la semilla este en max_bits
  int memory_counter = 0;  // se guarda

  // Variables guardadas para el for_xor_lfsr
  int xor_result = 0;   // se guarda
  int bit_counter = 0;  // se guarda

  temp2 = steps;
  int* memory_address = (int*)malloc(
      sizeof(int) *
      temp2);  // esto es una constante por lo iria arriba esto es el 0x100

_for_memory_saver:
  temp2 = steps;
  if (memory_counter == temp2)
    goto _end_for_memory_saver;  // Reviso si termino de iterar
  temp1 = memory_address;
  *(temp1 + memory_counter) = _register;
  xor_result = 0;  // reinicia el xor
// Se encarga de obtener el nuevo bit MSB
_for_xor_lfsr:
  temp2 = size;
  if (bit_counter == temp2)
    goto _end_for_xor_lfsr;  // Reviso si termino de iterar
  temp1 = selected_bits;
  temp2 = *(temp1 + bit_counter);  // Obtengo la posicion del selected_bits

  temp3 = max_bits;
  temp2 = temp3 - temp2;
  temp2 = temp2 - 1;  // Calculo posicion para hacer Right-Shifter

  temp3 = _register >> temp2;       // Obtiene el bit
  temp2 = temp3 & 1;                // Hace el bit obtenido se encuentre en LSB
  xor_result = xor_result ^ temp2;  // Hace el xor del anterior
  bit_counter++;
  goto _for_xor_lfsr;

_end_for_xor_lfsr:
  temp2 = _register >> 1;
  _register = temp2;  // hago espacio en el MSB para el nuevo bit

  temp2 = max_bits;
  temp2 = temp2 - 1;            // obtengo maximo menos 1
  temp3 = xor_result << temp2;  // al bit calculado que se mueva al MSB

  _register = _register | temp3;  // agrego el nuevo bit en registro

  _register = _register & _mask;  // se pone una mascara de max_bits

  memory_counter++;
  bit_counter = 0;  // re reinicia el contador
  goto _for_memory_saver;

_end_for_memory_saver:
  // Finish the program
  print_memory(memory_address, steps, max_bits);
  return 0;
}