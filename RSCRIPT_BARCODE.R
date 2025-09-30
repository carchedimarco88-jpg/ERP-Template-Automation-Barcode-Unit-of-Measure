# Script: generate_barcode_template.R

library(readxl)
library(dplyr)
library(openxlsx)
library(skimr)
library(stringr)

# Caricamento dati
template     <- read_excel(file.choose())      # Template di riferimento
id_panthera  <- read_excel(file.choose())      # Export Panthera
junak_db     <- read.csv2(file.choose())       # DB barcode

# Analisi esplorativa
skim(junak_db)
skim(id_panthera)

# Uniforma chiave
junak_db <- junak_db %>%
  rename(`Codice articolo` = MT_LINK_ID) %>%
  mutate(`Codice articolo` = as.character(`Codice articolo`))

id_panthera <- id_panthera %>%
  mutate(`Codice articolo` = as.character(`Codice articolo`))

# Join
merged <- id_panthera %>%
  left_join(junak_db, by = "Codice articolo")

# Log
cat("Totale articoli:", nrow(id_panthera), "\n")
cat("Con barcode:", sum(!is.na(merged$CODB_CODICE)), "\n")
cat("Con UM:", sum(!is.na(merged$UM_MIS)), "\n")

# Template finale
final_template <- merged %>%
  filter(!is.na(`Codice articolo`)) %>%
  transmute(
    ID_ARTICOLO      = str_pad(`Codice articolo`, width = 7, side = "left", pad = "0"),
    R_VERSIONE       = "1",
    ID_ORIGINALE     = "1",
    R_TIPO_COD_BARRE = "STD",
    ID_COD_BARRE     = as.character(CODB_CODICE),
    DATA_INIZIO_VAL  = "2025-01-01",   # formato ISO
    UNI_MIS          = as.character(UM_MIS)
  )

# Export
dir.create("output", showWarnings = FALSE)
write.xlsx(final_template, file.path("output", paste0("template_compilato_barcode_", Sys.Date(), ".xlsx")))
