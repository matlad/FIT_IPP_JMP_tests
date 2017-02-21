# FIT_IPP_JMP_tests
Testy k projektu JMP (Jednodůchý mackro procesor)  předmět IPP (FIT)
##Spuštění
./run.sh spustí všechny dílčí testy po sobě.  
Je potřeba naležitě upravyt proměné:  
__INTERPRET=php__ -nazev interpretu pozor na merlinovi php5.6  
__EXTENSION=php__ -koncovka py/php  
__MYPATH="../FIT_IPP_1_MakroProcesor"__ -relativní cesta k vašemu scriptu  
ve scriptu /run.sh.
a pak spustit ./run.sh

##Dílčí testy

###jmp-supplementary-tests
Umístění: [/jmp-supplementary-tests](https://github.com/matlad/FIT_IPP_JMP_tests/tree/master/jmp-supplementary-tests).  
Školní testy stažené s wisu upravené tak, že po provedení každého testu se porovnává s referencí pomocí diff a výsledek je vypsán.

###Fituška
Umístění: [/fituska](https://github.com/matlad/FIT_IPP_JMP_tests/tree/master/fituska).  
Testy od kolegy Andrej Kovac 

###Matla
Umístění: [/matla](https://github.com/matlad/FIT_IPP_JMP_tests/tree/master/matla)  
testy od Adam Mátl
