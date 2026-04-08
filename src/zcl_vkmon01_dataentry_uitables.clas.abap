CLASS zcl_vkmon01_dataentry_uitables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      if_oo_adt_classrun.

    METHODS:
* Flush the data from the table in each execution
      refresh,

* Enter data in Master Tables
      enter_master_data,

* Enter Data in Transactional Tables
      enter_transactional_Data.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_vkmon01_dataentry_uitables IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*--------------------------------------------------------------------*
* Main entry point — executes the three steps in sequence:
* 1. Clear all tables
* 2. Insert master data (Products & Customers)
* 3. Insert transactional data (Sales Orders, Items, Delivery, Invoice)
*--------------------------------------------------------------------*

    CALL METHOD refresh.
    CALL METHOD enter_master_data.
    CALL METHOD enter_transactional_data.

* If everything is successful display the message
    out->write(
      EXPORTING
        data   = 'Data Entered Successfully'
    ).

  ENDMETHOD.


  METHOD refresh.
*--------------------------------------------------------------------*
* Clears all custom tables before inserting fresh data.
* This ensures no duplicate or stale records remain from prior runs.
*--------------------------------------------------------------------*

    DELETE FROM : zvkmon01_dt_so,    "Sales Order Header
                  zvkmon01_dt_soit,  "Sales Order Item
                  zvkmon01_dt_prod,  "Product Master
                  zvkmon01_dt_cust,  "Customer Master
                  zvkmon01_dt_dlsh,  "Delivery Schedule
                  zvkmon01_dt_inv.   "Invoice

  ENDMETHOD.


  METHOD enter_master_data.
*--------------------------------------------------------------------*
* Populates the Product and Customer master tables.
* Product IDs are generated randomly in the range 1000000–9000000.
* Customer IDs reuse the same random generator (lobj_prod) to ensure
* unique IDs across both tables.
* Each customer has a rating from 1–5 reflecting satisfaction level.
*--------------------------------------------------------------------*

    DATA: li_prod TYPE TABLE OF zvkmon01_dt_prod,
          ls_prod TYPE zvkmon01_dt_prod,
          li_cust TYPE TABLE OF zvkmon01_dt_cust,
          ls_cust TYPE zvkmon01_dt_cust.

    "--------------------------------------------------------------------------------------------------
    "Product Master Data
    "--------------------------------------------------------------------------------------------------

    "Initialize random number generator for product IDs
    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1000000
        max  = 9000000
      RECEIVING
        prng = DATA(lobj_prod).

    "--- Stationery products (INR) ---
    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Pen'
                    price    = '12'
                    currency = 'INR'
                  ) TO li_prod.

    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Pencil'
                    price    = '2'
                    currency = 'INR'
                  ) TO li_prod.

    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Compass Box'
                    price    = '121'
                    currency = 'INR'
                  ) TO li_prod.

    "--- Drawing/tech tools (EUR) ---
    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Drafter'
                    price    = '2'
                    currency = 'EUR'
                  ) TO li_prod.

    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Laptop'
                    price    = '1200'
                    currency = 'EUR'
                  ) TO li_prod.

    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Hard-Disk'
                    price    = '20'
                    currency = 'EUR'
                  ) TO li_prod.

    "--- Computer peripherals (USD) ---
    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'RAM'
                    price    = '120'
                    currency = 'USD'
                  ) TO li_prod.

    APPEND VALUE #(
                    prod_id  = lobj_prod->get_next( )
                    descpt   = 'Mouse'
                    price    = '20'
                    currency = 'USD'
                  ) TO li_prod.

    "Insert all products into the database table in one shot
    INSERT zvkmon01_dt_prod FROM TABLE @li_prod.

    "--------------------------------------------------------------------------------------------------
    "Customer Master Data
    "--------------------------------------------------------------------------------------------------

    "Initialize random number generator for customer IDs (range: 100M–900M)
    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 100000000
        max  = 900000000
      RECEIVING
        prng = DATA(lobj_cust).

    "--- Customer entries with individual ratings (1=Poor, 5=Excellent) ---
    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'Vishal'
                    company_name = 'Tech'
                    country      = 'IN'
                    city         = 'Hyd'
                    mobile       = 231423289
                    rating       = 4           "★★★★☆ - Very Good
                  ) TO li_cust.

    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'Rohit'
                    company_name = 'FineDines'
                    country      = 'IN'
                    city         = 'Pune'
                    mobile       = 23145789
                    rating       = 2           "★★☆☆☆ - Below Average
                  ) TO li_cust.

    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'AJ'
                    company_name = 'AnyAnalytics'
                    country      = 'IN'
                    city         = 'Hyd'
                    mobile       = 2314789
                    rating       = 5           "★★★★★ - Excellent
                  ) TO li_cust.

    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'Rahul'
                    company_name = 'ABC Corps'
                    country      = 'IN'
                    city         = 'Delhi'
                    mobile       = 231434789
                    rating       = 3           "★★★☆☆ - Average
                  ) TO li_cust.

    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'Virat'
                    company_name = 'IT Multi'
                    country      = 'IN'
                    city         = 'Mum'
                    mobile       = 231434789
                    rating       = 1           "★☆☆☆☆ - Poor
                  ) TO li_cust.

    APPEND VALUE #(
                    cust_id      = lobj_prod->get_next( )
                    name         = 'Suraya'
                    company_name = 'IndexIT'
                    country      = 'IN'
                    city         = 'Mum'
                    mobile       = 231412789
                    rating       = 5           "★★★★★ - Excellent
                  ) TO li_cust.

    "Insert all customers into the database table in one shot
    INSERT zvkmon01_dt_cust FROM TABLE @li_cust.

  ENDMETHOD.


  METHOD enter_transactional_data.
