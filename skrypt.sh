#!/bin/bash

# Walidacja parametrów
if [[ $# -ne 3 ]]; then
    echo "Użycie: $0 <rok> <górna_ilość> <dolna_ilość>"
    exit 1
fi

year=$1
upper_limit=$2
lower_limit=$3

# Walidacja roku
if ! [[ "$year" =~ ^[0-9]{4}$ ]]; then
    echo "Rok musi być czterocyfrowy"
    exit 1
fi

# Tworzenie katalogów
mkdir -p Przepisy
mkdir -p "Swieta $year"
touch "Przepisy/Lista zakupow 2022.txt"
touch "Przepisy/Lista zakupow 2023.txt"

# Uzupełnienie pliku z listą zakupów
echo -e "świeża mięta\n1 kg jabłek\n1 kg cytryn\n500 g kiszonej kapusty\n1 mała główka świeżej kapusty\n80 g suszonych, leśnych grzybów\n200 g suszonych jabłek, śliwek, gruszek\n4 kg ziemniaków\n500 g drobnej, białej fasoli\nbułka tarta\n1 kg cukru\n1 l barszczu w kartonie" > "Przepisy/Lista zakupow $year.txt"

# Przeniesienie plików
mv "Przepisy/Lista zakupow 2022.txt" "Swieta 2023/"
mv "Przepisy/Lista zakupow 2023.txt" "Swieta 2024/"

# Użycie grep do znalezienia ciężkich zakupów
grep -E '([0-9]+) kg' "Swieta 2023/Lista zakupow 2023.txt" > "Lista zakupow/Ciezkie zakupy.txt"

# Zapisanie wybranych zakupów
head -n $upper_limit "Swieta 2023/Lista zakupow 2023.txt" > "Lista zakupow/Wybrane zakupy.txt"
tail -n $lower_limit "Swieta 2023/Lista zakupow 2023.txt" >> "Lista zakupow/Wybrane zakupy.txt"

# Walidacja numerów
if ! [[ "$upper_limit" =~ ^[0-9]+$ ]] || ! [[ "$lower_limit" =~ ^[0-9]+$ ]]; then
    echo "Parametry muszą być numeryczne"
    exit 1
fi

# Archiwizacja
tar -czvf "Powtorzenie_$(date +%Y-%m-%d)_<indeks_studenta>.tar.gz" .

