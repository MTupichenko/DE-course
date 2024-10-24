"""
1. Напишите код, который пытается преобразовать введённое пользователем значение в число.
Обработайте исключение ValueError, если пользователь введёт строку, не являющуюся числом.

x = input('Enter value ')
try:
    x = float(x)
except ValueError:
    print('Error mistake: the wrong value was entered!')
else:
    print(x)

2.Напишите программу, которая обрабатывает ввод целого числа пользователем. Если ввод
некорректен (например, буквы), программа должна вывести сообщение об ошибке.

try:
    x = int(input('Enter the number '))
except Exception as m: #Здесь у меня уточняющий вопрос. Как я поняла, на реальных проектах лучше так не делать?
    print(f'Exception is {m}')
else:
    print(x)

3. Напишите программу, которая просит пользователя ввести индекс элемента в списке и
выводит этот элемент. Обработайте исключение IndexError на случай ввода
недопустимого индекса.

myList = [1, 6, 78, 'text', [1, 6, 7]]
element = int(input('Enter the index '))
try:
     print(myList[element])
except IndexError:
     print('This index is not exist!')

4. Напишите функцию, которая принимает список чисел и возвращает их среднее значение.
Обработайте исключение ZeroDivisionError, если список пустой.

def list(numbers):
    try:
        return sum(numbers)/len(numbers)
    except ZeroDivisionError:
        print ('Ошибка, список пустой')
print(list([2,6,8]))
print(list([]))

5. Напишите код, который использует try-except-else-finally, чтобы обработать
ошибку деления на ноль и вывести сообщение после завершения блока try.

x = int(input('Enter the first number '))
y = int(input('Enter the second number '))
try:
   division = x/y
except ZeroDivisionError:
    print('На ноль делить нельзя')
else:
    print(division)
finally:
    print('Операция завершена')

6. Напишите программу, которая запрашивает у пользователя два числа и выполняет деление.
Если ввод не является числом или деление на ноль, программа должна обрабатывать эти
исключения и продолжать запрашивать ввод до тех пор, пока не будут введены корректные
значения.

while True:
    try:
        x = float(input('Введите первое число '))
        y = float(input('Введите второе число '))
        print(x/y)
        break

    except ValueError:
        print('Введено неверное значение в переменную x или y')
        print('Попробуйте еще раз!')
    except ZeroDivisionError:
        print('На ноль делить нельзя')
        print('Попробуйте еще раз!')

7. Напишите функцию, которая принимает список и индекс. Если индекс выходит за пределы
списка, функция должна выбрасывать пользовательское исключение и обрабатывать его в
основной программе.

class ourPersonalException(Exception):
    pass
def function(myList, index):
    if index >= len(myList):
        raise ourPersonalException (f'{index} выходит за пределы списка')
try:
    function([1,2], 2)
except ourPersonalException as m:
    print(f'индекс {m}')

8. Напишите программу, которая обрабатывает несколько возможных исключений:
ValueError, ZeroDivisionError и IndexError. Программа должна просить
пользователя ввести список чисел и индекс, по которому будет выполнено деление элемента
списка на введённое число.

myList =[]
try:
    amount = int(input('Введите количество значений '))
    for i in range(amount):
        value = float(input(f'Введите {i+1} число '))
        myList.append(value)
    index = int(input('Введите индекс '))
    print(myList[index]/index)
except ValueError:
    print('Введено неверное значение')
except ZeroDivisionError:
    print('На ноль делить нельзя')
except IndexError:
    print('Данный индекс находится за пределами списка')
"""
