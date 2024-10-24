"""
1. Напишите функцию, которая принимает JSON-строку и выводит данные в виде словаря Python.
import json
def json_string (strings):
    return json.loads(strings)
print(json_string('{"Name": ["Masha", "Dasha"],"Age": [20,21]}'))

2. Напишите код, который загружает данные из Excel-файла, подсчитывает количество строк и
выводит результат.
import pandas as pd
try:
    df = pd.read_excel('.venv/Files/file.xlsx')
    print(f'количество строк в файле - {df.shape[0]-1}')
except FileNotFoundError:
    print('No files')

3. Напишите функцию, которая загружает данные из API и обрабатывает их, выводя только
нужные поля. (по аналогии с примером, который мы смотрели на уроке)
import pandas as pd
import requests
url = f'https://api.nationalize.io/?name=vadim' #взяла случайный API из интернета
response = requests.get(url)
if response.status_code == 200:
    data = response.json()
country_id = data['country']
print(country_id)
2 ВАРИАНТ
import pandas as pd
import requests

def curDate():
    url = f'https://api.nbrb.by/exrates/rates?periodicity=0'
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        print(f'Error: {response.status_code}')
        return None
df = pd.DataFrame([{
    'Cur_ID': item['Cur_ID'],
    'Data' : item ['Date']
}
for item in curDate()
])
print(df)
4. Напишите программу, которая загружает данные из нескольких Excel файлов,
объединяет их и сохраняет в новый файл.
import pandas as pd
df = pd.read_excel('.venv/Files/file.xlsx')
df2 = pd.read_excel('.venv/Files/file2.xlsx')
union = pd.concat([df,df2], axis=1) #объединила 2 таблицы по столбцам, т.к. данные в документах об одних людях
union.to_excel('.venv/Files/file3.xlsx', index = False)

5. Напишите код, который загружает данные из API, выполняет предварительную обработку
(например, фильтрацию) и сохраняет результат в Excel-файл.
import pandas as pd
import requests
url = f'https://api.genderize.io/?name=vadim' #взяла случайный API из интернета
response = requests.get(url)
if response.status_code == 200:
    data = response.json()
    info = pd.DataFrame([{
        'count': data['count'],
        'name':data['name'],
        'gender':data['gender'],
        'probability':data['probability']
    }])
    # print(info)
    # Фильтрация: оставляю столбцы с текстовым значением
    text_info1 = info.select_dtypes(include='object') #нашла такую функцию в интернете
    #Фильтрация: оставляю столбцы с числовым значением
    text_info2 = info.select_dtypes(include='number')
    # print(text_info1)
    # print(text_info2)
    text_info1.to_excel('.venv/Files/Object filtration.xlsx',index = False)
    text_info2.to_excel('.venv/Files/Number filtration.xlsx',index = False)
    print('Данные успешно сохранены')
else:
    print(f'Ошибка при получении данных: {response.status_code}')
    """

