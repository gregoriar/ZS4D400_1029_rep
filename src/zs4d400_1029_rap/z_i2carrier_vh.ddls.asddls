@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Help for carrier_id 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'CarrierID'
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #CUSTOMIZING
}
@VDM.viewType: #COMPOSITE
@Search.searchable: true
define view entity Z_I2CARRIER_VH
  as select from /dmo/carrier
{
      @Search.defaultSearchElement: true
      @UI.lineItem: [{position: 10, importance: #HIGH}]
      @ObjectModel.text.element: ['CarrierID']
  key carrier_id as CarrierId,
      name       as Name
      //   currency_code as CurrencyCode,
      //   local_created_by as LocalCreatedBy,
      //    local_created_at as LocalCreatedAt,
      //  local_last_changed_by as LocalLastChangedBy,
      //   local_last_changed_at as LocalLastChangedAt,
      //   last_changed_at as LastChangedA
}
