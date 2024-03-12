# ARM LFSR

Se descubrió para acceder en memoria para cada word, se descubrió que se
tiene que hacer incrementos 4 para obtener la siguiente word. Como el LFSR
en C que el en punteros, se olvido hacerlo con incrementos de 4 en vez
de 1. Por lo la cantidad de maxima de steps es 4\*el deseado.

Y los mismo sucede para acceder a selected_bits. Por lo que los parámetros
de `size` y `steps` se multiplicaron por 4.

Se usa la convención de llamadas más comúnmente usada en ARM (AAPCS - ARM Architecture Procedure Call Standard), los registros se categorizan de la siguiente manera:

    R0-R3: Son registros de argumentos/temporales; es decir, pueden ser utilizados para pasar argumentos a las funciones y para almacenar valores de retorno. No necesitan ser preservados (salvados y restaurados) por las funciones llamadas.

    R4-R11: Son considerados como registros de variables salvadas. Si una función usa estos registros, debe preservar sus valores originales. Esto significa que si una función planea usar uno de estos registros para sus propias operaciones, debe guardar el valor original al principio de la función y restaurarlo antes de regresar. Estos registros proporcionan una forma de almacenar valores que deben persistir a lo largo de la ejecución de una función.

    R12 (IP): A menudo se usa como un registro de propósito especial o como un registro de propósito general adicional.

    R13 (SP): Es el puntero de pila, utilizado para controlar la pila del programa.

    R14 (LR): El registro de enlace, que almacena la dirección de retorno para llamadas a subrutinas.

    R15 (PC): El contador de programa, que indica la dirección de la próxima instrucción a ejecutar.

    CPSR: El registro de estado del programa actual, que almacena banderas de estado y controles de modo de ejecución.
