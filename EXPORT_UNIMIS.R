# Script: generate_um_template.R

library(readxl)
library(dplyr)
library(openxlsx)
library(skimr)
library(stringr)

# Caricamento dati
templateUM    <- read_excel(file.choose())     # Template UM
id_pantheraUM <- read_excel(file.choose())     # Export Panthera
junak_db_UM   <- read.csv2(file.choose())      # DB UM

# Analisi esplorativa
skim(junak_db_UM)
skim(id_pantheraUM)

# Uniforma chiave
junak_db_UM <- junak_db_UM %>%
  rename(`Codice articolo` = MT_LINK_ID) %>%
  mutate(`Codice articolo` = as.character(`Codice articolo`))

id_pantheraUM <- id_pantheraUM %>%
  mutate(`Codice articolo` = as.character(`Codice articolo`))

# Join
merged <- id_pantheraUM %>%
  left_join(junak_db_UM, by = "Codice articolo")

# Template finale
final_template_UM <- merged %>%
  filter(!is.na(`Codice articolo`)) %>%
  transmute(
    DATA_ORIGIN      = "EXCEL",
    RUN_ID           = "1",
    ROW_ID           = seq_len(n()),
    ID_ARTICOLO      = str_pad(`Codice articolo`, width = 7, side = "left", pad = "0"),
    RUN_ACTION       = "0",
    ID_UNITA_MISURA  = as.character(UM_MIS),
    OPER_CONVER_UM   = "M",
    FTT_CONVER_UM    = as.character(FATT_CONV)
  )

# Rimuovi righe incomplete e rigenera ROW_ID
final_template_UM_clean <- final_template_UM %>%
  filter(complete.cases(.)) %>%
  mutate(ROW_ID = seq_len(n()))

# Export
dir.create("output", showWarnings = FALSE)
write.xlsx(final_template_UM_clean, file.path("output", paste0("template_compilato_um_", Sys.Date(), ".xlsx")))
