@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_1029CONNECTION
  as select from z1029connection
{
//Campos Claves 
  key carrier_id as CarrierID, /* comentario bloque */
  key connection_id as ConnectionID,
  airport_from_id as AirportFromID, 
  airport_to_id as AirportToID,
  departure_time as DepartureTime,
  arrival_time as ArrivalTime,
  distance as Distance,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH', 
    entity.element: 'UnitOfMeasure', 
    useForValidation: true
  } ]
  distance_unit as DistanceUnit,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  changedby as Changedby
}
