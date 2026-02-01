CLASS zcl_1029_copydataflight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_1029_copydataflight IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: it_dmo_flight  TYPE TABLE OF /dmo/flight,
          st_dmo_flight  TYPE /dmo/flight,
          it_z1029flight TYPE TABLE OF z1029flight,
          st_z1029flight TYPE z1029flight.

*Loading data to interna table it_dmo_flight from database table /dmo/flight
    SELECT FROM /dmo/flight
           FIELDS *
           INTO TABLE @it_dmo_flight.

*    LOOP AT it_dmo_flight INTO st_dmo_flight.
*
*      APPEND VALUE #(
*           carrier_id     = st_dmo_flight-carrier_id
*           connection_id  = st_dmo_flight-connection_id
*           flight_date    = st_dmo_flight-flight_date
*           price          = st_dmo_flight-price
*           currency_code  = st_dmo_flight-currency_code
*           plane_type_id  = st_dmo_flight-plane_type_id
*           seats_max      = st_dmo_flight-seats_max
*           seats_occupied = st_dmo_flight-seats_occupied             )
*
*       TO it_z1029flight.
*
*      out->write( |Record carrier_id in it_z1029flight { it_z1029flight[ sy-tabix ]-carrier_id } | ).
*
*    ENDLOOP.

    it_z1029flight = CORRESPONDING #( it_dmo_flight ).

*Condition for validate that internal table it_z1029 has been charged
*Another condition for validate this is NOT INITIAL
    IF lines( it_z1029flight ) GT 0.

      out->write( |Have been added { lines( it_z1029flight )  } rows in internal table it_z1029flight| ).

*    INSERT z1029flight FROM TABLE @it_z1029flight.
      MODIFY  z1029flight FROM TABLE @it_z1029flight.
      IF sy-subrc EQ 0.
        SELECT COUNT( * )
            FROM z1029flight INTO @DATA(lv_counter).
        IF sy-subrc EQ 0.
          out->write( | { lv_counter }  Rows have been added in table z1029flight  | ).
        ENDIF.
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
*SALIDA
*Have been added 40 rows in internal table it_z1029flight
* 40  Rows have been added in table z1029flight
