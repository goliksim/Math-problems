"""
Студент 3 курса Физического факультета МГУ
Голев А.С. 335 группа
ГПСЧ методом перемешивания, проверка гипотезы хи-квадрат о равномерном распределении последовательности
"""

# ошистка консоли от ненужной информации библиотек
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

#количество точек выборки
Iterations = 1000

#функция генерации последовательности
def mixing(number, CountOfNumbers):
    den = 2
    RandomsArray = []
    while len(RandomsArray) != CountOfNumbers:
        R_start = str(bin(number))[2:]              # убираем 0b
        a = int(R_start[+den:] + R_start[:+den], base = 2)
        b = int(R_start[-den:] + R_start[:-den], base = 2)
        number = a + b
        RandomsArray.append(float("0." + str(number)[1:]))

    return RandomsArray

# функция вывода визуальной информации
def print_bars(vector, name):
    fig = plt.figure(figsize=(10,4))
    plt.subplot(1,2,1)
    plt.scatter(range(Iterations),vector,s=10)
    plt.title(name)
    plt.ylabel("Значение числа")

    sorted_vector = sorted(vector)
    plt.subplot(1,2,2)
    sns.distplot(sorted_vector)
    
    plt.title(name)
    plt.xlabel("Интервал разбиения")
    plt.ylabel("Вероятность попадания в интервал")
    plt.tight_layout()
    plt.show()

# проверка критерия согласия Пирсона 
def xi_2_proof(vector, bins=10):

    xi_2 = 0
    for i in np.linspace(0.1, 1, bins):
        xi_2 += (sum((vector > i-0.1) & (vector < i)) - Iterations/bins)**2 / (Iterations/bins)
    

    xi_2_5 = 16.9  # для 10-1 = 9 степень свободы
    xi_2_95 = 3.33

    if (xi_2 > xi_2_95 and xi_2 < xi_2_5):
        print("H0") 
    else:
        print("H1") 
    return xi_2
        

if __name__ == "__main__":
    
    #Iterations= 1000 # 7553 - начальное число (сид генерации), подобрано итерационным методом   
    
    vec_mix_method = np.array(mixing(7001, Iterations))
        
    vec_mix_method = (vec_mix_method - np.min(vec_mix_method))/(np.max(vec_mix_method)-np.min(vec_mix_method))  
    # нормализовал выборку, понизив статистику хи-квадрат, 
    # но гипотеза h0 все равно не выполняется
        
    bins = 10   # количество разбиений от 0 до 1
    xi_2 = xi_2_proof(vec_mix_method, bins)
        
    print(f"Статистика хи-квадрат: {xi_2:.2f}")
    print("Количество разных чисел:",len(set(vec_mix_method)))   # все числа разные, значит период как минимум больше 1000
    print_bars(vec_mix_method, "Метод Перемешивания")
        


        
    
    """
    Для 1000 точек гипотеза H0 не подтверждается, однако при генерации небольшого числа чисел, она подтверждается.
    Скорее всего это связано с принципом работы генератора, который при небольшом количестве итераций дает относительно равномерное распределение при нормировке, 
    а в дальнейшем уходит в область малых чисел и портит равномерность.
    """