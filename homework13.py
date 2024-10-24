"""
1. Напишите функцию, которая загружает данные из API и фильтрует их по заданному
пользователем условию.

import pandas as pd
import requests

def population_of_USA():
    url = 'https://datausa.io/api/data?drilldowns=Nation&measures=Population' # Население США 2013-2022
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data['data']
    else:
        print(f'Error: {response.status_code}')
        return None
# print(population_of_USA())
population_data = population_of_USA() #данные здесь находятся в виде списка
df = pd.DataFrame([{
    'Year': item['Year'],
    'Population': item['Population'] #создаем Data Frame с 2 столбцами (нужные нам данные)
}
for item in population_data])
print(df)

#Фильтрация: выводим данные за последние 5 лет (до 2018 включительно)
filter = df[df['Year']>'2017']
print(filter)

# #Фильтрация: выводим данные за последние 7 лет, где население было меньше 329 725 481
filter2 = df[(df['Population']<324697795) & (df['Year']>'2015')]
print(filter2)

2. Напишите программу, которая загружает данные из нескольких CSV-файлов, объединяет их,
сортирует по нескольким столбцам и сохраняет результат в новый файл.

Я создала свои CSV-файлы, где написаны разные данные, но об одних людях
import pandas as pd
df_1 = pd.read_csv('.venv/Files/info1.csv', sep=';') #данные: имя, фамилия,
df_2 = pd.read_csv('.venv/Files/info2.csv', sep=';') #данные: возраст, страна проживания
union = pd.concat([df_1, df_2], axis=1)
print(union)
sort = union.sort_values(by=['age', 'country'])
print(sort)
sort.to_csv('.venv/Files/sorted_file.csv', index=False)
"""

# import pandas as pd
# import requests
#
# def population_of_USA():
#     url = 'https://datausa.io/api/data?drilldowns=Nation&measures=Population'
#     response = requests.get(url)
#     #Проверка на успешный ответ и извлечение данных
#     if response.status_code == 200:
#         data = response.json()
#         #Создаем DataFrame
#         df = pd.DataFrame(data)
#         #Поиск строк



