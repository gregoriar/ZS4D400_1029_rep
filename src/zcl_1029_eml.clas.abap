CLASS zcl_1029_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1029_EML IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Declare an internal table with the correct derived type for an EML update of
* entity /DMO/I_AgencyTP (suggested name: agencies_upd).
    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

*Fill the internal table with a single line containing "0700##" as the value for
* the column AGENCYID (where ## stands for your group number) and
*any new value for the column NAME.
    agencies_upd = VALUE #( ( agencyid = '070029' name = 'Some fancy new name' ) ).

*Implement an EML statement MODIFY ENTITIES for the business object interface /DMO/I_AgencyTP.
*Update the data of the root entity, ensuring that only the field NAME is changed.
*Remember that the interface behavior defines alias name /DMO/Agency
*for the root entity /DMO/I_AgencyTP.
    MODIFY ENTITIES OF /dmo/i_agencytp
       ENTITY /dmo/Agency
       UPDATE FIELDS ( name )
         WITH agencies_upd.

*After MODIFY ENTITIES, it is necessary to add a COMMIT ENTITIES statement
*to actually update the data.
    COMMIT ENTITIES.

    out->write( `Method execution finished!`  ).


  ENDMETHOD.
ENDCLASS.
