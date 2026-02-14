CLASS zcl_1029_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_HELLO_WORLD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data lv_prueba TYPE string value 'Gregoria '.

*    out->write( |Hello Wordl { lv_prueba }  esto mola! | ).

* Data Objects with Built-in Types
**********************************************************************

    " comment/uncomment the following declarations and check the output
**********************************************************************
*    DATA variable TYPE string.
*    DATA variable TYPE i.
*     DATA variable TYPE d.
*    DATA variable TYPE c LENGTH 10.
*    DATA variable TYPE n LENGTH 10.
   DATA variable TYPE p LENGTH 8 DECIMALS 2.

* Output
**********************************************************************

    out->write(  'Result with Initial Value)' ).
    out->write(   variable ).
    out->write(  '---------' ).

    variable = '19891109'.

    out->write(  'Result with Value 19891109' ).
    out->write(   variable ).
    out->write(  '---------' ).


  ENDMETHOD.
ENDCLASS.
