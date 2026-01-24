CLASS zcl_1029_structure_excersice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1029_structure_excersice IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections  TYPE TABLE OF REF TO lcl_connection.
    TRY.



* First Instance
*******************************************************************
        connection = NEW #(
                            i_carrier_id    = 'LH'
                            i_connection_id = '0400'
                          ).

*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'LH'
*            i_connection_id = '0400'
*        ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
        out->write( 'Instance 1 failed' ).
    ENDTRY.

*Second Instance
    TRY.
        connection = NEW #(
                            i_carrier_id    = 'AA'
                            i_connection_id = '0000'  "For raise exception, I must test later
*                            i_connection_id = '0017'  " Valid value
                          ).
        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
        out->write( 'Instance 2 failed' ).
    ENDTRY.

* Third instance
**********************************************************************
    TRY.
        connection = NEW #(
                            i_carrier_id    = 'SQ'
                            i_connection_id = '0001'
                          ).
        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
        out->write( 'Instance 3 failed' ).
    ENDTRY.

* Output
**********************************************************************
    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.
    out->write( |Structure use as  private intance attribute in Local Class  | ).
    out->write( |{ lines( connections ) } connectios have been created| ).
  ENDMETHOD.
ENDCLASS.
*SALIDA
*Method call failed
*Instance 2 failed
*--------------------------------
*Carrier:     LH Deutsche Lufthansa AG
*Connection:  0400
*Departure:   FRA
*Destination:JFK
*--------------------------------
*Carrier:     SQ Singapore Airlines Limited
*Connection:  0001
*Departure:   SFO
*Destination:SIN
*Structure use as  private intance attribute in Local Class
*2 connectios have been created
