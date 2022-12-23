import numpy as np
import matplotlib.pyplot as plt
from constants import *

def speed(Trust, F_s, Mf, Me):
    I = Trust / F_s
    V = I * np.log(Mf/Me)
    return V 

V1 = speed(11000, (143639 + 175571) / 80, 689138, 367918)
V2 = speed(5800, (60000 + 73734)/68, 293343, 160000)
V3 = speed(3600, (29160 + 35640)/54.7, 120014, 55200)
V4 = speed(200, (7200 + 8800)/52.8, 30180, 14180)
#print(V1, V2, V3, V4)

p = 1.2230948554874
Mf = 689138
F_s = (143639 + 175571) / 80
I = 11000 / F_s
t = 0
x = np.arange(0, 81, 5)
#print(x)
lost_F = F_s * x
remain_F = Mf - lost_F
V = I * np.log(Mf/remain_F)
h = V * x


"""dict_v = {}
for t in range(0, 81, 5):
    lost_F = F_s * t
    remain_F = Mf - lost_F
    V = I * np.log(Mf/remain_F)
    h = V * t
    dict_v[t] = V * 1000  #отформатировать по запятой
# print(dict_v)
plt.plot(x, I * np.log(Mf/(Mf - F_s * x)) - (G * M /(R + x)**2) * remain_F)
plt.show()

Fd = 0.5 * p * V1**2 * 0.2 * 0.008 * remain_F
plt.plot(V * x, Fd)
plt.show()

def resistanse(V, rho, gamma):
    if gamma > np.pi: gamma = 2 * np.pi - gamma
    # gamma(gamma > np.pi) = 2 * np.pi - gamma(gamma > np.pi)
    if gamma <= np.pi/4: k = 1
    elif gamma > np.pi/4 and gamma <= 3*np.pi/4: k = 10
    else: k = 2 
    F = V * gamma * rho * 10
    return F"""