CLASS zcl_1029_copy_connection DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1029_copy_connection IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
* Declarations
****************************************************************

    DATA: it_dmo_connection  TYPE TABLE OF /dmo/connection,
          st_dmo_conection   TYPE /dmo/connection,
          it_z1029connection TYPE TABLE OF z1029Connection,
          st_z1029conection  TYPE z1029Connection.

*Loading data to interna table it_dmo_connecton from database table /dmo/connection
    SELECT FROM /dmo/connection
           FIELDS *
           INTO TABLE @it_dmo_connection.

*Fill the internal table it_z1029connection from it_dmo_connection
    it_z1029connection = CORRESPONDING #( it_dmo_connection ).

    if it_z1029connection is not INITIAL.
      out->write( |Have been added { lines( it_z1029connection )  } rows in internal table it_z1029connection| ).

*    INSERT z1029flight FROM TABLE @it_z1029flight.
      MODIFY  z1029connection  from TABLE @it_z1029connection.
      IF sy-subrc EQ 0.
        SELECT COUNT( * )
            FROM z1029connection INTO @DATA(lv_counter).
        IF sy-subrc EQ 0.
          out->write( | { lv_counter }  Rows have been added in table z1029connection  | ).
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
