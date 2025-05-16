# Auteur : Marie JOIGNEAU (INRAE)

# TITRE : Visualisation des UMR et publications de SVA



fluidPage(
  # shinythemes::themeSelector(),
  # navbarPage
  
  
  navbarPage("PEPR SVA - Infrastructure", 
             theme = shinytheme("flatly"),
             
             # =============================================================================
             # ==================== REPERTOIRE PUBLICATION =================================
             # =============================================================================
             
             # Unité/ Auteur/ Année / Espèces
             
             tabPanel("Répertoire des publications",
                      
                      verticalLayout(fluid=TRUE,
                                     fluidRow(
                                       
                                       column(width = 3,
                                              wellPanel(
                                                checkboxGroupInput("unites", 
                                                                   label = "Selectionnez des unités", 
                                                                   choices = setNames(list_unit, list_unit), 
                                                                   selected = "GAFL",
                                                                   inline = TRUE),
                                                
                                                prettyCheckbox(
                                                  inputId = "all_unites",
                                                  label = " Toutes les unités",
                                                  status = "primary",
                                                  animation = "jelly",
                                                  shape = "curve",
                                                  value = TRUE
                                                )),
                                              
                                              wellPanel(
                                                selectizeInput("auteurs",
                                                               "Selectionnez des auteurs", 
                                                               choices = NULL,
                                                               multiple = TRUE
                                                ),
                                                
                                                prettyCheckbox(
                                                  inputId = "all_auteurs",
                                                  label = " Tous les auteurs",
                                                  status = "primary",
                                                  animation = "jelly",
                                                  shape = "curve",
                                                  value = TRUE
                                                )),
                                              
                                              wellPanel(
                                                selectizeInput("especes",
                                                               "Selectionnez des espèces", 
                                                               choices = NULL,
                                                               multiple = TRUE
                                                ),
                                                
                                                prettyCheckbox(
                                                  inputId = "all_especes",
                                                  label = " Toutes les espèces",
                                                  status = "primary",
                                                  animation = "jelly",
                                                  shape = "curve",
                                                  value = TRUE
                                                )),
                                              
                                              wellPanel(
                                                sliderInput("annees",
                                                            "Selectionnez des années",
                                                            min = min(data_publi$Année),
                                                            max = max(data_publi$Année),
                                                            value = c(min(data_publi$Année),
                                                                      max(data_publi$Année)),
                                                            sep = ""
                                                )
                                              )
                                       ),
                                       column(width = 9,
                                              # div(style = 'height: 500px; overflow-y: scroll;',
                                                  # DTOutput("table_publi")),
                                              #dataTableOutput("table_publi"),
                                              DTOutput("table_publi"),
                                              downloadButton("ddl_csv", "Télécharger"),
                                              tags$br(),tags$br(),
                                              br(),
                                              br()
                                       )
                                     )
                                     
                      )),
             
             # =============================================================================
             # ========================== SIGNATURES =======================================
             # =============================================================================
             
             # On met la signature ainsi que la mention de SK8
             
             tags$footer(
               style = "
               position: fixed;
               left: 0;
               bottom: 0;
               width: 100%;
               z-index: 1000;
               height: 30px; /* Height of the footer */
               color: black;
               padding: 10px;
               font-weight: bold;
               background-color: white;
               display: flex; /* Utilisation de flexbox */
               justify-content: space-between; /* Espace égal entre les éléments */
               align-items: center; /* Centrage vertical */
               ",
               column(
                 width = 5, 
                 HTML('
                 <div class="footer" style="text-align:left;">
                   <span style="font-size:12px;">PEPR Sélection Végétale Avancée - </span>
                     <img style="vertical-align:middle;height:25px;" src="images/SVA.png"/>
                 </div>'
                 )
                 # style = "text-align: left;", # Alignement du texte à gauche
                 # "US 1502 - Cellule d’appui pour les PEPR"
               ),
               column(
                 width = 7,
                 HTML('
                 <div class="footer" style="text-align:right;">
                   <span style="font-size:12px;">Propulsé par <a href="https://sk8.inrae.fr" target="_blank">SK8</a> depuis 2021 - </span>
                   <a href="https://sk8.inrae.fr" target="_blank">
                     <img style="vertical-align:middle;height:25px;" src="images/SK8.png"/>
                   </a>
                 </div>'
                 )
               )
             )
             
             
  )
)