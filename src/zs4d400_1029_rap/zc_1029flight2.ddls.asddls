@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBO1029FLIGHT2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1029FLIGHT2
  provider contract transactional_query
  as projection on ZR_1029FLIGHT2
  association [1..1] to ZR_1029FLIGHT2 as _BaseEntity on $projection.UUID = _BaseEntity.UUID and $projection.CarrierID = _BaseEntity.CarrierID and $projection.ConnectionID = _BaseEntity.ConnectionID and $projection.FlightDate = _BaseEntity.FlightDate
{
  key UUID,

@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.8
@Search.ranking: #MEDIUM
@ObjectModel.text.element: [ 'CarrierID' ]
  key CarrierID,
  key ConnectionID,
  key FlightDate,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyCode,
  PlaneTypeID,
  SeatsMax,
  SeatsOccupied,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
