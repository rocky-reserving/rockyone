suppressMessages(suppressPackageStartupMessages(suppressWarnings(library(shiny))))
source('helpers.R')

shinyUI(navbarPage(theme = "bootstrap.minAW.css", 
                   title = "ROCKY II",
                   position = "fixed-top",
                   

              tabPanel("Home",
                   tags$section(id = "home", 
                       div(class = "intro-header",
                            div(class = "container",
                                div(class = "row",
                                    div(class = "col-lg-12",
                                        div(class = "intro-message",
                                            h1("ROCKY II"),
                                            h2("DOLPH LUNDGREN Reserve Modeling Client"),
                                            h4("Enter file name and click button to get started:"),
                                            hr(class = "intro-divider"),
                                            tags$ul(align='center', class="list-inline intro-social-buttons",
#                                                     actionButton('clearMemory', 'Clear Memory'),
#                                                     actionButton('cleanGarbage', 'Collect Garbage'),
                                                      div(textInput(inputId = 'selectionFilename', 'Enter Excel File Name:', 'Reserve Model Selections.xlsm' ), align='center'),
#                                                     actionButton('setSelectionsFile', 'Set Selections File'),
                                                    actionButton('loadROCKY1', 'Start ROCKY & Create Blank Log-Linear Model')
#                                                     actionButton('blankModel', 'Create Blank Model')
                                            ),
                                            hr(class = "intro-divider")
                                        )         
                                    )
                                )          
                            )    
                       )
                     
                     )),
                   
#file options ##########################################################################
tabPanel("File Options", 
  tags$section(id = "parameterUpdate",
    div(class = "section-1",
      div(class = "container",
        div(class = "row",
          div(class = "col-lg-12",
            div(class = "intro-message",
              h1('FILE OPTIONS'),
              h3('Load model from/save model to disk, or load from a specific point in the log'),
              br(), br(),
              flowLayout(
                verticalLayout(
                  h4('Load Model'),
#                   selectInput(inputId = 'loadFileName', label = NULL, choices = availableModels, selected = availableModels[1]),
                  uiOutput('loadFileName'),
#                   fileInput(inputId = 'loadFileName', label = NULL, multiple = FALSE, accept = ".ROCKYmodel"),
                  actionButton('loadModel', 'Load Model')
                ),
                verticalLayout(
                h4('Save Model'),
                textInput(inputId = "saveFileName", label = NULL, value = 'Model Name?'),
                actionButton('saveModel', 'Save Model')
                ),
                verticalLayout(
                h4('Load from Log ID'),
                numericInput(inputId = "loadFromLogID", label = NULL, value = 1, min = 1, step = 1),
                actionButton('loadFromLog', 'Load Model')
                )
              )
              
            ))))))),
              
              
                   
#update parameters OLD ##########################################################################
# tabPanel("Update parameters", 
#   tags$section(id = "parameterUpdate",
#     div(class = "section-1",
#       div(class = "container",
#         div(class = "row",
#           div(class = "col-lg-12",
#             div(class = "intro-message",
#               h1('UPDATE PARAMETERS'),
#               h3('reads parameters in Excel selections file, and re-fits the model'),
#               br(), br(),
#               flowLayout(
#                                 
#                 verticalLayout(
#                 #DY parameters
#                   verticalLayout(
#                     h4('DY Parameters'),
#                     actionButton('residualGraphDY', 'Residual Graph'),
#                     br(),
#                     actionButton('updateDYParameters', 'Update DY Parameters', class = 'btn btn-info')
#                   ),
#                                   
#                   br(),
#                                   
#                 #CY parameters
#                   verticalLayout(
#                     h4('CY Parameters'),
#                     actionButton('residualGraphCY', 'Residual Graph'),
#                     br(),
#                     actionButton('updateCYParameters', 'Update CY Parameters', class = 'btn btn-info')
#                   )
#                 ),
#                                 
#                 br(),
#                                 
#                 verticalLayout(
#                 #AY parameters
#                   verticalLayout(
#                     h4('AY Parameters'),
#                     actionButton('residualGraphAY', 'Residual Graph'),
#                     br(),
#                     actionButton('updateAYParameters', 'Update AY Parameters',class = 'btn btn-info')
#                   ),
#                                   
#                 br(),
#                                   
#                 #All parameters
#                   verticalLayout(
#                     h4('All Parameters'),
#                     actionButton('residualGraphAll', 'Residual Graph'),
#                     br(),
#                     actionButton('updateAllParameters', 'Update All Parameters', class = 'btn btn-info')
#                   )
#                 ))))))))),


#update parameters ##########################################################################
tabPanel("Update parameters", 
         tags$section(id = "parameterSelect",
                      div(class = "section-1",
                          div(class = "container",
                              div(class = "row",
                                  div(class = "col-lg-12",
                                      div(class = "intro-message",
                                          h1('UPDATE PARAMETERS'),
                                          h3('click on interactive plot to add a parameter'),
                                          h3('double-click to remove a parameter'),
                                          br(), br(),
                                          verticalLayout(
                                          flowLayout(
                                            #4 buttons at the top that select which residual plot you are looking at
                                            verticalLayout(
                                              #DY parameters
                                              actionButton('residualGraphDY.select', 'DY Residual Graph'),
                                              br(),
                                              #CY parameters
                                              actionButton('residualGraphCY.select', 'CY Residual Graph')),
                                            
                                            verticalLayout(
                                              #AY parameters
                                              actionButton('residualGraphAY.select', 'AY Residual Graph'),
                                              br(),
                                              #All parameters
                                              actionButton('residualGraphAll.select', 'All Residual Graphs')
                                              )),
                                          
                                          br(),
                                          
                                          #update parameters from Excel button at the top
                                          actionButton('updateAllParameters', 'Update All Parameters Using User-Defined Groups in Excel', class = 'btn btn-info')),
                                            
                                              br(),
                                              
                                            #actual residual plot you can click on  
                                            fluidRow(

                                              column(12, align="center", plotOutput("residual.plot", width = 750, height = 750, click = 'residual.plot.click', 
                                                         dblclick = 'residual.plot.doubleclick', hover = hoverOpts(id = 'residual.plot.hover')))
                                            ),
                                          
                                          br(), #JUST COMMENTING OUT THE COMMA--IF UNCOMMENT BELOW, UNCOMMENT THE COMMA
                                          
                                          #produces statistics about the residual you are hovering over
                                          textOutput(outputId = 'residual.hover.text.1'),
                                          textOutput(outputId = 'residual.hover.text.2')
                                          
                                          
                                          )
                                                      )
                                                      
                                            
                                            ))))),
                     
#model adjustment tab ##########################################################################
tabPanel("Model adjustments",
  tags$section(id = "parameterUpdate",
    div(class = "section-1",
      div(class = "container",
        div(class = "row",
          div(class = "col-lg-12",
            div(class = "intro-message",
              h1("MODEL ADJUSTMENTS"),
              tabsetPanel(
                
                tabPanel("Hetero Adjustment",
                         br(),
                  
                  #hetero adjustment
                sidebarLayout(
                  sidebarPanel(
                  verticalLayout(
                    actionButton('autoHetero', 'Auto hetero adjustment', class = "btn btn-primary"),
                    br(),
                    actionButton('customHetero', 'Selected Group Hetero', class = 'btn btn-info'),
                    br(),
                    actionButton('refreshHetero', 'Refresh hetero adjustment'),
                    br(),      
                    actionButton('manualHetero', 'Manual hetero adjustment'),
                    br(),
                    actionButton('clearHetero', 'Clear hetero adjustment')
                    
                  )),
                  
                 mainPanel( 
                  fluidRow(
                    column(12, align="center", plotOutput("hetero.residual.plot", click = "hetero.residual.plot.click", width = 500, height = 500,
                                                                                    dblclick = "hetero.residual.plot.doubleclick"))
                    ),
                  fluidRow(
                    column(12, align="center", plotOutput("hetero.structure.plot", click = "hetero.structure.plot.click", width = 500, height = 500,
                                                                                     dblclick = "hetero.structure.plot.doubleclick"))
                    )
                ))),
                
                #optimize variablese
                tabPanel("Optimize Variables",
                         br(),
                         
                  verticalLayout(
                    actionButton('autoOptimize', 'Auto variable optimizer', class = 'btn btn-info'),
                    br(),
                    actionButton('oneStepOptimize', 'One-step variable optimizer')
                  )
                ),
                
                #outliers
                tabPanel("Outliers",
                         br(),
                  verticalLayout(
                  
#                     verticalLayout(
#                     actionButton('removeOutliers', 'Remove outliers', class = 'btn btn-info'),
#                     br(),
                    actionButton('reIncludeOutliers', 'Re-include removed outliers', class = 'btn btn-info'),
                    br(),
#                     tableOutput('outliers.list')
                  
#                   mainPanel(
                    fluidRow(
                      
                      column(12, align="center", plotOutput("outlier.plot", width = 750, height = 750, click = 'outlier.plot.click', 
                                                            dblclick = 'outlier.plot.doubleclick', 
                                                            hover = hoverOpts(id = 'outlier.plot.hover')))
                    ),
                    br(),
                    h4("Excluded Outliers"),
                    div(align='center', tableOutput('outliers.list')),
                    br(),
                    textOutput('outlier.hover.text.1'),
                    textOutput('outlier.hover.text.2')
                    
                    )

                ),

                #AY filtering
                tabPanel("AY Smoothing",
                         br(),

                  verticalLayout(
                    actionButton('autoFiltering', 'Automatic AY Filtering Process', class = 'btn btn-info'),
                    br(),
                    flowLayout(
                    actionButton('manualFiltering', 'Manual Filters'),
                    actionButton('clearFiltering', 'Clear Filters')
                  ))
                ),

                #change model to GLM/loglinear
                tabPanel("Change Model",
                         flowLayout(
                           verticalLayout(
                             h3("Loglinear"),
                             actionButton(inputId = 'settings.make.loglinear', label = "Switch to Loglinear Model")
                           ),
                           verticalLayout(
                             h3("GLM"),
                             actionButton(inputId = 'settings.make.odp.glm', label = "Switch to ODP GLM Model")
#                              br(),
#                              actionButton(inputId = 'settings.make.gamma.glm', label = "Switch to Gamma GLM Model"),
#                              br(),
#                              actionButton(inputId = 'settings.make.normal.glm', label = "Switch to Normal GLM Model"),
#                              br()
                           )
                         )
         
)
                              )))))))),
                     
# diagnostic windows ##########################################################################
tabPanel("Diagnostics",
  tags$section(id = "parameterUpdate",
    div(class = "section-1",
      div(class = "container",
        div(class = "row",
          div(class = "col-lg-12",
            div(class = "intro-message",
              h1("DIAGNOSTICS"),
              verticalLayout(
                verticalLayout(
                  h2("Validation"),
                  br(),
                  actionButton('autoValidate', 'Automatic Validation', class = 'btn btn-info')
                ),
                verticalLayout(
                  h2("Normality"),
                  br(),
                  flowLayout(
                    verticalLayout(
                      actionButton('normalQQ', 'Normal Q-Q Plot'),
                      br(),
                      actionButton('boxPlot', 'Box Plot')
                    ),
                    verticalLayout(
                      actionButton('histogram', 'Histogram'),
                      br(),
                      actionButton('kernelDensity', 'Kernel Density')
                    )
                  ),
                  br(),
                  actionButton('allNormalDiag', 'All Normal Diagnostics', class = 'btn btn-info')
                ),
                br(),
                
                fluidRow(
                  
                  column(12, align="center", plotOutput("normal.plot", width = 750, height = 750, click = 'normal.plot.click', 
                                                        dblclick = 'normal.plot.doubleclick', hover = hoverOpts(id = 'normal.plot.hover')))
                ),
                
                br(), #JUST COMMENTING OUT THE COMMA--IF UNCOMMENT BELOW, UNCOMMENT THE COMMA
                
                #produces statistics about the residual you are hovering over
                textOutput(outputId = 'normal.hover.text.1'),
                textOutput(outputId = 'normal.hover.text.2')
                

#                 verticalLayout(
#                   h2("Validation"),
#                   br(),
#                   actionButton('autoValidate', 'Automatic Validation', class = 'btn btn-info')
#                 )
                                )
                                
                                
                              ))))))),
#graphs ##################################################################
tabPanel("Graphs",
  tags$section(id = "parameterUpdate",
    div(class = "section-1",
      div(class = "container",
        div(class = "row",
          div(class = "col-lg-12",
            div(class = "intro-message",
              h1("GRAPHS"),
              verticalLayout(
              flowLayout(
                #residual graphs
                verticalLayout(
                  h3("Residual Graphs"),
                  actionButton('residualGraphDY1', "DY Residual Graph"),
                  br(),
                  actionButton('residualGraphCY1', "CY Residual Graph"),
                  br(),
                  actionButton('residualGraphAY1', "AY Residual Graph"),
                  br(),
                  actionButton('residualGraphAll1', "All Residual Graphs")
                ),
                
                #model structure graphs
                verticalLayout(
                  h3("Model Structure Graphs"),
                  actionButton('modelStructureGraphDY1', "DY Structure Graph"),
                  br(),
                  actionButton('modelStructureGraphCY1', "CY Structure Graph"),
                  br(),
                  actionButton('modelStructureGraphAY1', "AY Structure Graph"),
                  br(),
                  actionButton('modelStructureGraphAll1', "All Structure Graphs")
                ),
                
                #diagnostic graphs
                verticalLayout(
                  h3("Diagnostic Graphs"),
                  actionButton('normalQQ1', 'Normal Q-Q Plot'),
                  br(),
                  actionButton('boxPlot1', 'Box Plot'),
                  br(),
                  actionButton('histogram1', 'Histogram'),
                  br(),
                  actionButton('kernelDensity1', 'Kernel Density'),
                  br(),
                  actionButton('all4Normal1', 'All 4 Normal Diagnostics')
                )
              ),
              br(),
              
              fluidRow(
                
                column(12, align="center", plotOutput("graph.plot", width = 750, height = 750, click = 'graph.plot.click', 
                                                      dblclick = 'graph.plot.doubleclick', hover = hoverOpts(id = 'graph.plot.hover')))
              )
)))))))),
 
#forecast ##################################################################
tabPanel("Forecast",
         tags$section(id = "parameterUpdate",
                      div(class = "section-1",
                          div(class = "container",
                              div(class = "row",
                                  div(class = "col-lg-12",
                                      div(class = "intro-message",
                                          h1("FORECAST"),
                                          verticalLayout(
                                            verticalLayout(
                                              h3("Forecast Output"),
                                              actionButton('pushForecastToExcel', 'Push Forecast Output to Excel', class = 'btn btn-info')
                                            ),
                                            br(),
                                            h3("Custom Future CY"),
                                            
                                            
                                            flowLayout(
                                              verticalLayout(
                                                h4("Trend"),
                                                actionButton('includeFutureCYTrend', 'Include Custom Future CY Trend'),
                                                br(),
                                                actionButton('excludeFutureCYTrend', 'Exclude Custom Future CY Trend')
                                              ),
                                              br(),
                                              verticalLayout(
                                                h4("Standard Error"),
                                                actionButton('includeFutureCYError', 'Include Custom Future CY Std Error'),
                                                br(),
                                                actionButton('excludeFutureCYError', 'Exclude Custom Future CY Std Error'),
                                                br(),
                                                numericInput(inputId = 'customStdError', label = NULL, value = 0.0075 )
                                              )
                                            ))
#                                             br(),
#                                             verticalLayout(
#                                               h3("Forecast Output"),
#                                               actionButton('pushForecastToExcel', 'Push Forecast Output to Excel')
#                                             )
                                            
                                            ))))))),


   

#settings ##################################################################
tabPanel("Settings",
         tags$section(id = "settings",
                      div(class = "section-1",
                          div(class = "container",
                              div(class = "row",
                                  div(class = "col-lg-12",
                                      div(class = "intro-message",
                                          h1("SETTINGS"),
                                          verticalLayout(
                                          tabsetPanel(
#                                             tabPanel("Model",
#                                                      flowLayout(
#                                                        verticalLayout(
#                                                          h3("Loglinear"),
#                                                          actionButton(inputId = 'settings.make.loglinear', label = "Switch to Loglinear Model")
#                                                          ),
#                                                        verticalLayout(
#                                                          h3("GLM"),
#                                                          actionButton(inputId = 'settings.make.odp.glm', label = "Switch to ODP GLM Model"),
#                                                          br(),
#                                                          actionButton(inputId = 'settings.make.gamma.glm', label = "Switch to Gamma GLM Model"),
#                                                          br(),
#                                                          actionButton(inputId = 'settings.make.normal.glm', label = "Switch to Normal GLM Model"),
#                                                          br()
#                                                          )
#                                                        )
#                                                      
#                                                      ),
                                            tabPanel("Data",
                                                     div(align='center',
                                              verticalLayout(
                                                numericInput(inputId = 'shiny.startAY', label = "Starting AY", value = ROCKY.settings$data$StartingAY),
                                                numericInput(inputId = 'shiny.startCY', label = "Starting CY", value = ROCKY.settings$data$StartingCY),
                                                numericInput(inputId = 'shiny.clipboardSize', label = "Clipboard Size", value = ROCKY.settings$data$ClipboardSize)
                                                )
                                              )),
                                            tabPanel("Hetero",
                                                     div(align='center',
                                                     verticalLayout(
                                                       selectInput(inputId = 'shiny.selectWeights', label = 'The method to select weights', 
                                                                   choices = c('logval', 'count', 'uniform'), selected = ROCKY.settings$hetero$SelectWeights, 
                                                                   multiple = FALSE),
                                                       numericInput(inputId = 'shiny.HeteroMaxIter', label = 'Max Number of Iterations Performed', 
                                                                    value = ROCKY.settings$hetero$MaxIter, min = 1, step = 1),
                                                       numericInput(inputId = 'shiny.minWtChange', label = 'Minimum Weight Change', 
                                                                    value = ROCKY.settings$hetero$MinWtChange)
                                                       ))
                                            ),
                                            tabPanel("Forecast",
                                                     div(align='center',
                                                     verticalLayout(
                                                       selectInput(inputId = 'shiny.varEst', label = 'Method for Estimating Process Variance', 
                                                                   choices = c('MLE', 'UBE'), selected = ROCKY.settings$forecast$varEst, multiple = FALSE), 
                                                       selectInput(inputId = 'shiny.varType', label = 'How you estimate the lognormal sigma', 
                                                                   choices = c('param_process', 'process', 'none'), selected = ROCKY.settings$forecast$varType, 
                                                                   multiple = FALSE)
                                                       ))
                                            ),
                                            tabPanel("Outliers",
                                                     div(align='center',
                                                     verticalLayout(
                                                       numericInput(inputId = 'shiny.yMinFactor', label = 'Factor smallest residual multiplied by to get window dimensions', 
                                                                    value = ROCKY.settings$outliers$yminFactor),
                                                       numericInput(inputId = 'shiny.yMaxFactor', label = 'Factor largest residual multiplied by to get window dimensions', 
                                                                    value = ROCKY.settings$outliers$ymaxFactor)
                                                       ))
                                            ),
                                            tabPanel("AY Filtering",
                                                     div(align='center',
                                                     verticalLayout(
                                                       numericInput(inputId = 'shiny.logLikCutoff', label = 'Cutoff value for loglikelihood', 
                                                                    value = ROCKY.settings$ay.filter$LogLikCutoff),
                                                       numericInput(inputId = 'shiny.numberToLag', label = 'Number to lag/lead', 
                                                                    value = ROCKY.settings$ay.filter$NumberToLag, min = 1, max = 5, step = 1),
                                                       numericInput(inputId = 'shiny.filteringMaxIterations', 
                                                                    label = 'Max number of iterations the filtering process will run', 
                                                                    value = ROCKY.settings$ay.filter$MaxIterations, step = 1)
                                                       ))
                                            ),
                                            tabPanel("Variable Optimizer",
                                                     div(align='center',
                                                     verticalLayout(
                                                       numericInput(inputId = 'shiny.tCutoff', label = 'Cutoff t-value for testing significance', value = ROCKY.settings$optimizer$tCutoff),
                                                       numericInput(inputId = 'shiny.maxDist', label = "Max number of AY's over which ROCKY will combine variables", value = ROCKY.settings$optimizer$maxDist)
                                                       ))
                                            ),
                                            tabPanel("Automatic Validation",
                                                     div(align='center',
                                                     verticalLayout(
                                                       numericInput(inputId = 'shiny.AVnumberOfYears', label = "Number of years in the table", value = ROCKY.settings$autoValidation$NumOfYears, step = 1)
                                                       ))
                                            ),
                                            tabPanel("Plots",
                                                     tabsetPanel(
                                                       tabPanel("General",
                                                            div(align='center',
                                                            verticalLayout(
                                                              br(),
                                                              numericInput(inputId = 'shiny.output.plotWidth', label = "Output Plot Width", value = ROCKY.settings$output$plotWidth),
                                                              numericInput(inputId = 'shiny.output.plotQuality', label = "Output Plot Quality", value = ROCKY.settings$output$plotQuality)
                                                            ))
                                                            ),
                                                       tabPanel("Normal Diagnostics",
                                                                div(align='center',
                                                         flowLayout(
                                                           verticalLayout(
                                                             h3("Q-Q Plot"),
                                                             br(),
                                                             selectInput(inputId = 'shiny.normalDiag.QQPlot.color', label = "Point Color", choices = colors(), selected = ROCKY.settings$plots$normalDiagnostics$QQPlot$color)
                                                             ),
                                                           verticalLayout(
                                                             h3("Histogram"),
                                                             br(),
                                                             textInput(inputId = 'shiny.normalDiag.hist.title', label = "Histogram Title", value = ROCKY.settings$plots$normalDiagnostics$histogram$title),
                                                             selectInput(inputId = 'shiny.normalDiag.hist.freq', label = "Histogram Frequency", choices = c(TRUE, FALSE), selected = ROCKY.settings$plots$normalDiagnostics$histogram$freq),
                                                             numericInput(inputId = 'shiny.normalDiag.hist.nclass', label = "Number of Classes", value = ROCKY.settings$plots$normalDiagnostics$histogram$nclass, min = 1, step = 1),
                                                             selectInput(inputId = 'shiny.normalDiag.hist.color', label = "Histogram Bar Color", choices = colors(), selected = ROCKY.settings$plots$normalDiagnostics$histogram$color)
                                                             ),
                                                           verticalLayout(
                                                             h3("Box Plot"),
                                                             br(),
                                                             selectInput(inputId = 'shiny.normalDiag.boxplot.isHorizontal', label = "Horizontal?", choices = c(TRUE, FALSE), selected = ROCKY.settings$plots$normalDiagnostics$boxplot$isHorizontal),
                                                             textInput(inputId = 'shiny.normalDiag.boxplot.title', label = "Box Plot Title", value = ROCKY.settings$plots$normalDiagnostics$boxplot$title),
                                                             selectInput(inputId = 'shiny.normalDiag.boxplot.color', label = "Box Plot Color", choices = colors(), selected = ROCKY.settings$plots$normalDiagnostics$boxplot$color)
                                                             ),
                                                           verticalLayout(
                                                             h3("Density"),
                                                             br(),
                                                             textInput(inputId = 'shiny.normalDiag.density.title', label = "Density Title", value = ROCKY.settings$plots$normalDiagnostics$density$title),
                                                             selectInput(inputId = 'shiny.normalDiag.density.color', label = "Density Color", choices = colors(), selected = ROCKY.settings$plots$normalDiagnostics$density$color)
                                                             )
                                                       
                                                       ))),
                                                       tabPanel("Model Structure Plot",
                                                                div(align='center',
                                                                flowLayout(
                                                                  verticalLayout(
                                                                    h3("Standard Error Bars"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.trendVarPlot.SE.color', label = "Color", choices = colors(), selected = ROCKY.settings$plots$trendVarPlot$SE$fillColor),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.SE.alpha', label = "Alpha (Transparency)", value = ROCKY.settings$plots$trendVarPlot$SE$alpha, min = 0, max = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Points"),
                                                                    br(),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.points.size', label = "Size", value = ROCKY.settings$plots$trendVarPlot$points$size, step = 1),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.points.shape', label = "Shape", value = ROCKY.settings$plots$trendVarPlot$points$shape, step = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Connecting Line"),
                                                                    br(),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.conLine.size', label = "Size", value = ROCKY.settings$plots$trendVarPlot$connectingLine$size, step = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Zero Trend Vertical Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.trendVarPlot.zeroLine.color', label = "Color", choices = colors(), selected = ROCKY.settings$plots$trendVarPlot$zeroTrendVertLine$color),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.zeroLine.alpha', label = "Alpha (Transparency)", value = ROCKY.settings$plots$trendVarPlot$zeroTrendVertLine$alpha, min = 0, max = 1),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.zeroLine.size', label = "Size", value = ROCKY.settings$plots$trendVarPlot$zeroTrendVertLine$size, min = 0, step = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Nonzero Trend Vertical Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.trendVarPlot.nonzeroLine.color', label = "Color", choices = colors(), selected = ROCKY.settings$plots$trendVarPlot$nonZeroTrendVertLine$color),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.nonzeroLine.alpha', label = "Alpha (Transparency)", value = ROCKY.settings$plots$trendVarPlot$nonZeroTrendVertLine$alpha, min = 0, max = 1),
                                                                    numericInput(inputId = 'shiny.trendVarPlot.nonzeroLine.size', label = "Size", value = ROCKY.settings$plots$trendVarPlot$nonZeroTrendVertLine$size, min = 0, step = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("DY Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.trendVarPlot.dy.title', label = "DY Plot Title", value = ROCKY.settings$plots$trendVarPlot$DY$title),
                                                                    textInput(inputId = 'shiny.trendVarPlot.dy.yaxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$trendVarPlot$DY$yAxisTitle)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("AY Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.trendVarPlot.ay.title', label = "AY Plot Title", value = ROCKY.settings$plots$trendVarPlot$AY$title),
                                                                    textInput(inputId = 'shiny.trendVarPlot.ay.yaxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$trendVarPlot$AY$yAxisTitle)
                                                                  ),
                                                                  verticalLayout(
                                                                    h3("CY Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.trendVarPlot.cy.title', label = "CY Plot Title", value = ROCKY.settings$plots$trendVarPlot$CY$title),
                                                                    textInput(inputId = 'shiny.trendVarPlot.cy.yaxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$trendVarPlot$CY$yAxisTitle)
                                                                  ),
                                                                  verticalLayout(
                                                                    h3("Hetero Weight Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.trendVarPlot.hetero.title', label = "Hetero Plot Title", value = ROCKY.settings$plots$trendVarPlot$weights$title),
                                                                    textInput(inputId = 'shiny.trendVarPlot.hetero.yaxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$trendVarPlot$weights$yAxisTitle)
                                                                  ),
                                                                  verticalLayout(
                                                                    h3("Theme Options"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.trendVarPlot.theme.lineType', label = "Line Type", value = ROCKY.settings$plots$trendVarPlot$theme$lineType)
                                                                    )
                                                                  )
                                                                
                                                                )),
                                                       tabPanel("Autovalidation Plot",
                                                                div(align='center',
                                                                flowLayout(
                                                                  verticalLayout(
                                                                    h3("Standard Error Bars"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.autoValidationPlot.se.color', label = "Color", choices = colors(), selected = ROCKY.settings$plots$autoValidationPlot$SE$color),
                                                                    numericInput(inputId = 'shiny.autoValidationPlot.se.alpha2se', label = "Alpha (Transparency) for 2nd Standard Error", value = ROCKY.settings$plots$autoValidationPlot$SE$alpha2SE, min = 0, max = 1),
                                                                    numericInput(inputId = 'shiny.autoValidationPlot.se.alpha1se', label = "Alpha (Transparency) for 1st Standard Error", value = ROCKY.settings$plots$autoValidationPlot$SE$alpha1SE, min = 0, max = 1)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Center Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.autoValidationPlot.centerLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$autoValidationPlot$centerLine$color),
                                                                    selectInput(inputId = 'shiny.autoValidationPlot.centerLine.type', label = "Line Type", choices = lineTypes, selected = ROCKY.settings$plots$autoValidationPlot$centerLine$type)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Mean Reserve Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.autoValidationPlot.meanLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$autoValidationPlot$line$color),
                                                                    numericInput(inputId = 'shiny.autoValidationPlot.meanLine.size', label = "Line Size", value = ROCKY.settings$plots$autoValidationPlot$line$size, min = 0)
                                                                  )
                                                                  )
                                                         )),
                                                       tabPanel("Residual Plots",
                                                                div(align='center',
                                                                flowLayout(
                                                                  verticalLayout(
                                                                    h3("Residuals"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.residualPlots.res.symbol', label = "Plot Symbol", choices = plotSymbolTypes, selected = ROCKY.settings$plots$residualPlots$residuals$symbol),
                                                                    selectInput(inputId = 'shiny.residualPlots.res.color', label = "Residual Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$residuals$color),
                                                                    selectInput(inputId = 'shiny.residualPlots.res.backgroundColor', label = "Residual Background Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$residuals$backgroundColor)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("DY Plot Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.residualPlots.dy.title', label = "DY Plot Title", value = ROCKY.settings$plots$residualPlots$DY$title),
                                                                    textInput(inputId = 'shiny.residualPlots.dy.xAxisTitle', label = "x-Axis Title", value = ROCKY.settings$plots$residualPlots$DY$xAxisTitle),
                                                                    textInput(inputId = 'shiny.residualPlots.dy.yAxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$residualPlots$DY$yAxisTitle)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("CY Plot Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.residualPlots.cy.title', label = "CY Plot Title", value = ROCKY.settings$plots$residualPlots$CY$title),
                                                                    textInput(inputId = 'shiny.residualPlots.cy.xAxisTitle', label = "x-Axis Title", value = ROCKY.settings$plots$residualPlots$CY$xAxisTitle),
                                                                    textInput(inputId = 'shiny.residualPlots.cy.yAxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$residualPlots$CY$yAxisTitle)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("AY Plot Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.residualPlots.ay.title', label = "AY Plot Title", value = ROCKY.settings$plots$residualPlots$AY$title),
                                                                    textInput(inputId = 'shiny.residualPlots.ay.xAxisTitle', label = "x-Axis Title", value = ROCKY.settings$plots$residualPlots$AY$xAxisTitle),
                                                                    textInput(inputId = 'shiny.residualPlots.ay.yAxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$residualPlots$AY$yAxisTitle)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Fitted Plot Titles"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.residualPlots.fitted.title', label = "Fitted Plot Title", value = ROCKY.settings$plots$residualPlots$fitted$title),
                                                                    textInput(inputId = 'shiny.residualPlots.fitted.xAxisTitle', label = "x-Axis Title", value = ROCKY.settings$plots$residualPlots$fitted$xAxisTitle),
                                                                    textInput(inputId = 'shiny.residualPlots.fitted.yAxisTitle', label = "y-Axis Title", value = ROCKY.settings$plots$residualPlots$fitted$yAxisTitle)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Zero Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.residualPlots.zeroLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$zeroLine$color),
                                                                    selectInput(inputId = 'shiny.residualPlots.zeroLine.type', label = "Line Type", choices = lineTypes, selected = ROCKY.settings$plots$residualPlots$zeroLine$lineType)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Mean Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.residualPlots.meanLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$meanLine$color)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Standard Error Bars"),
                                                                    br(),
                                                                    textInput(inputId = 'shiny.residualPlots.stdError.colorOneFourth', label = "Color for 1/4 SE", value = ROCKY.settings$plots$residualPlots$SE$oneFourth$color),
                                                                    textInput(inputId = 'shiny.residualPlots.stdError.colorOne', label = "Color for 1 SE", value = ROCKY.settings$plots$residualPlots$SE$one$color),
                                                                    textInput(inputId = 'shiny.residualPlots.stdError.colorTwo', label = "Color for 2 SE", value = ROCKY.settings$plots$residualPlots$SE$two$color),
                                                                    textInput(inputId = 'shiny.residualPlots.stdError.colorThree', label = "Color for 3 SE", value = ROCKY.settings$plots$residualPlots$SE$three$color),
                                                                    textInput(inputId = 'shiny.residualPlots.stdError.colorFour', label = "Color for 4 SE", value = ROCKY.settings$plots$residualPlots$SE$four$color)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Parameter-Marking Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.residualPlots.parameterLine.type', label = "Line Type", choices = lineTypes, selected = ROCKY.settings$plots$residualPlots$parameterLine$type),
                                                                    numericInput(inputId = 'shiny.residualPlots.parameterLine.width', label = "Line Width", value = ROCKY.settings$plots$residualPlots$parameterLine$width, min = 0, step = 1),
                                                                    selectInput(inputId = 'shiny.residualPlots.parameterLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$parameterLine$color)
                                                                    ),
                                                                  verticalLayout(
                                                                    h3("Hetero Parameter-Marking Line"),
                                                                    br(),
                                                                    selectInput(inputId = 'shiny.residualPlots.hetero.parameterLine.type', label = "Line Type", choices = lineTypes, selected = ROCKY.settings$plots$residualPlots$heteroLine$type),
                                                                    numericInput(inputId = 'shiny.residualPlots.hetero.parameterLine.width', label = "Line Width", value = ROCKY.settings$plots$residualPlots$heteroLine$width, min = 0, step = 1),
                                                                    selectInput(inputId = 'shiny.residualPlots.hetero.parameterLine.color', label = "Line Color", choices = colors(), selected = ROCKY.settings$plots$residualPlots$heteroLine$color)
                                                                  )
                                                                  )
                                                         )
                                              ))
                                          )),
                                          br(),
                                          actionButton('update.settings', 'Update Settings', class = 'btn btn-info'), 
                                          br(),
                                          actionButton('default.settings', 'Restore Defaults')
                                      ))))))))))
