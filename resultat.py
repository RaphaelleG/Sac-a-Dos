#!/usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt


def main() :
    time = [10, 20, 25, 30, 50, 100, 150]
    Brute_Force = [0, 2.1, 6.0, 60*41, 60*41, 60*41, 60*41]
    LLL = [0.03, 0.2, 0.4, 0.7, 4.4, 86, 551]

    plt.xlabel("Taille de la liste")
    plt.ylabel("Temps en seconde")
    plt.axis([0, 150, 0, 600])
    plt.plot(time, Brute_Force, label ='Brute_Force')
    plt.plot(time, LLL, label = 'LLL')
    plt.savefig("res_temps.png")
    plt.show()


if __name__ == '__main__':
    main()