*--------------------------------------------------------------------*
* Generates 10 Sales Orders, each with:
*   - 3 Sales Order Items
*   - 2 Delivery Schedule lines per item (qty 2 and qty 7)
*   - 1 Invoice per item
*
* Sales Person, Sales Manager, Created By, Changed By, and Timestamps
* are picked randomly from predefined value pools to add variety.
*--------------------------------------------------------------------*

    DATA:
      li_so       TYPE TABLE OF zvkmon01_dt_so,
      li_soit     TYPE TABLE OF zvkmon01_dt_soit,
      li_delv_sch TYPE TABLE OF zvkmon01_dt_dlsh,
      li_inv      TYPE TABLE OF zvkmon01_dt_inv.

    "--------------------------------------------------------------------------------------------------
    "Read master data to use in transactional entries
    "--------------------------------------------------------------------------------------------------

    SELECT prod_id, price, currency
      FROM zvkmon01_dt_prod
      INTO TABLE @DATA(li_prod).

    SELECT cust_id
      FROM zvkmon01_dt_cust
      INTO TABLE @DATA(li_cust).

    "--------------------------------------------------------------------------------------------------
    "Initialize random number generators for all key fields
    "--------------------------------------------------------------------------------------------------

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 4000000
        max  = 4999999
      RECEIVING
        prng = DATA(lobj_prng_so).       "SO Header ID

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 40000
        max  = 49999
      RECEIVING
        prng = DATA(lobj_prng_soit).     "SO Item ID

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 100000
        max  = 299999
      RECEIVING
        prng = DATA(lobj_prng_dlv).      "Delivery ID

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 8000000
        max  = 9999999
      RECEIVING
        prng = DATA(lobj_prng_inv).      "Invoice ID

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 6
      RECEIVING
        prng = DATA(lobj_cust_count).    "Customer index (6 customers)

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 8
      RECEIVING
        prng = DATA(lobj_prod_count).    "Product index (8 products)

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 3
      RECEIVING
        prng = DATA(lobj_item_count).    "Item count picker

    "--- Random pickers for value pools (1–4 matching pool size) ---
    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 4
      RECEIVING
        prng = DATA(lobj_sp_picker).     "Sales Person picker

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 4
      RECEIVING
        prng = DATA(lobj_sm_picker).     "Sales Manager picker

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 4
      RECEIVING
        prng = DATA(lobj_ts_picker).     "Timestamp pair picker

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 4
      RECEIVING
        prng = DATA(lobj_cb_picker).     "Created By picker

    CALL METHOD cl_abap_random_int=>create
      EXPORTING
        min  = 1
        max  = 4
      RECEIVING
        prng = DATA(lobj_chb_picker).    "Changed By picker

    "--------------------------------------------------------------------------------------------------
    "Define value pools
    "--------------------------------------------------------------------------------------------------

    DATA: lt_sales_persons  TYPE TABLE OF string,
          lt_sales_managers TYPE TABLE OF string,
          lt_created_by     TYPE TABLE OF string,
          lt_changed_by     TYPE TABLE OF string,
          lt_timestamps_cr  TYPE TABLE OF timestamp,
          lt_timestamps_ch  TYPE TABLE OF timestamp.

    "--- Sales Person pool ---
    APPEND 'Alice Johnson'   TO lt_sales_persons.
    APPEND 'Bob Martinez'    TO lt_sales_persons.
    APPEND 'Carol Singh'     TO lt_sales_persons.
    APPEND 'David Lee'       TO lt_sales_persons.

    "--- Sales Manager pool ---
    APPEND 'Rocket Singh'    TO lt_sales_managers.
    APPEND 'Meera Kapoor'    TO lt_sales_managers.
    APPEND 'James Fernandez' TO lt_sales_managers.
    APPEND 'Priya Nair'      TO lt_sales_managers.

    "--- Created By pool ---
    APPEND 'CB9980005587'    TO lt_created_by.
    APPEND 'CB9980007723'    TO lt_created_by.
    APPEND 'CB9980003341'    TO lt_created_by.
    APPEND 'CB9980009965'    TO lt_created_by.

    "--- Changed By pool ---
    APPEND 'CB9980005587'    TO lt_changed_by.
    APPEND 'CB9980001198'    TO lt_changed_by.
    APPEND 'CB9980004456'    TO lt_changed_by.
    APPEND 'CB9980008832'    TO lt_changed_by.

    "--------------------------------------------------------------------------------------------------
    " Timestamp pools — TYPE timestamp (DEC 15)
    " Using CL_ABAP_TSTMP=>SYSTEMTSTMP_SYST2UTC which correctly outputs
    " TYPE timestamp. Dates and times passed as proper D and T typed variables.
    "--------------------------------------------------------------------------------------------------

    DATA: lv_date     TYPE d,
          lv_time     TYPE t,
          lv_ts_short TYPE timestamp.

    "--- Sales (created_on) timestamps ---
    TRY.
        lv_date = '20230115'. lv_time = '120000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_cr.          "2023-Jan-15 12:00

        lv_date = '20230620'. lv_time = '083000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_cr.          "2023-Jun-20 08:30

        lv_date = '20240210'. lv_time = '153000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_cr.          "2024-Feb-10 15:30

        lv_date = '20241105'. lv_time = '094500'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_cr.          "2024-Nov-05 09:45

        "--- Approval (changed_on) timestamps — always after created_on ---
        lv_date = '20230120'. lv_time = '160000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_ch.          "2023-Jan-20 16:00

        lv_date = '20230625'. lv_time = '114500'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_ch.          "2023-Jun-25 11:45

        lv_date = '20240215'. lv_time = '180000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_ch.          "2024-Feb-15 18:00

        lv_date = '20241110'. lv_time = '130000'.
        cl_abap_tstmp=>systemtstmp_syst2utc(
          EXPORTING syst_date = lv_date  syst_time = lv_time
          IMPORTING utc_tstmp = lv_ts_short ).
        APPEND lv_ts_short TO lt_timestamps_ch.          "2024-Nov-10 13:00

      CATCH cx_parameter_invalid_range.
        "Timestamp conversion failed — pools will be empty, check date/time values
    ENDTRY.

    "--------------------------------------------------------------------------------------------------
    "Generate 10 Sales Orders
    "--------------------------------------------------------------------------------------------------

    DO 10 TIMES.

      "--- Sales Order Header ---
      DATA(lv_soid)    = lobj_prng_so->get_next( ).
      DATA(lv_p_count) = lobj_cust_count->get_next( ).

      "Pick random indices for all varied fields
      DATA(lv_sp_idx)  = lobj_sp_picker->get_next( ).
      DATA(lv_sm_idx)  = lobj_sm_picker->get_next( ).
      DATA(lv_ts_idx)  = lobj_ts_picker->get_next( ).
      DATA(lv_cb_idx)  = lobj_cb_picker->get_next( ).
      DATA(lv_chb_idx) = lobj_chb_picker->get_next( ).

      "Resolve timestamps from pool
      DATA(lv_timestmp_created) = lt_timestamps_cr[ lv_ts_idx ].  "Sales timestamp
      DATA(lv_timestmp_changed) = lt_timestamps_ch[ lv_ts_idx ].  "Approval timestamp

      DATA(lv_url) = |https://m.media-amazon.com/images/I/71BLNfkRZ3L._UF1000,1000_QL80_.jpg|.

      APPEND VALUE #(
        soid          = lv_soid
        buyer         = li_cust[ lv_p_count ]-cust_id
        sales_person  = lt_sales_persons[ lv_sp_idx ]
        sales_manager = lt_sales_managers[ lv_sm_idx ]
        created_by    = lt_created_by[ lv_cb_idx ]
        created_on    = lv_timestmp_created
        changed_by    = lt_changed_by[ lv_chb_idx ]
        changed_on    = lv_timestmp_changed
        url           = lv_url
      ) TO li_so.

      INSERT zvkmon01_dt_so FROM TABLE @li_so.

      "--------------------------------------------------------------------------------------------------
      "Generate 3 Items per Sales Order
      "--------------------------------------------------------------------------------------------------

      DO 3 TIMES.

        DATA(lv_item)    = lobj_prng_soit->get_next( ).
        DATA(lv_c_count) = lobj_prod_count->get_next( ).

        "Assign a different product image per item line
        DATA: image_item TYPE string.
        CASE sy-index.
          WHEN 1.
            image_item = 'https://m.media-amazon.com/images/I/71uPkyrlipL.jpg'.
          WHEN 2.
            image_item = |https://m.media-amazon.com/images/I/510uTHyDqGL|
                          && |._UF1000,1000_QL80_.jpg|.
          WHEN 3.
            image_item = |https://m.media-amazon.com/images/I/61SLsEHoOkL|
                          && |._AC_UF1000,1000_QL80_.jpg|.
        ENDCASE.

        APPEND VALUE #(
                        soid       = lv_soid
                        item_id    = lv_item
                        product    = li_prod[ lv_c_count ]-prod_id
                        amount     = li_prod[ lobj_prod_count->get_next( ) ]-price
                        currency   = li_prod[ lobj_prod_count->get_next( ) ]-currency
                        changed_by = lt_changed_by[ lv_chb_idx ]
                        image_item = image_item
                      ) TO li_soit.

        CLEAR image_item.

        "--------------------------------------------------------------------------------------------------
        "2 Delivery Schedule lines per Item — qty 2 and qty 7
        "--------------------------------------------------------------------------------------------------

        DO 2 TIMES.

          "Delivery line 1 — quantity 2, delivery date = today
          APPEND VALUE #(
              soid          = lv_soid
              item_id       = lv_item
              delv_id       = lobj_prng_dlv->get_next( )
              product       = li_prod[ lv_c_count ]-prod_id
              quantity      = 2
              delivery_date = sy-datum
          ) TO li_delv_sch.

          INSERT zvkmon01_dt_dlsh FROM TABLE @li_delv_sch.
          CLEAR li_delv_sch.

          "Delivery line 2 — quantity 7
          APPEND VALUE #(
              soid     = lv_soid
              item_id  = lv_item
              delv_id  = lobj_prng_dlv->get_next( )
              product  = li_prod[ lv_c_count ]-prod_id
              quantity = 7
          ) TO li_delv_sch.

          INSERT zvkmon01_dt_dlsh FROM TABLE @li_delv_sch.
          CLEAR li_delv_sch.

        ENDDO.  "End delivery schedule loop

        "--------------------------------------------------------------------------------------------------
        "1 Invoice per Item
        "--------------------------------------------------------------------------------------------------

        DO 1 TIMES.

          APPEND VALUE #(
              soid        = lv_soid
              item_id     = lv_item
              invoice_id  = lobj_prng_inv->get_next( )
              buyer       = li_cust[ lv_p_count ]-cust_id
              billing_amt = 200
          ) TO li_inv.

          INSERT zvkmon01_dt_inv FROM TABLE @li_inv.
          CLEAR li_inv.

        ENDDO.  "End invoice loop

        INSERT zvkmon01_dt_soit FROM TABLE @li_soit.
        CLEAR li_soit.

      ENDDO.  "End SO Item loop (3 items per SO)

      CLEAR: lv_soid, li_so, li_soit, li_delv_sch, li_inv.

    ENDDO.  "End Sales Order loop (10 SOs total)

  ENDMETHOD.

ENDCLASS.
