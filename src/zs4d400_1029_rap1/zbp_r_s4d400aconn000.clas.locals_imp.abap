CLASS lhc_zr_s4d400aconn000 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrS4d400aconn000
        "    REQUEST requested_authorizations FOR Connection
        RESULT result,

      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrS4d400aconn000~CheckSemanticKey. " Alias de Behaviour Definition ZrS4d400aconn000
    " IMPORTING keys FOR Connection~CheckSemanticKey.
ENDCLASS.

CLASS lhc_zr_s4d400aconn000 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CheckSemanticKey.

    READ ENTITIES OF zr_s4d400aconn000 IN LOCAL MODE
    ENTITY ZrS4d400aconn000 FIELDS ( UUID CarrierID ConnectionID )
    WITH CORRESPONDING #( keys )  "Se leen estas keys en la Entidad zr_s4d400aconn000 (alias ZrS4d400aconn000)
    RESULT DATA(connections). "El resultado de esta lectura se guarda en connections (que es analizada en el siguiente loop at

    LOOP AT connections INTO DATA(connection).

      SELECT FROM zs4d400aconn "Se buscan en la tabla transparente activa zs4d400aconn los valores recuperados en connections (para CarrierID y ConnectionID
      FIELDS uuid
      WHERE carrier_id = @connection-CarrierID AND connection_id = @connection-ConnectionID
      UNION
      SELECT FROM  zs4d400conn000_d "Se buscan en la tabla transparente Draft zs4d400aconn_d los valores recuperados en connections (para CarrierID y ConnectionID
      FIELDS uuid
      WHERE carrierid = @connection-CarrierID AND connectionid = @connection-ConnectionID
      INTO TABLE @DATA(check_result). "check_result contiene los valores ingresados por el usuario, si estos ya existen en las tablas zs4d400aconn y/o  zs4d400conn000_d
                                      "en cuyo caso, su ya existen estos valores en las tablas, significa que se intenta crear una conexión que ya esta creada previamente,
                                      "por lo que debe lanzarse a la IU un mensaje de que ya existen esta conexión (Clave semántica)
      IF check_result IS NOT INITIAL.
        DATA(message) =  me->new_message(
                             id = 'ZCL_MESSAGE_FLIGHT'
                             number = '001'
                             severity = ms-error
                             v1 = connection-CarrierID
                             v2 = connection-ConnectionID ).

        DATA reported_record LIKE LINE OF reported-zrs4d400aconn000.
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.
        reported_record-%element-connectionid = if_abap_behv=>mk-on.
        APPEND reported_record to reported-zrs4d400aconn000.
      ENDIF.
      "*** falta compiar el reporte de errores
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
