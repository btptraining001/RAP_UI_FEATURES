@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS : Item'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZVKMON01_C_SOIT
  as projection on ZVKMON01_I_SOIT
{
  key Soid,
  key ItemId,
      Product,
      Amount,
      Currency,
      SalesPerson,
      SalesTimestamp,
      SalesManager,
      ApprovalTimestamp,
      ChangedBy,
      ChangedOn,
      ImageItem,
      /* Associations */
      _DLSH   : redirected to composition child ZVKMON01_C_DLSH,
      _Header : redirected to parent ZVKMON01_RC_SO,
      _INV    : redirected to composition child ZVKMON01_C_INV,
      _Prod
}
