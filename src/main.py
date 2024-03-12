selected_bits = [3,4,5,7]
max_bits = 8

seed = 0b01000011 
temp = 1 << selected_bits[0]

s = format(temp, f'0{max_bits}b')
# print(s)

mask = (1 << max_bits) - 1 # genera un numero de 9 bits y el resta 1 para generar uno que 8 unos
s = format(mask, f'0{max_bits}b')
# print(s)

temp = max_bits - 1 - selected_bits[3]
s = format(seed >> temp & 1, f'0{max_bits}b')
print(s)

def lfsr(seed, steps, max_bits, selected_bits):
    mask = (1 << max_bits) - 1  # Máscara para el tamaño del registro
    register = seed & mask  # Ajusta la semilla al tamaño de bits máximo
    print(f"Step\tRegister\t\tOutput")

    for step in range(1, steps + 1):
        # Calcula el XOR de los bits seleccionados
        xor_result = 0
        for bit in selected_bits:
            # Ajusta los índices de bits según el conteo desde el bit menos significativo
            xor_result ^= (register >> (max_bits - 1 - bit)) & 1

        # El bit de salida es el menos significativo del registro actual
        output_bit = register & 1
        
        # Desplaza el registro hacia la derecha para hacer espacio para el nuevo bit
        register >>= 1
        
        # Inserta el nuevo bit calculado en la posición más significativa
        register |= (xor_result << (max_bits - 1))
        register &= mask  # Asegura que el registro mantenga el tamaño correcto
        
        print(f"{step}\t{bin(register)[2:].zfill(max_bits)}\t\t{output_bit}")

# Ejemplo de uso con la semilla, pasos, tamaño de bits y bits seleccionados para XOR
seed = 0b01000011  # Semilla como número entero
steps = 10  # Número de pasos a simular
max_bits = 8  # Longitud máxima del registro en bits
selected_bits = [3, 4, 5, 7]  # Índices de los bits seleccionados para la operación XOR

# lfsr(seed, steps, max_bits, selected_bits)

