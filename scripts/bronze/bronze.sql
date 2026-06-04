CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	PRINT('=======================================================================');
	PRINT 'loading bronze layer';
	PRINT('=======================================================================');
	PRINT('-----------------------------------------------------------------------');
	PRINT('loading CRM Tables');
	PRINT('-----------------------------------------------------------------------');
	TRUNCATE TABLE bronze.[crm_cust_info]

	BULK INSERT [Datawarehouse].[bronze].[crm_cust_info]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
	FIRSTROW =2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);
	

	TRUNCATE TABLE [Datawarehouse].[bronze].[crm_sales_details];
	BULK INSERT [Datawarehouse].[bronze].[crm_sales_details]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);
	TRUNCATE TABLE [Datawarehouse].[bronze].[prd_info];
	BULK INSERT [Datawarehouse].[bronze].[prd_info]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	TRUNCATE TABLE [Datawarehouse].[bronze].[erp_cust_az12];
	BULK INSERT [Datawarehouse].[bronze].[erp_cust_az12]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)
	TRUNCATE TABLE [Datawarehouse].[bronze].[erp_loc_a101];
	BULK INSERT [Datawarehouse].[bronze].[erp_loc_a101]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	);
	TRUNCATE TABLE [Datawarehouse].[bronze].[erp_px_cust_g1v2];
	BULK INSERT [Datawarehouse].[bronze].[erp_px_cust_g1v2]
	FROM 'C:\Users\sharm\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK

	)
	PRINT('=======================================================================')
END
GO
