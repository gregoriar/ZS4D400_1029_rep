@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBO1029FLIGHT2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1029FLIGHT2
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_1029FLIGHT2
  association [1..1] to ZR_1029FLIGHT2 as _BaseEntity on $projection.UUID = _BaseEntity.UUID and $projection.CARRIERID = _BaseEntity.CARRIERID and $projection.CONNECTIONID = _BaseEntity.CONNECTIONID and $projection.FLIGHTDATE = _BaseEntity.FLIGHTDATE
{
  key UUID,
  key CarrierID,
  key ConnectionID,
  key FlightDate,
  @Semantics: {
    Amount.Currencycode: 'CurrencyCode'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  CurrencyCode,
  PlaneTypeID,
  SeatsMax,
  SeatsOccupied,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
