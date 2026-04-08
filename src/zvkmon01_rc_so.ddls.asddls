@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Consumption CDS : Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZVKMON01_RC_SO
  provider contract transactional_query
  as projection on ZVKMON01_RI_SO

{
  key Soid,
      Buyer,
      SalesPerson,
      SalesTimestamp,
      SalesManager,
      ApprovalTimestamp,
      CreatedBy,
      CreatedOn,
      ChangedBy,
      ChangedOn,
      Url,
      /* Associations */
      _Cust,
      _Item : redirected to composition child ZVKMON01_C_SOIT
}
