# SQL and Bash: Periodic Table Project

The `element.sh` Bash script queries a PostgreSQL database containing detailed information about chemical elements. You can provide an atomic number, symbol, or full element name, and the script returns the corresponding element’s physical and chemical properties.

Before using the script, I performed several SQL operations to normalize and organize the database schema, ensuring efficient lookups and clean relationships between the elements, properties, and types tables.

## 📌 Features

- Accepts atomic number, symbol, or name as input
    - 1, H, Hydrogen → all valid
- Validates inputs and handles invalid queries gracefully
- Retrieves:
    - Atomic number
    - Symbol
    - Name
    - Atomic mass
    - Melting point (°C)
    - Boiling point (°C)
    - Element type (metal, nonmetal, metalloid, etc.)
- Outputs a readable formatted sentence

## ⚙️ Requirements
Before running this script, ensure that you have:

- 🐘 **PostgreSQL** installed and running  
- A database named **`periodic_table`**.
- A PostgreSQL user named **`freecodecamp`** with access to the database.  
- The following tables present and populated:
  - `elements`
  - `properties`
  - `types`

## 🚀 Usage

Run the script with one argument:

```console
./periodic_table.sh <element>
```


## 🛠 How It Works

1. Accepts user input ($1)
2. Determines whether the input is:
    - An atomic number
    - A valid element symbol
    - A full element name
3. Performs SQL queries to retrieve matching records
4. Fetches the element’s properties
5. Retrieves the element’s type from the types table
6. Outputs everything in a formatted sentence


## 👨‍💻 Author

Created by: Hugo Rocha
