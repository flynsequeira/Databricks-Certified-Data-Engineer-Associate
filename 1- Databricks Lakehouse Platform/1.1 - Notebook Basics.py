# Databricks notebook source
print("Hello World!")

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT "Hello world from SQL!"

# COMMAND ----------

# MAGIC %md
# MAGIC # Title 1
# MAGIC ## Title 2
# MAGIC ### Title 3
# MAGIC
# MAGIC text with a **bold** and *italicized* in it.
# MAGIC
# MAGIC Ordered list
# MAGIC 1. first
# MAGIC 1. second
# MAGIC 1. third
# MAGIC
# MAGIC Unordered list
# MAGIC * coffee
# MAGIC * tea
# MAGIC * milk
# MAGIC
# MAGIC
# MAGIC Images:
# MAGIC ![Associate-badge](https://www.databricks.com/wp-content/uploads/2022/04/associate-badge-eng.svg)
# MAGIC
# MAGIC And of course, tables:
# MAGIC
# MAGIC | user_id | user_name |
# MAGIC |---------|-----------|
# MAGIC |    1    |    Adam   |
# MAGIC |    2    |    Sarah  |
# MAGIC |    3    |    John   |
# MAGIC |4        | Something |
# MAGIC |5| NOTHING |
# MAGIC |6.          | EVERYTHING |
# MAGIC
# MAGIC Links (or Embedded HTML): <a href="https://docs.databricks.com/notebooks/notebooks-manage.html" target="_blank"> Managing Notebooks documentation</a>

# COMMAND ----------


## Run a notebook directly - call a notebook and get it to run.
%run ../Includes/Setup

# COMMAND ----------

print(full_name)

# COMMAND ----------

# MAGIC %md
# MAGIC ### File system command using 
# MAGIC `%fs ls ... `
# MAGIC ### DBUTILS
# MAGIC `dbutils.help()`
# MAGIC   - `dbutils.fs.ls('/databricks-datasets')`
# MAGIC   - dbutils is more useful since you can use it as path of python code to do some logic with the file
# MAGIC   - `files = dbutils.fs.ls('/databricks-datasets')`
# MAGIC   - `display(files)`
# MAGIC ### DBC Architve - Databricks Cloud 
# MAGIC

# COMMAND ----------

# MAGIC %fs ls '/databricks-datasets'

# COMMAND ----------

dbutils.help()

# COMMAND ----------

dbutils.fs.help()

# COMMAND ----------

files = dbutils.fs.ls('/databricks-datasets')
print(files)

# COMMAND ----------

display(files)

# COMMAND ----------


