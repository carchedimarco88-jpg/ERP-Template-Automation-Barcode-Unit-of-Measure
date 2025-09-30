# ERP-Template-Automation-Barcode-Unit-of-Measure
Due script R per automatizzare la compilazione dei template Panthera relativi a barcode e unità di misura, a partire da estrazioni gestionali (Excel/CSV)

Automazione completa della compilazione di template ERP per codici a barre e unità di misura, a partire da estrazioni gestionali e database operativi.  
Questo progetto nasce da un caso reale: la migrazione di oltre **92.000 articoli** nel sistema Panthera ERP, con più di **250.000 barcode e unità di misura** da validare e integrare.


---

## Funzionalità principali

-  Incrocio tra file Excel (estrazioni ERP) e CSV (database barcode/UM)
-  Join robusto su chiave articolo con validazione dei dati
-  Padding degli ID articolo per conformità ERP
-  Esportazione automatica in formato `.xlsx` pronto per l'importazione
-  Gestione di duplicati e righe incomplete
-  Logging e controllo righe valide/non valide

---


## Input richiesti

Ogni script richiede:

- Un file Excel con l’elenco degli articoli da esportare (`ExportFile.xlsx`)
- Un file CSV con i dati da incrociare:
  - `BARCODE_DA_BCK_JUNAK.csv` per barcode
  - `UM_DA_BCK_JUNAK.csv` per unità di misura
- Un template Excel di riferimento (struttura finale)

---

## Output generati

- `template_compilato_barcode_YYYY-MM-DD.xlsx`  
  Contiene: `ID_ARTICOLO`, `ID_COD_BARRE`, `UNI_MIS`, ecc.

- `template_compilato_um_YYYY-MM-DD.xlsx`  
  Contiene: `ID_ARTICOLO`, `ID_UNITA_MISURA`, `FATT_CONV`, ecc.

Tutti i file sono esportati nella cartella `/output`.

---

## Competenze 

- Data wrangling con `dplyr` e `readxl`
- Validazione e deduplicazione dati
- Automazione Excel con `openxlsx`
- Gestione di flussi ERP reali
- Attenzione alla robustezza e alla scalabilità

---

## 📌 Note operative

- I file di input devono contenere le colonne attese (`Codice articolo`, `CODB_CODICE`, `UM_MIS`, `FATT_CONV`)
- Gli script sono progettati per essere modulari e riutilizzabili
- I dati forniti nel repository sono fittizi e servono solo a scopo dimostrativo

---

