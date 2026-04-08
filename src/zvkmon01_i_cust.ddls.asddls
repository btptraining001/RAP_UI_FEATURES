@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS : Customer'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZVKMON01_I_CUST
  as select from zvkmon01_dt_cust
{
  key cust_id            as CustId,
      name               as Name,
      company_name       as CompanyName,
      country            as Country,
      city               as City,
      mobile             as Mobile,
      rating             as Rating,
      local_last_changed as LocalLastChanged,
      last_changed       as LastChanged,
      local_changed_by   as LocalChangedBy,
      last_changed_by    as LastChangedBy
}
