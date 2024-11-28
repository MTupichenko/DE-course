import pandas as pd
from sqlalchemy import create_engine

#Параметры подключения
server = 'MYCOMP\\SQLEXPRESS'
database = 'ShopOnline'

#Строка подключения
connection_string = f'mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server'

#Подключение к базе
engine = create_engine(connection_string)
print("Подключение успешно!")

df1 = pd.read_csv('E:\DE\Проект Shop Online\categories11.csv')
df2 = pd.read_csv('E:\DE\Проект Shop Online\products.csv')
df3 = pd.read_csv('E:\DE\Проект Shop Online\orders.csv')
df4 = pd.read_csv('E:\DE\Проект Shop Online\order_items.csv')

df1.to_sql('categories', con=engine, if_exists='append', index=False)
df2.to_sql('products', con=engine, if_exists='append', index=False)
df3.to_sql('orders', con=engine, if_exists='append', index=False)
df4.to_sql('order_items', con=engine, if_exists='append', index=False)
