CLASS zcl_1029_exception_handling_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1029_exception_handling_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id       VALUE 'LH'.
    CONSTANTS c_connection_id TYPE /dmo/connection_id VALUE '0400'.

    DATA connection   TYPE REF TO lcl_connection.
    DATA connections  TYPE TABLE OF REF TO lcl_connection.

* Create Instance
**********************************************************************

    connection = NEW #(  ).

* Call Method and Handle Exception
* Ajusted i_connection_id to 0 por raise exception
**********************************************************************
    out->write(  |i_carrier_id    = '{ c_carrier_id }' | ).
    out->write(  |i_connection_id = '{ c_connection_id }'| ).

    TRY.
        connection->set_attributes(
          EXPORTING
           i_carrier_id    = c_carrier_id
            i_connection_id =  0  ).
                  "c_connection_id       ).

        APPEND connection TO connections.
        out->write( `Method call successful` ).
      CATCH cx_abap_invalid_value.
        out->write( |PARAMETER i_carrier_id: { c_carrier_id } | ).
        out->write( |PARAMETER i_connection_i: 0 ajusted for raise exception !| ).
        out->write( `Method call failed`     ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
*SALIDA
*i_carrier_id    = 'LH'
*i_connection_id = '0400'
*PARAMETER i_carrier_id: LH
*PARAMETER i_connection_i: 0 ajusted for raise exception !
*Method call failed
