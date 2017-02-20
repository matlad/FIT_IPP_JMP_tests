#!/usr/bin/env bash

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# IPP - jmp - doplňkové testy - 2016/2017
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Činnost: 
# - vytvoří výstupy studentovy úlohy v daném interpretu na základě sady testů
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Popis (README):
#
# Struktura skriptu _stud_tests.sh (v kódování UTF-8):
# Každý test zahrnuje až 4 soubory (vstupní soubor, případný druhý vstupní 
# soubor, výstupní soubor, soubor logující chybové výstupy *.err vypisované na 
# standardní chybový výstup (pro ilustraci) a soubor logující návratový kód 
# skriptu *.!!!). Pro spuštění testů je nutné do stejného adresáře zkopírovat i 
# váš skript. V komentářích u jednotlivých testů jsou uvedeny dodatečné 
# informace jako očekávaný návratový kód. 
#
# Proměnné ve skriptu _stud_tests.sh pro konfiguraci testů:
#  INTERPRETER - využívaný interpret 
#  EXTENSION - přípona souboru s vaším skriptem (jméno skriptu je dáno úlohou) 
#  LOCAL_IN_PATH/LOCAL_OUT_PATH - testování různých cest ke vstupním/výstupním
#    souborům
#  
# Další soubory archivu s doplňujícími testy:
# V adresáři ref-out najdete referenční soubory pro výstup (*.out nebo *.xml), 
# referenční soubory s návratovým kódem (*.!!!) a pro ukázku i soubory s 
# logovaným výstupem ze standardního chybového výstupu (*.err). Pokud některé 
# testy nevypisují nic na standardní výstup nebo na standardní chybový výstup, 
# tak může odpovídající soubor v adresáři chybět nebo mít nulovou velikost.
#
# Doporučení a poznámky k testování:
# Tento skript neobsahuje mechanismy pro automatické porovnávání výsledků vašeho 
# skriptu a výsledků referenčních (viz adresář ref-out). Pokud byste rádi 
# využili tohoto skriptu jako základ pro váš testovací rámec, tak doporučujeme 
# tento mechanismus doplnit.
# Dále doporučujeme testovat různé varianty relativních a absolutních cest 
# vstupních a výstupních souborů, k čemuž poslouží proměnné začínající 
# LOCAL_IN_PATH a LOCAL_OUT_PATH (neomezujte se pouze na zde uvedené triviální 
# varianty). 
# Výstupní soubory mohou při spouštění vašeho skriptu již existovat a pokud není 
# u zadání specifikováno jinak, tak se bez milosti přepíší!           
# Výstupní soubory nemusí existovat a pak je třeba je vytvořit!
# Pokud běh skriptu skončí s návratovou hodnotou různou od nuly, tak není 
# vytvoření souboru zadaného parametrem --output nutné, protože jeho obsah 
# stejně nelze považovat za validní.
# V testech se jako pokaždé určitě najdou nějaké chyby nebo nepřesnosti, takže 
# pokud nějakou chybu najdete, tak na ni prosím upozorněte ve fóru příslušné 
# úlohy (konstruktivní kritika bude pozitivně ohodnocena). Vyhrazujeme si také 
# právo testy měnit, opravovat a případně rozšiřovat, na což samozřejmě 
# upozorníme na fóru dané úlohy.
#
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

TASK=jmp
INTERPRETER="php5.6"
EXTENSION=php
#INTERPRETER="python3.6"
#EXTENSION=py

# cesty ke vstupním a výstupním souborům
LOCAL_IN_PATH="./" # (simple relative path)
LOCAL_IN_PATH2="" #Alternative 1 (primitive relative path)
LOCAL_IN_PATH3="`pwd`/" #Alternative 2 (absolute path)
LOCAL_OUT_PATH="./" # (simple relative path)
LOCAL_OUT_PATH2="" #Alternative 1 (primitive relative path)
LOCAL_OUT_PATH3="`pwd`/" #Alternative 2 (absolute path)
# cesta pro ukládání chybového výstupu studentského skriptu
LOG_PATH="./"


# test01: Zpracovani vstupu I; Expected output: test01.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}test01.in --output=${LOCAL_OUT_PATH2}test01.out 2> ${LOG_PATH}test01.err
echo -n $? > test01.!!!

