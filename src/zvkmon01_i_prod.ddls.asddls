@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS : Product'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZVKMON01_I_PROD
  as select from zvkmon01_dt_prod
{
  key prod_id  as ProdId,
      descpt   as Descpt,
      @Semantics.amount.currencyCode: 'Currency'
      price    as Price,
      currency as Currency
}
