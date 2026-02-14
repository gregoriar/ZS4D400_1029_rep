CLASS zcl_1029_intances DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_INTANCES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*Definitions of References
*************************************************************************


    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

* Instances Creation
**************************************************************************
    connection = NEW #( ).

* Value assignment
    connection->carrier_id    = 'LH'.
    connection->connection_id = '0400'.

* Add  instances to the internal table reference
**************************************************************************
    APPEND connection TO connections.

    lcl_connection=>conn_counter = 1.


*Adds more instances to the internal table reference
*Second Instance
**************************************************************************
    connection = NEW #(  ).

    connection->carrier_id    = 'AA'.
    connection->connection_id = '0017'.

    APPEND connection TO connections.
     lcl_connection=>conn_counter += 1.

*Adds more instances to the internal table reference
*Third Instance
**************************************************************************

    connection = NEW #(  ).

    connection->carrier_id    = 'SQ'.
    connection->connection_id = '0001'.

    APPEND connection TO connections.

     lcl_connection=>conn_counter += 1.

  endmethod.
ENDCLASS.