# test02: Zpracovani vstupu II; Expected output: test02.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}test02.in --output="${LOCAL_OUT_PATH3}test02.out" 2> ${LOG_PATH}test02.err
echo -n $? > test02.!!!

# test03: Zpracovani vstupu III; Expected output: test03.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test03.in --output="${LOCAL_OUT_PATH3}test03.out" 2> ${LOG_PATH}test03.err
echo -n $? > test03.!!!

# test04: Zpracovani vstupu IV; Expected output: test04.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH3}test04.in" --output=${LOCAL_OUT_PATH2}test04.out 2> ${LOG_PATH}test04.err
echo -n $? > test04.!!!

# test05: Chybny vstup I; Expected output: test05.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH3}test05.in" --output=${LOCAL_OUT_PATH}test05.out 2> ${LOG_PATH}test05.err
echo -n $? > test05.!!!

# test06: Chybny vstup II; Expected output: test06.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH3}test06.in" --output=${LOCAL_OUT_PATH}test06.out 2> ${LOG_PATH}test06.err
echo -n $? > test06.!!!

# test07: Chybny vstup III; Expected output: test07.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test07.in --output="${LOCAL_OUT_PATH3}test07.out" 2> ${LOG_PATH}test07.err
echo -n $? > test07.!!!

# test08: Chybny vstup IV; Expected output: test08.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}test08.in --output="${LOCAL_OUT_PATH3}test08.out" 2> ${LOG_PATH}test08.err
echo -n $? > test08.!!!

# test09: Jednoduche makro bez parametru; Expected output: test09.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test09.in --output=${LOCAL_OUT_PATH}test09.out 2> ${LOG_PATH}test09.err
echo -n $? > test09.!!!

# test10: Jednoduche makro s jednim parametrem; Expected output: test10.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test10.in --output="${LOCAL_OUT_PATH3}test10.out" 2> ${LOG_PATH}test10.err
echo -n $? > test10.!!!

# test11: Jednoduche makro s vice parametry; Expected output: test11.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}test11.in --output="${LOCAL_OUT_PATH3}test11.out" 2> ${LOG_PATH}test11.err
echo -n $? > test11.!!!

# test12: Chyba v parametrech; Expected output: test12.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test12.in --output="${LOCAL_OUT_PATH3}test12.out" 2> ${LOG_PATH}test12.err
echo -n $? > test12.!!!

# test13: Vstup z parametru; Expected output: test13.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION "--cmd={{*}}@def@x{}{ ahoj}" --input=${LOCAL_IN_PATH2}test13.in --output="${LOCAL_OUT_PATH3}test13.out" 2> ${LOG_PATH}test13.err
echo -n $? > test13.!!!

# test14: Nedefinovane makro; Expected output: test14.out; Expected return code: 56
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test14.in --output=${LOCAL_OUT_PATH2}test14.out 2> ${LOG_PATH}test14.err
echo -n $? > test14.!!!

# test15: Volny parametr v tele makra; Expected output: test15.out; Expected return code: 55
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test15.in --output=${LOCAL_OUT_PATH}test15.out 2> ${LOG_PATH}test15.err
echo -n $? > test15.!!!

# test16: Makro bez efektu; Expected output: test16.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input="${LOCAL_IN_PATH3}test16.in" --output=${LOCAL_OUT_PATH}test16.out 2> ${LOG_PATH}test16.err
echo -n $? > test16.!!!

# test17: Zruseni definice makra; Expected output: test17.out; Expected return code: 56
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test17.in --output="${LOCAL_OUT_PATH3}test17.out" 2> ${LOG_PATH}test17.err
echo -n $? > test17.!!!

# test18: Pokus o vymazani chraneneho makra; Expected output: test18.out; Expected return code: 57
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test18.in --output="${LOCAL_OUT_PATH3}test18.out" 2> ${LOG_PATH}test18.err
echo -n $? > test18.!!!

# test19: Komplexni test @undef & @set; Expected output: test19.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}test19.in --output="${LOCAL_OUT_PATH3}test19.out" 2> ${LOG_PATH}test19.err
echo -n $? > test19.!!!

