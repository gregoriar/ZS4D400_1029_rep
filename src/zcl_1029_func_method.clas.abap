CLASS zcl_1029_func_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_FUNC_METHOD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections  TYPE TABLE OF REF TO lcl_connection.

* Create Instance
**********************************************************************
* First Instance
    connection = NEW #(  ).

*Llamada 1 al metodo sin exception
*    connection->set_attributes(
*      EXPORTING
*        i_carrier_id    = 'LH'
*        i_connection_id = '0400'
*    ).
*LLAMADA 1 AL MÉTODO CON EXCEPTION
    TRY.
        connection->set_attributes(
          i_carrier_id    = 'LH'
          i_connection_id = 400     ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `First  Method call failed` ).
    ENDTRY.


* Second Instance 2
    connection = NEW #(  ).

*Llamda a la segunda instancia, antes de incorporar el manejo de la exception
*    connection->set_attributes(
*      EXPORTING
*        i_carrier_id    = 'AA'
*        i_connection_id = '0300'
*    ).

*Llamada 2 al método set_attributes, una vez habilitada la exception  cx_abap_invalid_value.
  TRY.
    connection->set_attributes(
        i_carrier_id    = 'AA'
        i_connection_id = 0 ).
         APPEND connection TO connections.
   CATCH cx_abap_invalid_value.
      out->write( `Second Method call failed` ).
  ENDTRY.

* Use Calling Functional Method
**********************************************************************
*    " in a value assignment (with inline declaration for result)
*    DATA(result) = connection->get_output( ).
*
*    " in logical expression
*    IF connection->get_output(  ) IS NOT INITIAL.
*
*      " as operand in a statement
*      LOOP AT connection->get_output(  ) INTO DATA(line).
*
*      ENDLOOP.
*
*      "  to supply input parameter of another method
*
*
*      out->write( data = connection->get_output( )
*                  name = `  ` ).
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( |******************************| ).
*      out->write( | \n | ).
*
*
*    ENDIF.
*Agregado, imprime los elementos de connectios
*************************************************************************
    LOOP AT connections INTO DATA(conection).
*      out->write( data = conection1
*              name = ` ` ).  "Funciona con el defoult, debo averiguar la sintaxys
      out->write( conection->get_output( ) ).
      out->write( |Total Stored Conections: { lines( connections ) } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
