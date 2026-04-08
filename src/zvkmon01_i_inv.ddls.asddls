@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS : Item Invoice'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZVKMON01_I_INV
  as select from zvkmon01_dt_inv

  association to parent ZVKMON01_I_SOIT as _Item on $projection.Soid = _Item.Soid
  and $projection.ItemId = _Item.ItemId

  association to ZVKMON01_RI_SO as _Header on $projection.Soid = _Header.Soid    
{
  key soid        as Soid,
  key item_id     as ItemId,
  key invoice_id  as InvoiceId,
      buyer       as Buyer,
      @Semantics.amount.currencyCode:'Currency'
      billing_amt as BillingAmt,
      currency    as Currency,
      _Item,
      _Header
}
