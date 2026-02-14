CLASS zcl_1029_copy_zs4d400aconn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_COPY_ZS4D400ACONN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DELETE  FROM zs4d400aconn.
    DATA: lv_user                  TYPE abp_creation_user,
          lv_local_create_at       TYPE abp_creation_tstmpl,

          lv_local_last_changed_by TYPE abp_locinst_lastchange_user,
          lv_local_last_change_at  TYPE abp_locinst_lastchange_tstmpl,
          lv_last_changed_at       TYPE abp_lastchange_tstmpl.

    lv_user            = cl_abap_context_info=>get_user_technical_name( ).
    "lv_local_create_at = cl_abap_context_info=>get_system_date(  ).

    INSERT  zs4d400aconn FROM (
                 SELECT FROM (  (  /dmo/connection      AS c
                                INNER JOIN /dmo/airport AS a ON  c~airport_from_id =  a~airport_id )
                                INNER JOIN /dmo/airport AS a2 ON c~airport_to_id   =  a2~airport_id )
  "Technical Key
                  FIELDS uuid(  )                    AS uuid,

   "Semantic Key
                                c~carrier_id         AS carrier_id ,
                                c~connection_id      AS connection_id,
   "External Key Field for Inner join
                                c~airport_from_id    AS  airport_from,
                                a~city               AS city_from,
                                a~country            AS country_from,
   "External Key Field for Inner join
                                c~airport_to_id      AS airport_to,
                                a2~city              AS city_to ,
                                a2~country           AS  country_to,
   "Administrative Field for RAP
                               @lv_user                   AS  local_created_by,
                               @lv_local_create_at        AS  loca_created_at,
                               @lv_user                   AS  local_last_changed_by,
                               @lv_local_last_change_at   AS  local_last_change_at,
                               @lv_last_changed_at        AS  last_changed_at

                ).



    IF sy-subrc EQ 0.
      out->write( | zs4400aconn ........... { sy-dbcnt } rows inserted in process.| ).
    ELSE.
    out->write( | here have been problems inserting rows, sy-subrc ........... { sy-subrc } .| ).
    ENDIF.
    "PARA BORRAR
*    IF sy-subrc EQ 0.
*      out->write( | zs4400aconn ........... { sy-dbcnt } rows deleted in process.| ).
*      COMMIT WORK.
*    ELSE.
*      out->write( | El borrado de zs4400acoon arrojo sy-subrc ........... { sy-subrc } no fueron borrados los registros.| ).
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
