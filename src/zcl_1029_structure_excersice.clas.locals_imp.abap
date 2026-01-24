*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i READ-ONLY.
    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id

      RAISING
        cx_ABAP_INVALID_VALUE.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.



  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/airport_name,
      END OF st_details.

    DATA: connection_id   TYPE /dmo/connection_id,
          carrier_id      TYPE  /dmo/carrier_id,


          airport_from_id TYPE /dmo/airport_from_id,
          airport_to_id   TYPE /dmo/airport_to_id,

          carrier_name    TYPE /dmo/carrier_name.


    DATA details TYPE st_details.


ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.

    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection:  { connection_id   }|                    TO r_output.
    APPEND |Departure:   { details-departureairport  }|          TO r_output.
    APPEND |Destination:{ details-destinationairport }|          TO r_output.

  ENDMETHOD.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.

      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name AS  AirlineName
         WHERE AirlineID    = @i_carrier_id
           AND ConnectionID = @i_connection_id
*          INTO ( @airport_from_id, @airport_to_id, @carrier_name  ).
*          INTO @details.
           INTO CORRESPONDING FIELDS OF @details.


    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter += 1.
  ENDMETHOD.

ENDCLASS.
