select *
from portfolio_project.dbo.nashville_Housing

-- Changing date format

SELECT SaleDate, CONVERT(date, SaleDate) 
FROM portfolio_project.dbo.Nashville_Housing

Alter Table Nashville_Housing
Add Sale_Date Date;

Update Nashville_Housing
SET Sale_Date = CONVERT(date, SaleDate)

Alter Table Nashville_Housing
Drop Column SaleDate


--  Filling out NULLS in property data ( using parcel ID if same)

SELECT PropertyAddress
FROM portfolio_project.dbo.Nashville_Housing
where PropertyAddress IS NULL 

Select one.ParcelID, one.PropertyAddress, two.ParcelID, two.PropertyAddress, ISNULL(one.propertyAddress, two.PropertyAddress)
From portfolio_project.dbo.Nashville_Housing one
JOIN portfolio_project.dbo.Nashville_Housing two
ON one.ParcelID = two.ParcelID
and one.[UniqueID ] <> two.[UniqueID ]
where one.PropertyAddress IS NULL

Update one
SET PropertyAddress = ISNULL(one.propertyAddress, two.PropertyAddress)
From portfolio_project.dbo.Nashville_Housing one
JOIN portfolio_project.dbo.Nashville_Housing two
ON one.ParcelID = two.ParcelID
and one.[UniqueID ] <> two.[UniqueID ]
where one.PropertyAddress IS NULL

-- Separating City, State, Address from OwnerAddress

Select OwnerAddress
From portfolio_project.dbo.Nashville_Housing


Select OwnerAddress, PARSENAME(REPLACE(OwnerAddress,',', '.'), 1), 
PARSENAME(REPLACE(OwnerAddress,',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)
From portfolio_project.dbo.Nashville_Housing

ALter table Nashville_Housing
Add Owner_City nvarchar(255) 

Update Nashville_Housing
SET Owner_City = PARSENAME(REPLACE(OwnerAddress,',', '.'), 2)

ALter table Nashville_Housing
ADD Owner_State nvarchar(255);

Update Nashville_Housing
SET Owner_State = PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)


ALter table Nashville_Housing
ADD Owner_Address nvarchar(255);

Update Nashville_Housing
SET Owner_Address = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)


-- Separating City, State, Address from PropertyAddress

Select PropertyAddress
From portfolio_project.dbo.Nashville_Housing

Select PropertyAddress, PARSENAME(REPLACE(PropertyAddress,',', '.'), 1), 
PARSENAME(REPLACE(PropertyAddress,',', '.'), 2)
From portfolio_project.dbo.Nashville_Housing


ALter table Nashville_Housing
Add Property_City nvarchar(255) 

Update Nashville_Housing
SET Property_City = PARSENAME(REPLACE(PropertyAddress,',', '.'), 1)

ALter table Nashville_Housing
Add Property_Address nvarchar(255) 

Update Nashville_Housing
SET Property_Address = PARSENAME(REPLACE(PropertyAddress,',', '.'), 2)



-- SoldAsVacant replacing abbreviations of Y, N with YES and NO

Select SoldAsVacant,
CASE	WHEN SoldAsVacant = 'Y' Then 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END
FROM portfolio_project.dbo.Nashville_Housing 

UPDATE Nashville_Housing
SET SoldAsVacant =  CASE	WHEN SoldAsVacant = 'Y' Then 'YES'
					WHEN SoldAsVacant = 'N' THEN 'NO'
					ELSE SoldAsVacant
					END

Select DISTINCT(SoldAsVacant),  COUNT(SoldAsVacant)
FROM portfolio_project..Nashville_Housing
GROUP BY SoldAsVacant
