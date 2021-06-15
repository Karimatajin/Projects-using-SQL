

/* 
Cleaning Data in SQL Queries 
*/ 

SELECT * 
FROM [dbo].[NashvilleHousing]

------------------------------------------------------------------------------------------------------------------

/* Standardize Date Format */

SELECT saleDate, CAST(saleDate AS Date)
FROM [dbo].[NashvilleHousing]

ALTER TABLE [dbo].[NashvilleHousing]
ADD saleDateconverted  Date; 

UPDATE [dbo].[NashvilleHousing]
SET saleDateconverted = CAST(saleDate AS Date)
SELECT *
FROM [dbo].[NashvilleHousing]


--------------------------------------------------------------------------------------------------------------------

/* Populate Property Address Date */ 
/* ISNULL check if the first values is null, then if it's null, you can populate it with a value */ 
SELECT PropertyAddress FROM [dbo].[NashvilleHousing]
WHERE PropertyAddress IS NULL 


SELECT a.[ParcelID], a.PropertyAddress, b.[ParcelID], b.PropertyAddress 
FROM [dbo].[NashvilleHousing] AS a
INNER JOIN [dbo].[NashvilleHousing] AS b 
ON a.[ParcelID] = b.[ParcelID] AND 
a.UniqueID != b.UniqueID
WHERE a.PropertyAddress IS NULL 


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [dbo].[NashvilleHousing] AS a
INNER JOIN [dbo].[NashvilleHousing] AS b 
ON a.[ParcelID] = b.[ParcelID] AND 
a.UniqueID != b.UniqueID
WHERE a.PropertyAddress IS NULL 


/* Breaking out Address into Individual columns (Address, City, State) */ 

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Adress,
SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, CHARINDEX(',', PropertyAddress)) AS City
FROM [dbo].[NashvilleHousing]

ALTER TABLE NashvilleHousing 
ADD PropertyAddressSplit nvarchar(255)

UPDATE NashvilleHousing 
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing 
ADD PropertyCitySplit nvarchar(255)

UPDATE NashvilleHousing 
SET PropertyCitySplit = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, CHARINDEX(',', PropertyAddress))


/* using other method to split the address which's PARSENAME, the method is more usable than SUBSTRING */ 

SELECT 
PARSENAME(REPLACE(ownerAddress,',','.'),3) AS Address,
PARSENAME(REPLACE(ownerAddress,',','.'),2) AS City,
PARSENAME(REPLACE(ownerAddress,',','.'),1) AS State
FROM [dbo].[NashvilleHousing]

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitAddress nvarchar(200)

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitCity nvarchar(200)

ALTER TABLE [dbo].[NashvilleHousing]
ADD OwnerSplitState nvarchar(200)

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitAddress = PARSENAME(REPLACE(ownerAddress,',','.'),3)

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitCity = PARSENAME(REPLACE(ownerAddress,',','.'),2) 

UPDATE [dbo].[NashvilleHousing]
SET OwnerSplitState = PARSENAME(REPLACE(ownerAddress,',','.'),1)

----------------------------------------------------------------------------------------------------------------------------------

/*  Change Y and N to Yes and No in "Sold as Vacant" field */

SELECT DISTINCT(SoldAsVacant) , count(SoldAsVacant) AS COUNT
FROM [dbo].[NashvilleHousing]
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant
,CASE WHEN SoldAsVacant = 'N' THEN 'No' 
	  WHEN SoldAsVacant = 'Y' THEN 'Yes' 
      ELSE SoldAsVacant
	  END
FROM [dbo].[NashvilleHousing]

UPDATE [dbo].[NashvilleHousing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No' 
	  WHEN SoldAsVacant = 'Y' THEN 'Yes' 
      ELSE SoldAsVacant
	  END


-----------------------------------------------------------------------------------------------------------------------------------------

/* Remove Duplicate */ 

WITH ROW_NUM_CTE AS 
(SELECT *, 
ROW_NUMBER() OVER(PARTITION BY [ParcelID], [PropertyAddress], [SalePrice] ORDER BY [UniqueID ] ) ROW_NUM 
from [dbo].[NashvilleHousing])

DELETE FROM ROW_NUM_CTE 
WHERE ROW_NUM >1

--- 270 rows were affected --

SELECT * FROM ROW_NUM_CTE 

-----------------------------------------------------------------------------------------------------------------------------------------

/* Delete unused columns */ 

ALTER TABLE [dbo].[NashvilleHousing]
DROP COLUMN [TaxDistrict]

SELECT * FROM [dbo].[NashvilleHousing]

