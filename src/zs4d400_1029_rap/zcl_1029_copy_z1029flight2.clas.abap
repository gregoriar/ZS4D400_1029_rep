CLASS zcl_1029_copy_z1029flight2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_COPY_Z1029FLIGHT2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*   DELETE  FROM z1029flight2.
    DATA: lv_user                  TYPE abp_creation_user,
          lv_local_create_at       TYPE abp_creation_tstmpl,

          lv_local_last_changed_by TYPE abp_locinst_lastchange_user,
          lv_local_last_change_at  TYPE abp_locinst_lastchange_tstmpl,
          lv_last_changed_at       TYPE abp_lastchange_tstmpl.

    lv_user            = cl_abap_context_info=>get_user_technical_name( ).
    "lv_local_create_at = cl_abap_context_info=>get_system_date(  ).

    INSERT  z1029flight2 FROM (
                 SELECT FROM    /dmo/flight     as f

  "Technical Key
                  FIELDS uuid(  )                    AS uuid,

   "Semantic Key
                                carrier_id         AS carrier_id ,
                                connection_id      AS  connection_id,
                                flight_date        AS  flight_date,
   "Ordinary Fields
                                price              AS  price,
                                currency_code      AS  currency_code,
                                plane_type_id      AS  plane_type_id,
                                seats_max          AS  seats_max,
                                seats_occupied     AS  seats_occupied,

   "Administrative Field for RAP
                               @lv_user                   AS  local_created_by,
                               @lv_local_create_at        AS  loca_created_at,
                               @lv_user                   AS  local_last_changed_by,
                               @lv_local_last_change_at   AS  local_last_change_at,
                               @lv_last_changed_at        AS  last_changed_at

                ).


    IF sy-subrc EQ 0.
      out->write( | Z1029FLIGHT2  ........... { sy-dbcnt } rows inserted in process.| ).
      COMMIT WORK.
    ELSE.
    out->write( | Here have been problems inserting rows, sy-subrc ........... { sy-subrc } .| ).
    ENDIF.
    "PARA BORRAR
*    IF sy-subrc EQ 0.
*      out->write( | Z1029FLIGHT2 ........... { sy-dbcnt } rows deleted in process.| ).
*      COMMIT WORK.
*    ELSE.
*      out->write( | Deleted for Z1029FLIGHT2 sy-subrc ........... { sy-subrc } Records have not been deleted.| ).
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
