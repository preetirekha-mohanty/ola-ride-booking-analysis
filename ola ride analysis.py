
import pandas as pd

# Read the July worksheet
df = pd.read_excel(
    "Bookings-Dataset.xlsx",
    sheet_name="July"
)

print("Original shape:", df.shape)

# 1. Trim spaces from column names
df.columns = df.columns.str.strip()

# 2. Trim spaces from text values
for col in df.select_dtypes(include=["object","str"]).columns:
    df[col] = df[col].map(
        lambda x: x.strip() if isinstance(x, str) else x
        )

# 3. Replace Excel error values with missing values
df = df.replace("#NAME?", pd.NA)

# 4. Remove completely duplicate rows
print("Exact duplicates:", df.duplicated().sum())
df = df.drop_duplicates()

# 5. Remove duplicate booking IDs
print(
    "Duplicate Booking_ID values:",
    df["Booking_ID"].duplicated().sum()
)

df = df.drop_duplicates(
    subset=["Booking_ID"],
    keep="first"
)

# 6. Remove the unusable Vehicle Images column
if "Vehicle Images" in df.columns:
    df = df.drop(columns=["Vehicle Images"])

# 7. Save the cleaned data as CSV
df.to_csv(
    "Bookings_Cleaned.csv",
    index=False,
    encoding="utf-8-sig"
)

print("Cleaned shape:", df.shape)
print("Cleaning completed!")
print("Saved as Bookings_Cleaned.csv")

from sqlalchemy import create_engine

# MySQL connection
username = "root"
password = "Your Password"
host = "localhost"
port = "3306"
database = "Ola"

engine = create_engine(f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}")

# Write DataFrame to MySQL
table_name = "bookings"   # choose any table name
df.to_sql(table_name, engine, if_exists="replace", index=False)

# Read back sample
pd.read_sql("SELECT * FROM bookings LIMIT 5;", engine)