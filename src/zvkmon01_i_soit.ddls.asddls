@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS : Order Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZVKMON01_I_SOIT
  as select from zvkmon01_dt_soit

  association to parent ZVKMON01_RI_SO as _Header on $projection.Soid = _Header.Soid

  association to ZVKMON01_I_PROD       as _Prod   on $projection.Product = _Prod.ProdId
  
  Composition [1..*] of ZVKMON01_I_INV as _Inv
  
  Composition [1..*] of ZVKMON01_I_DLSH as _dlsh
{
  key soid               as Soid,
  key item_id            as ItemId,
      product            as Product,
      @Semantics.amount.currencyCode: 'Currency'
      amount             as Amount,
      currency           as Currency,
      sales_person       as SalesPerson,
      sales_timestamp    as SalesTimestamp,
      sales_manager      as SalesManager,
      approval_timestamp as ApprovalTimestamp,
      changed_by         as ChangedBy,
      changed_on         as ChangedOn,
      image_item         as ImageItem,
      _Header,
      _Prod,
      _INV,
      _DLSH
}
