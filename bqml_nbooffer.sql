--Data preparation from customer 1st party data and 3rd party google analytics datasets
#standardsql

--Creation of the product_sub_type_cd prediction with propensity scores
#standardsql
CREATE OR REPLACE MODEL custinsights.nbooffer
OPTIONS
  (model_type='logistic_reg', input_label_cols=['Product_sub_type_cd']) AS 
  SELECT Cust_Date, Cust_code, Emp_IDX, Cust_residance, Sex
        , age
        , First_contact_Date
        , New_cust_idx
        , Customer_Seniority
        , Cust_Status
        , Last_Dt_Primary
        , Customer_type
        , Cust_Relation, Customer_Channel, Product_name
        , Product_sub_type_cd, pageCategory, timeOnPage 
    FROM `stately-planet-181816.custinsights.cust_data_prep`
  
--Execution of the model 
 #standardsql
SELECT * FROM ML.EVALUATE(MODEL custinsights.nbooffer,
(
SELECT Cust_Date
      , Cust_code
      , Emp_IDX
      , Cust_residance
      , Sex, age
      , First_contact_Date
      , New_cust_idx
      , Customer_Seniority
      , Cust_Status, Last_Dt_Primary, Customer_type, Cust_Relation, Customer_Channel, Product_name
      , Product_sub_type_cd, pageCategory, timeOnPage 
  FROM `stately-planet-181816.custinsights.cust_data_prep`
))
