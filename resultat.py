#!/usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt


def main() :
    time = [10, 20, 25, 30, 50, 100, 150]
    Brute_Force = [0, 2.1, 6.0, 60*41, 60*41, 60*41, 60*41]
    LLL = [0.03, 0.2, 0.4, 0.7, 4.4, 73, 440]
    gpLLL = [0.02, 0.02, 0.03, 0.04, 0.13, 1, 4.6]

    plt.xlabel("Taille de la liste")
    plt.ylabel("Temps en seconde")
    plt.axis([0, 150, 0, 450])
    plt.plot(time, Brute_Force, label ='Brute_Force')
    plt.plot(time, LLL, label = 'LLL')
    plt.plot(time, gpLLL, label="gpLLL")

    plt.savefig("res_temps.png")
    plt.show()


if __name__ == '__main__':
    main()
