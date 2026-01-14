CLASS zcl_1029_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1029_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**************************

    DATA number1 TYPE i.
    DATA number2 TYPE i.

*    DATA result TYPE p LENGTH 8 DECIMALS 2.


* Input Values
**************************
    number1 = -8.
    number2 =  3.

* Calculations
*************************************
   DATA(result) = number1 / number2.

*   result = number1 / number2.

    DATA(output) = |{ number1 } / { number2 } = { result }|.

* Output
**************************

    out->write( output ).


  ENDMETHOD.
ENDCLASS.
*SALIDA
*Valor con
* DATA result TYPE p LENGTH 8 DECIMALS 2.
*-8 / 3 = -2.67
* result = number1 / number2.
*
*Valor con
* DATA(result) = number1 / number2.
*-8 / 3 = -3
