# Nashville Housing Data Cleaning (MySQL)

## 📊 Project Overview
This project focuses on cleaning and transforming a raw housing dataset using MySQL.  
The goal was to prepare messy real-world data into a structured and analysis-ready format.

The dataset contains housing records including property details, sale information, and ownership data.

---

## 🧹 Data Cleaning Steps Performed

### 1. Standardized Date Format
- Converted `saledate` from text format (e.g., "Month Day, Year") into MySQL date format using `STR_TO_DATE()`.

---

### 2. Handled Missing Values
- Identified missing values stored as empty strings (`''`) instead of NULL.
- Replaced missing `propertyaddress` values using self-join based on `parcelid`.

---

### 3. Split Address Columns
- Split `propertyaddress` into:
  - Address
  - City
- Split `owneraddress` into:
  - Address
  - City
  - State
- Used string functions like `SUBSTRING_INDEX()` and `TRIM()`.

---

### 4. Standardized Categorical Values
- Converted `soldasvacant` values:
  - 'Y' → 'Yes'
  - 'N' → 'No'

---

### 5. Removed Duplicate Records
- Used `ROW_NUMBER()` window function to identify duplicates.
- Duplicates were defined based on:
  - parcelid
  - propertyaddress
  - saleprice
  - saledate
  - legalreference
- Kept the first occurrence and removed duplicates.

---

### 6. Dropped Unused Columns
- Removed unnecessary columns to clean the final dataset:
  - owneraddress
  - taxdistrict
  - propertyaddress

---

## 🛠️ Tools Used
- MySQL
- DBeaver (for query execution and data inspection)

---

## 📁 Project Structure
📦 Nashville-Housing-Data-Cleaning
┣ 📂 data
┃ ┗ nashville_housing.csv
┣ 📜 data_cleaning.sql
┗ 📜 README.md
L 📂 screenshots
   L before_cleaning.png
   L after_cleaning.png


---

## 🚀 Key Learnings
- Handling real-world messy datasets
- Difference between NULL and empty strings
- SQL string manipulation techniques
- Window functions for duplicate detection
- End-to-end data cleaning workflow

---

## 📌 Notes
This project is part of SQL practice to improve data cleaning and transformation skills using real-world datasets.
