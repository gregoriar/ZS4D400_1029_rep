*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition create private.

  public section.

   DATA: carrier_id TYPE /DMO/CARRIER_ID,
         connection_id type /DMO/CONNECTION_ID.

   CLASS-DATA conn_counter type i.

  protected section.
  private section.

endclass.

class lcl_connection implementation.

endclass.
