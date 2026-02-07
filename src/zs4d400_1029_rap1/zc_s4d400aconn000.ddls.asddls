@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZS4D400ACONN000'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_S4D400ACONN000
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_S4D400ACONN000
  association [1..1] to ZR_S4D400ACONN000 as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  CarrierID,
  ConnectionID,
  AirportFrom,
  CityFrom,
  CountryFrom,
  AirportTo,
  CityTo,
  CountryTo,
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
