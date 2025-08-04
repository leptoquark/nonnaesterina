import pandas as pd
import json

# Carica i dati dal file Excel
df = pd.read_excel('ricettenonna.xlsx')

# Crea una lista di dizionari per le ricette con la struttura specificata
ricette = []
for _, row in df.iterrows():
    ricetta = {
        "nome": row["Nome della ricetta"],  # Cambia con il nome della colonna corretta
        "descrizione": row["Descrizione"],
        "preparazione": row["Preparazione"],
        "ingredienti": row["Ingredienti"],
        "immagine": row["Immagine"],
        "classificazione": {
            "durata": str(row["Durata"]),
            "difficolta": row["Difficoltà"],
            "tipo": row["Tipo"]
        }
    }
    ricette.append(ricetta)

# Struttura finale del JSON
output_json = {
    "ricette": ricette
}

# Salva il JSON in un file
with open('ricette.json', 'w', encoding='utf-8') as f:
    json.dump(output_json, f, ensure_ascii=False, indent=4)

print("Conversione completata! File JSON creato come 'ricette.json'")
