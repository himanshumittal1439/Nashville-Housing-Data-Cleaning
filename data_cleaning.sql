-- To change the format of sale date as it was previosly month name, date , year 

select saledate from nashville_housing nh 

UPDATE nashville_housing nh 
SET saledate = STR_TO_DATE(saledate, '%M %e, %Y');
select saledate from nashville_housing nh

select * from nashville_housing nh 


-- There are values that were null but due to csv changed into empty string  ''
-- Removed all empty strings from the address

select a.parcelid, a.propertyaddress ,b.ParcelID  , b.propertyaddress ,
ifnull(nullif(a.propertyaddress,''), b.propertyaddress)
from nashville_housing a 
join nashville_housing b 
	on a.parcelid = b.parcelid 
	and a.id <> b.id 
	where trim(a.propertyaddress) = '';

UPDATE nashville_housing a
JOIN nashville_housing b
    ON a.parcelid = b.parcelid
    AND a.id <> b.id
SET a.propertyaddress =
    IFNULL(NULLIF(a.propertyaddress, ''), b.propertyaddress)
WHERE TRIM(a.propertyaddress) = '';

-- breaking out adress into indivisual coulumn ( address, city, state)

select propertyaddress from nashville_housing nh 

SELECT
    SUBSTRING_INDEX(propertyaddress, ',', 1) AS address,
    SUBSTRING_INDEX(propertyaddress, ',', -1) AS city
FROM nashville_housing;

select * from nashville_housing nh 

ALTER TABLE nashville_housing
ADD property_split_address VARCHAR(255),
ADD property_split_city VARCHAR(255);
UPDATE nashville_housing
SET
    property_split_address = SUBSTRING_INDEX(propertyaddress, ',', 1),
    property_split_city = TRIM(SUBSTRING_INDEX(propertyaddress, ',', -1));

-- spliting the owner address now

select substring_index(owneraddress , ',' , 1) as address ,
trim(
substring_index
(substring_index(owneraddress , ',' , 2) ,  ',', -1)) as city ,
trim(SUBSTRING_INDEX(owneraddress, ',', -1))as state from nashville_housing;

ALTER TABLE nashville_housing
ADD owner_split_address VARCHAR(255),
ADD owner_split_city VARCHAR(255),
ADD owner_split_state VARCHAR(50);

update nashville_housing nh set
owner_split_address = substring_index(owneraddress , ',' , 1)  , 
owner_split_city=trim(
substring_index
(substring_index(owneraddress , ',' , 2) ,  ',', -1))  ,
owner_split_state = trim(SUBSTRING_INDEX(owneraddress, ',', -1));

select * from nashville_housing nh 

-- changing y and n to yes and no in 'soldasvacant'  field

select distinct(soldasvacant) from nashville_housing nh 

SELECT
    CASE
        WHEN soldasvacant = 'Y' THEN 'Yes'
        WHEN soldasvacant = 'N' THEN 'No'
        ELSE soldasvacant
    END AS cleaned_value
FROM nashville_housing;

UPDATE nashville_housing
SET soldasvacant = CASE
     WHEN soldasvacant = 'Y' THEN 'Yes'
     WHEN soldasvacant = 'N' THEN 'No'
    ELSE soldasvacant
END;

-- removing duplicate rows


DELETE FROM nashville_housing
WHERE id IN (
    SELECT id FROM (
        SELECT id,
               ROW_NUMBER() OVER (
                   PARTITION BY parcelid,
                                propertyaddress,
                                saleprice,
                                saledate,
                                legalreference
                   ORDER BY id
               ) AS row_num
        FROM nashville_housing
    ) t
    WHERE row_num > 1
);

-- Validation step
with rownumcte as(
select * , 
	row_number() over ( 
	partition by parcelid,
		propertyaddress , 
		saleprice,
		saledate, 
		legalreference order by id) row_num
from nashville_housing nh )
select * from rownumcte
where row_num >1 
order by propertyaddress


-- deleting unused column

select * from nashville_housing nh  

alter table nashville_housing 
drop column owneraddress,
drop column taxdistrict ,
drop column  propertyaddress

