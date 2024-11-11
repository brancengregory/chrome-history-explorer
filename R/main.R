library(duckdb)
library(duckplyr)
library(dplyr)

chrome_history_path <- "./chrome_history.sqlite"

# Copy the db to the local directory because Chrome puts a lock on it
file.copy(
  "~/.config/google-chrome/Default/History", # Adjust based on OS
  chrome_history_path,
  overwrite = TRUE
)

# Connect to DuckDB
con <- dbConnect(duckdb::duckdb())

# Load SQLite extension if not already loaded
dbExecute(con, "INSTALL sqlite;")
dbExecute(con, "LOAD sqlite;")

# Path to the Chrome history SQLite database

# Attach the SQLite database
attach_query <- paste0("ATTACH DATABASE '", chrome_history_path, "' AS chrome_history (TYPE sqlite);")
dbExecute(con, attach_query)

# Check out a table
tbl(con, "chrome_history.urls")

# Close the connection
dbDisconnect(con, shutdown = TRUE)

