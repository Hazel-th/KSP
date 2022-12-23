import numpy as np
import matplotlib.pyplot as plt
from constants import *

plt.style.use("classic")


def g_graph():
    x = np.arange(0, 800000.01, 1000)
    G = 6.67430*10**(-11)
    m = 5.2915158*(10**22)
    R = 600000
    plt.plot(x, G * m /(R + x)**2)
    plt.title("Зависимость ускорения свободного падения от высоты")
    plt.xlabel("height")
    plt.ylabel("g_acceleration")
    plt.style.use("classic")
    plt.show()

#g_graph()

def m_t(Mf):
    x = np.arange(0, 86, 1)
    def graph(x, Mf):
        m1 = 74575
        mass_remain = [Mf]
        for i in range(79):
            div = mass_remain[-1]
            mass_remain.append(div - int(F_s))  
        div = mass_remain[-1]
        mass_remain.append(div - m1) 
        for i in range(81, 86   ):
            div = mass_remain[-1]
            mass_remain.append(div - int(F_s))  
        #print(mass_remain)
        return mass_remain
    #print(x)
    assymp_y = [x for x in range(250000, 700000)]
    assymp_x = [85] * (700000-250000)

    fig, axes = plt.subplots(figsize=(8, 7))
    axes.plot(x, graph(x, Mf), color="#3DDB60")
    axes.plot(assymp_x, assymp_y, "b--", alpha=0.8, linewidth=0.8)
    # plt.plot(x, graph(x, Mf), "r", assymp_x, assymp_y, "b--")
    plt.title("График зависимости массы от времени")
    plt.xlabel("time")
    plt.ylabel("mass")
    axes.legend(["remain_mass", "g_acseleration is too low"], fontsize=10, loc=3)
    plt.show()
m_t(Mf)



def v_m(Mf, F_s, I):
    t = np.arange(0, 80, 5)
    M_remain = [Mf - i*F_s for i in t]
    print(M_remain)
    V = []
    for i in t:
        V.append((I * np.log(Mf / (Mf - i*F_s))) * 1000)
    print(V)
    plot1 = plt.plot
    plt.ylabel("Velocity")
    plt.xlabel("Remain_mass")
    plt.plot(M_remain, V)
    plt.title("График зависимости скорости от массы")
    plt.xlim(max(M_remain), min(M_remain))
    plt.show()
#v_m(Mf, F_s, I)
