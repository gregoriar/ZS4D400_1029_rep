CLASS zcl_1029_processing_num_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_PROCESSING_NUM_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**********************************************************************

    " comment/uncomment these line for different result types
*   TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
     TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
*    TYPES t_result TYPE i.

    DATA result TYPE t_result.
    DATA result2 TYPE t_result.

* Calculations
**********************************************************************
    " comment/uncomment these lines for different calculations

    result = 2 + 3.
*    result = 2 - 3.
*    result = 2 * 3.
*    result = 2 / 3.
*
*    result = sqrt( 2 ).
*    result = ipow( base = 2 exp = 3 ).
*
    result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
   result2 = 8 * 7 - 6 / 5 + 4.   "Aqui se ejecuta de IZQ a DER y se ejecutan primero * y / y luego las - y +

* Output
**********************************************************************

    out->write( |RESULT: { result }| ).
    out->write( |RESULT2 (Without brackets): { result2  } | ).

  ENDMETHOD.
ENDCLASS.
