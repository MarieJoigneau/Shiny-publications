# Auteur : Marie JOIGNEAU (INRAE)

# TITRE : Visualisation des UMR et publications de SVA


# Permet de se connecter au compte internet pour mettre la ShinyApp sur le net
rsconnect::setAccountInfo(name='us-pepr',
                          token='4ADBC431E88EDB6BE101F0ADCAB38AAA',
                          secret='pePuvHqrtPPPckRsEStKgExG8Ya04NCmf/NjMud9')



shinyServer(function(input, output, session) {
  
  
  # =============================================================================
  # ==================== REPERTOIRE PUBLICATION =================================
  # =============================================================================
  
  # ======= Choix des unités ==================================================
  
  updateSelectizeInput(session, "unites", 
                       choices = list_unit, 
                       server = TRUE,
                       selected = c("GAFL"),
                       options= list(maxOptions = length(list_unit)))
  
  # ======= Choix des auteurs =================================================
  
  updateSelectizeInput(session, "auteurs", 
                       choices = list_auteur, 
                       server = TRUE,
                       selected = c("Fabien Nogué"),
                       options= list(maxOptions = length(list_auteur)))
  
  # ======= Choix des espèces =================================================
  
  updateSelectizeInput(session, "especes", 
                       choices = list_espece, 
                       server = TRUE,
                       selected = c("Arabidopsis thaliana"),
                       options= list(maxOptions = length(list_espece)))
  
  
  # ======= Dataset choisi ====================================================
  
  data_publi_choisi <- data_publi
  data_publi_choisi <- reactive({
    
    # Filtre dataframe par unité : 
    idx_unit <- c()
    if (length(input$unites) > 0){
      for (i in 1:length(input$unites)){
        idx_unit <- unique(c(idx_unit,which(str_detect(data_publi$Unité,input$unites[i]))))
      }
    }
    
    # Filtre dataframe par auteur :
    idx_auteur <- c()
    if (length(input$auteurs) > 0){
      for (i in 1:length(input$auteurs)){
        idx_auteur <- unique(c(idx_auteur,which(str_detect(data_publi$`Auteur(s)`,input$auteurs[i]))))
      }
    }
    
    # Filtre dataframe par espèce :
    idx_espece <- c()
    if (length(input$especes) > 0){
      for (i in 1:length(input$especes)){
        idx_espece <- unique(c(idx_espece,which(str_detect(data_publi$Espèces,input$especes[i]))))
      }
    }
    
    # Filtre dataframe par année :
    idx_annee <- which((data_publi$Année >= input$annees[1]) & (data_publi$Année <= input$annees[2]))
    
    # Filtre commun nuancé par la case qu'on peut cocher pour tout afficher:
    # On prend déjà tous les indices
    idx_final <- 1:length(data_publi$Titre)
    # Si on ne prend pas toutes les unités, choix de l'utilisateur :
    if (input$all_unites == FALSE){
      idx_final <- intersect(idx_final,idx_unit)
    }
    # Si on ne prend pas tous les auteurs, choix de l'utilisateur :
    #idx_final <- intersect(idx_final,idx_auteur)
    if (input$all_auteurs == FALSE){
      idx_final <- intersect(idx_final,idx_auteur)
    }
    # Si on ne prend pas toutes les espèces, choix de l'utilisateur :
    #idx_final <- intersect(idx_final,idx_espece)
    if (input$all_especes == FALSE){
      idx_final <- intersect(idx_final,idx_espece)
    }
    # Choix des années par l'utilisateur
    idx_final <- intersect(idx_final,idx_annee)
    
    # Dataset choisi :
    #print("idx_final")
    #print(idx_final)
    
    data_publi_choisi <- data_publi[idx_final,]
    
    
  })

  
  # ======= Table des données =================================================
  
  
  output$table_publi <- renderDT({
    datatable(
      data_publi_choisi()[,c(1:9)],
      escape = FALSE,
      class = 'cell-border stripe',
      options = list(
        paging = TRUE,
        autoWidth = TRUE,
        pageLength = 3, 
        lengthChange = FALSE,
        scrollY = TRUE,
        scrollX = TRUE,
        # Ajustement de la largeur pour la 7e colonne (indexée à partir de 0)
        columnDefs = list(
          list(width = '300px', targets = c(0,1)),
          list(width = '1000px', targets = 6),
          list(width = '200px', targets = 8)
        )
      ),
      rownames = FALSE
    )
  })
  
  # ======= Bouton télécharger ================================================
  
  output$ddl_csv <- downloadHandler(
    filename = function() {
      paste("Publications", ".xlsx", sep="")
    },
    content = function(file) {
      write_xlsx(
        # On ne prend pas la 9ème colonne qui est la liste des liens html pour la Shiny App
        data_publi_choisi()[,c(1:8,10)],
        file,
        col_names=TRUE)
    }
  )
  
  
})




