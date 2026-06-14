# 🏠 Nashville Housing Data Cleaning (MySQL)

## 📊 Project Overview

This project demonstrates a complete data cleaning workflow in **MySQL** using the Nashville Housing dataset. The objective was to transform raw housing data into a clean, structured, and analysis-ready dataset by handling missing values, standardizing formats, removing duplicates, and optimizing the table structure.

The dataset contains housing records, including property details, sales information, and ownership data.

---

## 📂 Dataset

* Source: Nashville Housing Dataset
* Records: Housing sales and property information
* Format: CSV
* Database: MySQL

---

## 🧹 Data Cleaning Tasks

### 1. Standardized Date Format

* Converted `SaleDate` from text format into MySQL `DATE` format using `STR_TO_DATE()`.

### 2. Handled Missing Values

* Identified missing values stored as empty strings (`''`).
* Replaced missing `PropertyAddress` values using a self-join on `ParcelID`.

### 3. Split Address Columns

**Property Address**

* Address
* City

**Owner Address**

* Address
* City
* State

Used:

* `SUBSTRING_INDEX()`
* `TRIM()`

### 4. Standardized Categorical Values

Converted:

* `Y` → `Yes`
* `N` → `No`

in the `SoldAsVacant` column.

### 5. Removed Duplicate Records

Used the `ROW_NUMBER()` window function to identify duplicate records based on:

* `ParcelID`
* `PropertyAddress`
* `SalePrice`
* `SaleDate`
* `LegalReference`

Retained the first occurrence and removed duplicates.

### 6. Dropped Unused Columns

Removed unnecessary columns:

* `OwnerAddress`
* `TaxDistrict`
* `PropertyAddress`

---

## 🛠️ Tools Used

* MySQL
* DBeaver
* SQL Window Functions
* String Manipulation Functions

---

## 📁 Project Structure

```text
Nashville-Housing-Data-Cleaning/
│
├── data/
│   └── nashville_housing.csv
│
├── data_cleaning.sql
├── README.md
│
└── screenshots/
    ├── before_cleaning.png
    └── after_cleaning.png
```



## 🚀 Key Learnings

* Cleaning real-world datasets using SQL
* Handling NULL values and empty strings
* Data transformation with string functions
* Duplicate detection using window functions
* Building a complete data-cleaning workflow

---

## 📌 Conclusion

This project strengthened my practical SQL skills by applying data-cleaning techniques commonly used in real-world data analytics workflows. The final dataset is structured, consistent, and ready for further analysis or visualization.
