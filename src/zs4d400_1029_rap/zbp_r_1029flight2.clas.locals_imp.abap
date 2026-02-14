CLASS lhc_zr_1029flight2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Zr1029flight2
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Zr1029flight2~validatePrice.
ENDCLASS.

CLASS lhc_zr_1029flight2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatePrice.
    DATA failed_record LIKE LINE OF failed-zr1029flight2.
    DATA reported_record LIKE LINE OF reported-zr1029flight2.

    READ ENTITIES OF zr_1029flight2 IN LOCAL MODE
      ENTITY Zr1029flight2
        FIELDS ( Price )
        WITH CORRESPONDING #( keys )
        RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).
      IF flight-price <= 0.

        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-zr1029flight2.

        reported_record-%tky = flight-%tky.

        reported_record-%msg = new_message(
                               id       =  'ZCL_MESSAGE_FLIGHT2'
                               number   = '101'
                               severity = ms-information ).
        APPEND reported_record TO reported-zr1029flight2.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
