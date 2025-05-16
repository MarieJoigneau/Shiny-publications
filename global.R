# Auteur : Marie JOIGNEAU (INRAE)

# TITRE : Shiny App pour visualisation des UMR de l'infrastructure et liste publications


# =============================================================================
# =============================================================================
# ======================== LIBRARY ============================================
# =============================================================================
# =============================================================================

library(readxl)
library(writexl)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(stringr)
library(DT)
library(leaflet)

# =============================================================================
# =============================================================================
# =========================== MAIN ============================================
# =============================================================================
# =============================================================================

# =============================================================================
# ==================== REPERTOIRE PUBLICATION =================================
# =============================================================================

# Chargement du répertoire des publications
data_publi <- read_excel("./www/data/2024 07 08 RepertoirePubli_MJIT_final_IT_MJ.xlsx")

# Colonnes qu'on va garder:
data_publi <- data_publi[,c(3,c(6:13))]
# On réorganise les colonnes
data_publi <- data_publi[, c(4,5,1,6,7,8,9,2,3)]

# On met les plus récents en 1er
data_publi <- data_publi[rev(order(data_publi$Année)),]

# ======= LIEN INTERNET =======================================================


# Définir une fonction pour formater les liens
make_clickable <- function(link) {
  return(sprintf('<a href="%s" target="_blank">%s</a>', link, link))
}

# Garder une colonne de liens pour la sauvegarde en fichier .xlsx
data_publi$Lien_xlsx <- data_publi$Lien
# Transformer en liens html
data_publi$Lien <- lapply(data_publi$Lien, make_clickable)

#data_publi$Lien[1] <- "<a href=\"https://www.researchgate.net/publication/339308289_Thirty_Years_of_Genome_Engineering_in_Rice_From_Gene_Addition_to_Gene_Editing\" target=\"_blank\"> Lien internet </a>"

# ======= UNITES ==============================================================

# On enlève Editrop pour la liste des unités
#data_publi$Unité <- gsub(" \\(Editrop\\)", "", data_publi$Unité)

# On veut une liste unique des unités et non plusieurs unités avec des ","
list_unit <- unlist(strsplit(data_publi$Unité, ","))
# On enlève l'espace
list_unit <- str_trim(list_unit, "left")
# On met dans l'ordre alphabétique
list_unit <- unique(sort(list_unit))
print(list_unit)

# ======= AUTEURS =============================================================

# On veut une liste unique des auteurs et non plusieurs auteurs avec des ","
list_auteur <- unlist(strsplit(data_publi$`Auteur(s)`, ","))
# On enlève l'espace
list_auteur <- str_trim(list_auteur, "left")
# On met dans l'ordre alphabétique
list_auteur <- unique(sort(list_auteur))
print(list_auteur)

#df_auteur <- as.data.frame(list_auteur)

# ======= ESPECES =============================================================

# On veut une liste unique des auteurs et non plusieurs auteurs avec des ","
list_espece <- unlist(strsplit(data_publi$Espèces, ","))
# On enlève l'espace
list_espece <- str_trim(list_espece, "left")
# On met dans l'ordre alphabétique
list_espece <- unique(sort(list_espece))
print(list_espece)

#df_espece <- as.data.frame(list_espece)

