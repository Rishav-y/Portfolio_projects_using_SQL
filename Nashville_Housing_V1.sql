SELECT * 
FROM portfolio_project.dbo.housing


-- Changing date format

SELECT SaleDate, CONVERT(date, SaleDate) 
FROM portfolio_project.dbo.Housing

Alter Table Housing
Add Sale_Date Date;

Update Housing
SET Sale_Date = CONVERT(date, SaleDate) 

Alter Table Housing
Drop Column SaleDate


--  Filling out NULLS in property data ( using parcel ID if same)

SELECT PropertyAddress
FROM portfolio_project.dbo.housing
where PropertyAddress IS NULL 


Select one.ParcelID, one.PropertyAddress, two.ParcelID, two.PropertyAddress, ISNULL(one.propertyAddress, two.PropertyAddress)
From portfolio_project.dbo.Housing one
JOIN portfolio_project.dbo.Housing two
ON one.ParcelID = two.ParcelID
and one.[UniqueID ] <> two.[UniqueID ]
where one.PropertyAddress IS NULL

Update one
SET PropertyAddress = ISNULL(one.propertyAddress, two.PropertyAddress)
From portfolio_project.dbo.Housing one
JOIN portfolio_project.dbo.Housing two
ON one.ParcelID = two.ParcelID
and one.[UniqueID ] <> two.[UniqueID ]
where one.PropertyAddress IS NULL



--

SELECT * 
FROM portfolio_project.dbo.housing