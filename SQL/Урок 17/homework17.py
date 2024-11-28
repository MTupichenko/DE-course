"""
-Join-
import pandas as pd
import pyodbc
#параметры подключения к локальной б/д
server = 'MYCOMP\SQLEXPRESS'
database = 'AdventureWorks2017'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
#подключение к базе данных
connection = pyodbc.connect(connection_string)
query = ('SELECT cr.course_id, course_name, teacher, student_id, name '
         'FROM Course cr '
         'INNER JOIN Student st ON st.course_id = cr.course_id')
#загрузка данных в датафрейм
df = pd.read_sql(query, connection)
connection.close()
print(df)
df.to_excel('E:\DE\homework17\SQL_Join.xlsx',index = False)

-MERGE-
import pandas as pd
import pyodbc
server = 'MYCOMP\SQLEXPRESS'
database = 'AdventureWorks2017'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes'
connection = pyodbc.connect(connection_string)
query1 = 'SELECT * FROM Student'
query2 = 'SELECT * FROM Course'
df1 = pd.read_sql(query1, connection)
df2 = pd.read_sql(query2, connection)
connection.close()
# print(df1)
# print(df2)
df_merge = pd.merge(df1, df2) #объединяет по столбцам с одинаковым именем, INNER - по умолчанию
print(df_merge)
df_merge.to_excel('E:\DE\homework17\SQL_Merge.xlsx',index = False)
"""
