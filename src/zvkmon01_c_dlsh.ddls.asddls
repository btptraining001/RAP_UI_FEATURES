@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS : Item Delivery Schedule'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZVKMON01_C_DLSH
  as projection on ZVKMON01_I_DLSH
{
  key Soid,
  key ItemId,
  key DelvId,
      Product,
      Quantity,
      DeliveryDate,
      /* Associations */
      _Header : redirected to ZVKMON01_RC_SO,
      _Item   : redirected to parent ZVKMON01_C_SOIT
}
