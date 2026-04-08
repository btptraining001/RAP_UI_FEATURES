@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Interface CDS : Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZVKMON01_RI_SO
  as select from zvkmon01_dt_so
  composition [1..*] of ZVKMON01_I_SOIT as _Item

  association to ZVKMON01_I_CUST        as _Cust on $projection.Buyer = _Cust.CustId
{
  key soid               as Soid,
      buyer              as Buyer,
      sales_person       as SalesPerson,
      sales_timestamp    as SalesTimestamp,
      sales_manager      as SalesManager,
      approval_timestamp as ApprovalTimestamp,
      created_by         as CreatedBy,
      created_on         as CreatedOn,
      changed_by         as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      @Semantics.systemDateTime.localInstanceLastChangedAt: true

      changed_on         as ChangedOn,
      url                as Url,
      _Item, // Make association public
      _Cust
}
