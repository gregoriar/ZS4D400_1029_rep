CLASS zcl_1029_fill_complex_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_FILL_COMPLEX_TABLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES tt_connections TYPE STANDARD TABLE OF   st_connection
                              WITH NON-UNIQUE KEY carrier_id
                                                  connection_id.

    DATA connections TYPE tt_connections.

    TYPES: BEGIN OF st_carrier,
             carrier_id    TYPE /dmo/carrier_id,
             carrier_name  TYPE /dmo/carrier_name,
             currency_code TYPE /dmo/currency_code,
           END OF st_carrier.

    TYPES tt_carriers TYPE STANDARD TABLE OF st_carrier
                          WITH NON-UNIQUE KEY carrier_id.

    DATA: carriers     TYPE tt_carriers,
          carrier      LIKE LINE  OF  carriers,
          carriers2    TYPE table of /dmo/flight,
          carrier2     TYPE /dmo/flight,

          connections2 TYPE  tt_connections,
          connections3 TYPE  tt_connections.
*
    DATA: connects_flights    TYPE  tt_connections,
         " connects_flights
           wa_connect_flight  TYPE  st_connection.



* Example 1: APPEND with structured data object (work area)
**********************************************************************

*    DATA connection  TYPE st_connection.
    " Declare the work area with LIKE LINE OF
    DATA connection LIKE LINE OF connections.


*    connection-carrier_id       = 'NN'.
*    connection-connection_id    = '1234'.
*    connection-airport_from_id  = 'ABC'.
*    connection-airport_to_id    = 'XYZ'.
*    connection-carrier_name     = 'My Airline'.

    " Use VALUE #( ) instead assignment to individual components
    connection = VALUE #( carrier_id       = 'NN'
                          connection_id    = '1234'
                          airport_from_id  = 'ABC'
                          airport_to_id    = 'XYZ'
                          carrier_name     = 'My Airline' ).

    APPEND connection TO connections.

    out->write(  `--------------------------------` ).
    out->write(  `Example 1: APPEND with Work Area` ).
    out->write(  connections ).

* Example 2: APPEND with VALUE #( ) expression
**********************************************************************

    APPEND VALUE #( carrier_id       = 'NN'
                    connection_id    = '1234'
                    airport_from_id  = 'ABC'
                    airport_to_id    = 'XYZ'
                    carrier_name     = 'My Airline'
                  )
       TO connections.

    out->write(  `----------------------------` ).
    out->write(  `Example 2: Append with VALUE` ).
    out->write(  connections ).

* Example 3: Filling an Internal Table with Several Rows
**********************************************************************

    carriers = VALUE #(  (  carrier_id = 'AA' carrier_name = 'American Airlines' )
                         (  carrier_id = 'JL' carrier_name = 'Japan Airlines'    )
                         (  carrier_id = 'SQ' carrier_name = 'Singapore Airlines' )
                      ).

    out->write(  `-----------------------------------------` ).
    out->write(  `Example 3: Fill Internal Table with VALUE` ).
    out->write(  carriers ).

* Example 4: Filling one Internal Table from Another
**********************************************************************

    connections = CORRESPONDING #( carriers ).

    out->write(  `--------------------------------------------` ).
    out->write(  `Example 4: CORRESPONDING for Internal Tables` ).
    out->write(  data = carriers
                 name = `Source Table CARRIERS:` ).
    out->write(  data = connections
                 name = `Target Table CONNECTIONS:` ).

* Example 5: MODIFY in a LOOP
**********************************************************************
    out->write(  `----------------------------` ).
    out->write(  `Example 5: MODIFY  in a LOOP` ).

    LOOP AT carriers INTO  carrier
                    WHERE currency_code IS INITIAL.

      carrier-currency_code = 'USD'.
      MODIFY carriers FROM carrier.

    ENDLOOP.

    out->write(  data = carriers
                 name = `Table CARRRIERS after the LOOP:` ).

