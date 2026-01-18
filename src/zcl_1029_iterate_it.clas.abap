CLASS zcl_1029_iterate_it DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1029_iterate_it IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.
*CALCULO DE LA SERIE FIBONACCI
* Declarations
**********************************************************************

    CONSTANTS max_count TYPE i VALUE 20.

    DATA numbers TYPE TABLE OF i.

    DATA: output  TYPE TABLE OF string,
          output2 TYPE string_table.

* Iterations
**********************************************************************

    DO max_count TIMES.

* Implementation of the Fibonacci Series
**********************************************************************
      CASE sy-index.
        WHEN 1.
          APPEND 0 TO numbers.
        WHEN 2.
          APPEND 1 TO numbers.
        WHEN OTHERS.
          APPEND numbers[  sy-index - 2 ]
               + numbers[  sy-index - 1 ]
              TO numbers.

      ENDCASE.


    ENDDO.

*Preparing the output to print the Fibonacci Sequence as a string
**********************************************************************
    DATA(counter) = 0.


    LOOP AT numbers INTO DATA(number).

      counter = counter + 1.

*Organizing the data for output
**********************************************************************
*In each iteration, add a new row to the internal table output which contains
*the content of counter (l4 characters wide, left-justified), a colon (;)
*and the content of number (10 characters wide, right justified).

      APPEND |{ counter WIDTH = 4 }: { number WIDTH = 10 ALIGN = RIGHT }|
          TO output.

    ENDLOOP.

    output2 = output[].

*Output
******************************************************************
    out->write( |EJEMPLO CON TABLA INTERNA DE TIPO STRING| ).
    out->write(
           data   = output
           name   = |The first { max_count } Fibonacci Numbers| ) .

    out->write( | \n | ).

    out->write( |EJEMPLO CON TABLA INTERNA DE TIPO string_table | ).
    out->write(
           data   = output2
           name   = |The first { max_count } Fibonacci Numbers|  ) .


  ENDMETHOD.
ENDCLASS.
*SALIDA
*EJEMPLO CON TABLA INTERNA DE TIPO STRING
*The first 20 Fibonacci Numbers
*1   :          0
*2   :          1
*3   :          1
*4   :          2
*5   :          3
*6   :          5
*7   :          8
*8   :         13
*9   :         21
*10  :         34
*11  :         55
*12  :         89
*13  :        144
*14  :        233
*15  :        377
*16  :        610
*17  :        987
*18  :       1597
*19  :       2584
*20  :       4181
*
*EJEMPLO CON TABLA INTERNA DE TIPO string_table
*The first 20 Fibonacci Numbers
*1   :          0
*2   :          1
*3   :          1
*4   :          2
*5   :          3
*6   :          5
*7   :          8
*8   :         13
*9   :         21
*10  :         34
*11  :         55
*12  :         89
*13  :        144
*14  :        233
*15  :        377
*16  :        610
*17  :        987
*18  :       1597
*19  :       2584
*20  :       4181

