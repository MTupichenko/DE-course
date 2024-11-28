import pandas as pd
import pyodbc

#Параметры подключения
server = 'MYCOMP\\SQLEXPRESS'
database = 'AdventureWorks2017'

#Строка подключения
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes'

#Подключение к базе
connection = pyodbc.connect(connection_string)

connection.autocommit = True
cursor = connection.cursor()
#cursor.execute ('DROP DATABASE Library')
#Создание Базы Данных
cursor.execute('CREATE DATABASE Library')
cursor.execute ('USE Library')

#Cоздание таблиц и их заполнение
cursor.execute('''CREATE TABLE Books (BookID INT IDENTITY(1,1) PRIMARY KEY
                                    ,Title VARCHAR(255) NOT NULL
                                    ,Author VARCHAR(255) NOT NULL
                                    ,PublishedYear INT CHECK (PublishedYear > 1800))''')
cursor.execute ('''INSERT INTO Books (Title, Author, PublishedYear)
                VALUES ('Harry Potter', 'J.Rowling', 1997)
                , ('Hunger Games', 'S.Collins', 2008)
                , ('Twilight', 'S.Meyer', 2005)''')


cursor.execute('''CREATE TABLE Borrowers (BorrowerID INT IDENTITY(1,1) PRIMARY KEY
                                        , Name VARCHAR(255) NOT NULL
                                        , Email VARCHAR(255) UNIQUE)''')
cursor.execute ('''INSERT INTO Borrowers (Name, Email)
                VALUES ('Sasha', 'sasha.pp@gmail.com')
                , ('Dasha', 'dasha.m@gmail.com')
                , ('Ivan', 'ivan.ivanov@gmail.com')''')


cursor.execute('''CREATE TABLE Loans (LoanID INT IDENTITY(1,1) PRIMARY KEY
                                      , BookID INT
                                      , BorrowerID INT
                                      , LoanDate DATE NOT NULL
                                      , ReturnDate DATE
                                      , CONSTRAINT FK_BookID FOREIGN KEY (BookID) REFERENCES Books (BookID)
                                      , CONSTRAINT FK_BorrowerID FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
                                      , CHECK (ReturnDate > LoanDate))''')

cursor.execute ('''INSERT INTO Loans (BookID, BorrowerID, LoanDate, ReturnDate)
                VALUES (3,2, '2024-09-15', '2024-09-25')
                , (2,1, '2024-08-28', '2024-09-04')
                , (1,3,'2024-10-06', '2024-11-23')''')
cursor.close()
connection.close()
