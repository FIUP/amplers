/**
 * Un server computazionale deve pianificare l’esecuzione di cinque batch su di una macchina mono-processore. I batch durano rispettivamente 5, 7, 4, 7 e 10 minuti. La sequenza di esecuzione 1-2-3-4-5 è data e non ci può essere sovrapposizione temporale tra i batch. Il primo batch ha come ora di consegna desiderata le 10.32, il secondo le 10.38, il terzo le 10.42, il quarto le 10.52 e il quinto le 10.57. La consegna dei batch elaborati deve essere il più puntuale possibile: si paga una penale di 750 euro per ogni minuto di anticipo o ritardo nella consegna. Organizzare i tempi di esecuzione (al minuto) per minimizzare la penale totale.
*/

# declare params
set BATCH;
param duration;
param expected_finish;  # time each program should complete
param fee;  # $ we pay if we don't deliver the results just in time

# declare vars
var x_start{BATCH} >= 0;  # starting time of each program

# model

minimize total_fee: sum{b in BATCH} fee * abs(x[b] + duration[b] - expected_finish[b]);  # fee * delta time

subject to x_start["2"] >= x_start["1"] + duration["1"];  # 2 after 1
subject to x_start["3"] >= x_start["2"] + duration["2"];  # 3 after 2
subject to x_start["4"] >= x_start["3"] + duration["3"];  # 4 after 3
subject to x_start["5"] >= x_start["4"] + duration["4"];  # 5 after 4

option solver "/home/stefano/bin/amplide.linux64/cplex";  # select which solver to use