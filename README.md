PlatinumRx Data Analyst Assignment
Welcome to my submission for the PlatinumRx Data Analyst Assignment. This repository contains all the required SQL schemas, analytical queries, spreadsheet models, and Python scripts, organised logically into three phases.

Phase 1: Database Management (SQL)
Hotel System: Includes schema setup (01_Hotel_Schema_Setup.sql) and analytical queries (02_Hotel_Queries.sql). The queries use window functions and aggregations to extract insights from user, booking, and commercial data.

Clinic System: Includes schema setup (03_Clinic_Schema_Setup.sql) and performance queries (04_Clinic_Queries.sql). These scripts generate combined reports on revenue versus expenses to clearly identify profitable and non-profitable clinic branches.

Phase 2: Data Manipulation (Spreadsheets)
Ticket Analysis (Ticket_Analysis.xlsx): To ensure accuracy and automate repetitive data entry, this spreadsheet was programmatically generated using a custom Python script (Create_Ticket_Analysis.py using openpyxl).

Methodology: The spreadsheet uses advanced formulas, including INDEX/MATCH to link ticket dates with customer feedback, and COUNTIFS alongside text-parsing logic to analyse ticket volumes per outlet.

Phase 3: Programming Logic (Python)
Time Conversion (01_Time_Converter.py): A script that translates raw minutes into a readable "hours and minutes" format, specifically built to handle grammatical edge cases (like singular vs. plural formatting).

Duplicate Removal (02_Remove_Duplicates.py): A straightforward algorithm that removes duplicate characters from any given string while preserving the original character order.

How to Run the Code
Python Scripts: Ensure you are using a Python 3.x environment. You can run any script locally via your terminal: python {filename}.py

Spreadsheet Generation: If you need to regenerate the Excel file from scratch, simply run Create_Ticket_Analysis.py. Note: You will need the openpyxl library installed (pip install openpyxl). The generated file will contain all the raw data and dynamic formulas ready for evaluation.
