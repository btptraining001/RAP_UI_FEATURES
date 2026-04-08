@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS : Item Invoice'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZVKMON01_C_INV
  as projection on ZVKMON01_I_INV
{


  key Soid,
  key ItemId,
  key InvoiceId,
      Buyer,
      BillingAmt,
      Currency,
      /* Associations */
      _Header : redirected to ZVKMON01_RC_SO,
      _Item   : redirected to parent ZVKMON01_C_SOIT

}
