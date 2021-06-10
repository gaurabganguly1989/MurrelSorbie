#!/usr/bin/gnuplot -p

    #-----------------------------------------
    # GNUplot settings
    #-----------------------------------------
    set terminal pdf enh color font "Arial,12" size 4,2
    set output "Analytic.pdf"

    set encoding iso_8859_1

    set xlabel "Bond length ({\305})"
    set ylabel "Energy (aaa)" rotate offset -1

    #-----------------------------------------
    # Murrel Sorbie function
    #-----------------------------------------
    f(x)=-De*(1+a1*x+a2*x**2+a3*x**3)*exp(-a1*x)

    # Guess values for fitting
    De = 0.12
    a1 = 2.00
    a2 = 1.00
    a3 = 0.25

    plot  f(x)                             w l   t "initial guess plt", \
                "ScaledPES.dat" using 1:2  w lp  t "RAW data plt", \
                "ScaledPES.dat" using 1:2  w lp, f(x)

    fit   f(x)  "ScaledPES.dat" using 1:2  via De,a1,a2,a3
    plot        "ScaledPES.dat" using 1:2  w lp,f(x)