* Example 6 Fill the internal table with SELECT
*****************************************************************
    out->write(  `----------------------------` ).
    out->write(  `Example 6: Fill the internal table with SELECT to /DMO/FLIGHT content` ).
    SELECT FROM  /dmo/flight
           FIELDS *
           "WHERE carrier_id eq 'SQ' AND  connection_id eq 0001
           INTO CORRESPONDING FIELDS OF TABLE @connections2.

    out->write(  `--------------------------------` ).
    out->write(  `--------------------------------` ).
    out->write(  data = connections2
           name = `Table CONNECTIOS2 BEFORE  the LOOP:` ).
    out->write( |CONNECTINS2 HAVE { lines( connections2 ) } |  ) .
    out->write(  `--------------------------------` ).
    out->write(  `--------------------------------` ).

    LOOP AT connections2 INTO DATA(connection2)  .

      IF connection2-carrier_id = 'SQ' AND connection2-connection_id = 001.
        APPEND VALUE #( carrier_id       = connection2-carrier_id
                        connection_id    = connection2-connection_id

                       )
            TO connections3.
      ENDIF.



    ENDLOOP.
      READ TABLE connections3 INTO DATA(connection3) WITH KEY carrier_id = 'SQ'
                                                       connection_id = 0012.
      IF sy-subrc eq 0.
*      out->writ
      endif.
    out->write(  `--------------------------------` ).
    out->write(  `--------------------------------` ).
    out->write(  data = connections3
           name = `Table CONNECTIOS3 AFTER the LOOP:` ).

    out->write( |CONNECTINS3 HAVE { lines( connections3 ) } |  ) .

* Example 7 Fill the internal table with SELECT and read
*With READ TABLE WITHOUT KEYS
*****************************************************************
    out->write(  `----------------------------` ).
    out->write(  `Example 7: Fill the internal table with SELECT to /DMO/FLIGHT content` ).
    out->write(  `and READ TABLE i_table  INTON wa_structur WITH KEY campo = VALOR` ).
    SELECT  FROM  /dmo/flight

           FIELDS *
           "WHERE carrier_id eq 'SQ' AND  connection_id eq 0001
           INTO CORRESPONDING FIELDS OF table  @connects_flights.

    IF sy-subrc = 0.
*     READ TABLE connects_flights INTO wa_connect_flight index 6.
      READ TABLE connects_flights into wa_connect_flight WITH KEY carrier_id = 'SQ' connection_id = 0012.
      out->write( |POSITION OF ELEMENT IS: { sy-tabix } | ).

*Para buscar la posicion de un elemento en la tabla con READ TABLE QUE CUMPLA LAS CONDICIONES
      DATA(lv_index) = line_index( connects_flights[ carrier_id = 'SQ'  ] ). " [ carrier_id = 'SQ'  connection_id = 0012 ] ).

      DATA(lv_index2) = line_index( connects_flights[ carrier_id = 'SQ' connection_id = 0012 ] ). " [ carrier_id = 'SQ'  connection_id = 0012 ] ).

    ENDIF.

* Example 8 Fill the internal table /dmo/airport with SELECT and after
* read in LOOP AT  it_table INTO  wa_area WHERE Condition
* read the last row with READ TABLE statement.
*With READ TABLE WITHOUT KEYS
*****************************************************************
 DATA: it_airport TYPE table of /dmo/airport,
       st_airport TYPE /dmo/airport.
    out->write(  `----------------------------` ).
    out->write(  `Example 8 Fill the internal table /dmo/airport with SELECT and after ` ).
    out->write(  `read in LOOP AT  it_table INTO  wa_area WHERE Condition` ).

   SELECT from /dmo/airport
          FIELDS *
        "  WHERE country eq 'DE'
          into table @it_airport.

*    LOOP AT it_airport INTO st_airport where country EQ 'FR' AND name = 'Charles de Gaulle Airport'.
*      EXIT.
*    ENDLOOP.

*This LOOP AT is done for posicioning on last row of the it_airport and
* the structure st_airport will contain this one data
   LOOP AT it_airport INTO st_airport.  "where country EQ 'FR' AND name = 'Charles de Gaulle Airport'.
      " EXIT.
    ENDLOOP.

    out->write( | Exmaple 8 READ TABLE to last record simulation | ).
    out->write(  data = st_airport
           name = `Structure ST_AIRPORT AFTER the LOOP:` ).

    out->write( | Internal table IT_AIRPORT HAS   {  lines( it_airport ) } rows | ).

*Thes READ TABLE senctence will do that structure st_airport containt the last row data
*of internal table it_airport

     READ TABLE it_airport into st_airport index ( lines( it_airport  ) ) .

    out->write( data = st_airport
                name = 'Structure ST_AIRPORT with last row' ).

  ENDMETHOD.
ENDCLASS.
