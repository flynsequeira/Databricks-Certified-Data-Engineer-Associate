-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Creating Delta Lake Tables
-- MAGIC - Open source storage framwork that bring reliability in data lake
-- MAGIC - Data Lake - storage Framework/layer, not format/medium. Enables Building Lakehouse, but not warehouse or db service
-- MAGIC ### Delta Lake
-- MAGIC - Cluster : DELTA LAKE -> Storage: Data + Transaction Log
-- MAGIC ### Trnansaction log
-- MAGIC - Ordered records of every transaction performed on table
-- MAGIC - Single so¨®ce of truth
-- MAGIC - JSON file contians commit info: 
-- MAGIC   - Operation Performed + Predicates used
-- MAGIC   - Data files affected (added/removed)
-- MAGIC ### Eg. of Transactio log - Writes/REads
-- MAGIC - writes -> logs write -> logs read -> reads data
-- MAGIC - update data -> add transaction log [delete file_1.parquet, and adds file_3.parquet] -> read transaction log -> read data from file 2 and 3
-- MAGIC - WRITE + READ Parallel again
-- MAGIC   - parallel writer process: 1. write data -> 4. add transaction log [adds file_4.parquet] -> 
-- MAGIC   - parallel preader process: 2. read transaction log -> 3. read data from file 2 and 3 |  read will never have dead lock state or conflice
-- MAGIC - WRITE + FaILure of write
-- MAGIC   - writeer writes file5 -> reader reads 2,3,4 and doesn't read 5 because it has dirty data.
-- MAGIC ### Delta lake advantages
-- MAGIC - Brings ACID
-- MAGIC - Handles Scalable Metadata
-- MAGIC - Full audit trail of all changes
-- MAGIC - Builds upon standard data formats: parquet + json
-- MAGIC

-- COMMAND ----------

USE CATALOG hive_metastore

-- COMMAND ----------

CREATE TABLE employees
  (id INT, name STRING, salary DOUBLE);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Catalog Explorer
-- MAGIC
-- MAGIC Check the created **employees** table in the **Catalog** explorer.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Inserting Data

-- COMMAND ----------

-- NOTE: With latest Databricks Runtimes, inserting few records in single transaction is optimized into single data file.
-- For this demo, we will insert the records in multiple transactions in order to create 4 data files.

INSERT INTO employees
VALUES 
  (1, "Adam", 3500.0),
  (2, "Sarah", 4020.5);

INSERT INTO employees
VALUES
  (3, "John", 2999.3),
  (4, "Thomas", 4000.3);

INSERT INTO employees
VALUES
  (5, "Anna", 2500.0);

INSERT INTO employees
VALUES
  (6, "Kim", 6200.3)

-- NOTE: When executing multiple SQL statements in the same cell, only the last statement's result will be displayed in the cell output.

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table Metadata

-- COMMAND ----------

DESCRIBE DETAIL employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table Directory

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Updating Table

-- COMMAND ----------

UPDATE employees 
SET salary = salary + 100
WHERE name LIKE "A%"

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees'

-- COMMAND ----------

DESCRIBE DETAIL employees

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Exploring Table History

-- COMMAND ----------

DESCRIBE HISTORY employees

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees/_delta_log'

-- COMMAND ----------

-- MAGIC %fs head 'dbfs:/user/hive/warehouse/employees/_delta_log/00000000000000000005.json'

-- COMMAND ----------


