Faculty of Electrical Engineering
University of Sarajevo
Intelligent Control


    Subject: PID Controller Tuning Using Evolution Strategy ES (mi, lambda)

Application was created to find  optimal  configuration  of the  PID controller
using  evaluation  strategy ES (mi, lambda). This  strategy  selects  the  best
children  (mi is  count  of  children) and  use  them  in  next  generation  of
algorithm.  The  best  potential  solution will be selected from the set of the
lambda units. It is clear that 1<=mi<=lambda. The parameters in first iteration
are  tuned  by Ziegler - Nichols  method (for  system  greater  than two), four
Chien-Hrones-Reswick  autotuning  methods  (two  for  stability  and  two  for
accompanying regulation, both for system  with order greater than one), and for
simple  systems  (order  one)  using  random  numbers  for  parameters of first
iteration.


Sarajevo, 28.01.2010.                                     Creator: Faris Hodzic


src directory contains the following files:
    - es_mi_lam_PID.fig
    - es_mi_lam_PID.m

IMPORTANT: Do not remove and separate those two files.

RUNNING APPLICATION:
    1. Open MatLaba 2008b and navigate into src directory
    2. Open and run es_mi_lam_PID.m (or in Windows OS: select right click on
       es_mi_lam_PID.m and Open With->MATLAB)

PREREQUISITES:
    - MatLab R2008b v7.7 or latest
    - Control System Toolbox installled