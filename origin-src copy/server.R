suppressMessages(suppressPackageStartupMessages(suppressWarnings(library(shiny))))
source('helpers.R')

shinyServer(function(input, output){
  observeEvent(eventExpr = input$setUpModel, handlerExpr = {load.model()})
  
  #landing page####
#   observeEvent(input$clearMemory, handlerExpr = {rm(list = ls())})
#   observeEvent(input$cleanGarbage, handlerExpr = {gc()})
#   observeEvent(input$setSelectionsFile, handlerExpr = {selectionsFile <- 'Reserve Model Selections.xlsx'})
#   observeEvent(input$loadROCKY, handlerExpr = {suppressPackageStartupMessages(suppressWarnings(source("ROCKY_source_20160329.R")))})
  observeEvent(input$loadROCKY1, handlerExpr = {
#     browser()
    rm(list = ls())
    gc()
    selectionsFile <- input$selectionFilename
    suppressPackageStartupMessages(suppressWarnings(source("ROCKY_source_20160329.R")))
#     new.modelName <- create.model.name(selectionsFile)
    create.all.VB.Scripts(selectionFile = input$selectionFilename)
    new.model(plots = FALSE)
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = 'all', newWindow = FALSE)
    })
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
  
    ROCKY.residual <<- 'all'
    ROCKY.outlier <<- 'DY'
    })
  observeEvent(input$blankModel, handlerExpr = {new.model(plots = FALSE)})
    
  #reactive available models
  avail.models <- reactive({availableModels})

  #model file options####
  observeEvent(input$loadModel, handlerExpr = {load.model(input$my.loadFileName)
                                               #update residual graph
                                               output$residual.plot <- renderPlot({
                                                 resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
                                               })
                                               #update hetero graphs
                                               output$hetero.residual.plot <- renderPlot({
                                                 resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
                                               })
                                               output$hetero.structure.plot <- renderPlot({
                                                 trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
                                               })
                                               #update outlier stuff
                                               output$outliers.list <- renderTable({
                                                 resObj$outliers
                                               })
                                               output$outlier.plot <- renderPlot({
                                                 resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
                                               })
                                               })
                                              #update normal diagnostics
                                              output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
  observeEvent(input$saveModel, handlerExpr = {
    save.model(input$saveFileName)
    append(availableModels, input$saveFileName)
    })
  observeEvent(input$loadFromLog, handlerExpr = {load.from.log(input$loadFromLogID)})
  output$loadFileName <- renderUI({
    selectInput(inputId = 'my.loadFileName', label = NULL, choices = avail.models())
  })
  
  
  #residual graphs####
  observeEvent(input$residualGraphDY, handlerExpr = {DY.residual.graph()})
  observeEvent(input$residualGraphCY, handlerExpr = {CY.residual.graph()})
  observeEvent(input$residualGraphAY, handlerExpr = {AY.residual.graph()})
  observeEvent(input$residualGraphAll, handlerExpr = {all.four.residual.graphs()})
  
  #update trend parameters####
#   observeEvent(input$updateDYParameters, handlerExpr = {update.DYGp.trend.parameters()})
#   observeEvent(input$updateAYParameters, handlerExpr = {update.AYGp.trend.parameters()})
#   observeEvent(input$updateCYParameters, handlerExpr = {update.CYGp.trend.parameters()})
  observeEvent(input$updateAllParameters, handlerExpr = {
    update.trend.parameters(plots = FALSE)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })
  
  #select trend parameters####
  
  #display different residual graphs
#   observeEvent(input$residualGraphDY.select, renderPlot = {resPlot(resObj, option = 'DY', newWindow = FALSE)})

  #default to the 'all' plot (see landing page)
#   output$residual.plot <- renderPlot({
#     resPlot(resObj, option = 'all', newWindow = FALSE)
#   })

  #DY
#   observeEvent(input$residualGraphDY.select, 
#     output$residual.plot <- renderPlot({
#       resPlot(resObj, option = 'DY', newWindow = FALSE)
#       }),
#     observeEvent(input$residual.plot.click, handlerExpr = {
#       x.loc <- isolate({round(input$residual.plot.click$x)})
#       y.loc <- isolate({round(input$residual.plot.click$y)})
#       t.add.DY.parameter(resObj, xloc = x.loc)
#       }))
    observeEvent(input$residualGraphDY.select, output$residual.plot <- renderPlot({
      input$residualGraphDY.select
      resPlot(resObj, option = 'DY', newWindow = FALSE)
      ROCKY.residual <<- 'DY'
    }))
  

  #CY
  observeEvent(input$residualGraphCY.select, output$residual.plot <- renderPlot({
    input$residualGraphCY.select
    resPlot(resObj, option = 'CY', newWindow = FALSE)
    ROCKY.residual <<- 'CY'
    }))

  #AY
  observeEvent(input$residualGraphAY.select, output$residual.plot <- renderPlot({
    input$residualGraphAY.select
    resPlot(resObj, option = 'AY', newWindow = FALSE)
    ROCKY.residual <<- 'AY'
    }))

  #All Plots
  observeEvent(input$residualGraphAll.select, output$residual.plot <- renderPlot({
    input$residualGraphAll.select
    resPlot(resObj, option = 'all', newWindow = FALSE)
    ROCKY.residual <<- 'all'
    }))

  #when click, add a parameter and update the model
  observeEvent(input$residual.plot.click, handlerExpr = {
    if(ROCKY.residual == "DY"){
      t.add.DY.parameter(resObj, xloc = round(input$residual.plot.click$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'DY', newWindow = FALSE)})
    }
    if(ROCKY.residual == "CY"){
      t.add.CY.parameter(resObj, xloc = round(input$residual.plot.click$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'CY', newWindow = FALSE)})
    }
    if(ROCKY.residual == "AY"){
      t.add.AY.parameter(resObj, xloc = round(input$residual.plot.click$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'AY', newWindow = FALSE)})
    }
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
  })

  #when double click, remove a parameter and update the model
  observeEvent(input$residual.plot.doubleclick, handlerExpr = {
    if(ROCKY.residual == "DY"){
      t.remove.DY.parameter(resObj, xloc = round(input$residual.plot.doubleclick$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'DY', newWindow = FALSE)})
    }
    if(ROCKY.residual == "CY"){
      t.remove.CY.parameter(resObj, xloc = round(input$residual.plot.doubleclick$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'CY', newWindow = FALSE)})
    }
    if(ROCKY.residual == "AY"){
      t.remove.AY.parameter(resObj, xloc = round(input$residual.plot.doubleclick$x))
      output$residual.plot <- renderPlot({resPlot(resObj, option = 'AY', newWindow = FALSE)})
    }
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
  })


  #hover functionality
  observeEvent(input$residual.plot.hover, handlerExpr = {
    
      #get data for DY graph
      if(ROCKY.residual == "DY"){
        myDY <- round(input$residual.plot.hover$x, digits = 0)
        #get table of all points with myDY
        myDat <- resObj$dat[resObj$dat$DY==myDY,]
      }
      if(ROCKY.residual == "AY"){
        myAY <- round(input$residual.plot.hover$x, digits = 0)
        myDat <- resObj$dat[resObj$dat$AY==myAY,]
      }
      if(ROCKY.residual == "CY"){
        myCY <- round(input$residual.plot.hover$x, digits = 0)
        myDat <- resObj$dat[resObj$dat$CY==myCY,]
      }
        
        #y-value of hover
        myResidStd <- input$residual.plot.hover$y
      
        #remove NA values
        myDat <- myDat[!is.na(myDat$residStd),]
        
#         #get everything that matches up to 3 decimal places
#         myDat <- myDat[round(myDat$residStd, digits = 3) == round(myResidStd, digits = 3),]
        
        #which row in myDat has the closest residual to the y-value?
        myRowNumber <- which(abs(myDat$residStd - myResidStd)==min(abs(myDat$residStd - myResidStd)))

        #data entry for residual hovering over
        myHover <- myDat[myRowNumber, ]

        myAY <- myHover$AY
        myCY <- myHover$CY
        myDY <- myHover$DY
        myValue <- myHover$value
        myLogvalue <- round(myHover$logvalue, digits = 3)
        myResidual <- round(myHover$residStd, digits = 3)
      
#     myXLoc <- input$residual.plot.hover$x
#     myYLoc <- input$residual.plot.hover$y
#     
#     #values
#     myDY <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "DY")
#     myAY <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "AY")
#     myCY <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "CY")
#     myValue <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "value")
#     myLogValue <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "logvalue")
#     myStdRes <- t.hover.output(resObj, xloc = myXLoc, yloc = myYLoc, typeOfGraph = ROCKY.residual, typeOfOutput = "residStd")
    
#     #strings
#     myDYstr <- as.character(myDY)
#     myAYstr <- as.character(myAY)
#     myCYstr <- as.character(myCY)
#     myValuestr <- as.character(myValue)
#     myLogValuestr <- as.character(myLogValue)
#     myStdResstr <- as.character(myStdRes)
    
    #create string
    myStr1 <- paste0(c("DY: ", myDY, ", AY: ", myAY, ", CY: ", myCY), collapse = "")
    myStr2 <- paste0(c("Value: ", myValue, ", Logvalue: ", myLogvalue, ", Residual: ", myResidual), collapse = "")
     
    output$residual.hover.text.1 <- renderText({expr = myStr1})
    output$residual.hover.text.2 <- renderText({expr = myStr2})

  })


#   #hover functionality
#   output$residual.hover.text <- renderText({
#     hover.output <- function(myHover, typeOfOutput){
#       if(ROCKY.residual == "DY"){
#         myDY <- round(myHover$x)
#         myResidStd <- round(myHover$y, digits = 3)
#         
#         #get table of all points with myDY
#         myDat <- resObj$dat[resObj$dat$DY==myDY,]
#         
#         #remove NA values
#         myDat <- myDat[!is.na(myDat$residStd),]
#         
#         #get everything that matches up to 3 decimal places
#         myDat <- myDat[round(myDat$residStd, digits = 3) == myResidStd,]
#       }
#       
#       #output whatever
#       if(typeOfOutput=="AY"){
#         return(myDat$AY)
#       }
#       if(typeOfOutput=="DY"){
#         return(myDat$DY)
#       }
#       if(typeOfOutput=="CY"){
#         return(myDat$CY)
#       }
#       if(typeOfOutput=="value"){
#         return(myDat$value)
#       }
#       if(typeOfOutput=="logvalue"){
#         return(myDat$logvalue)
#       }
#       if(typeOfOutput=="residStd"){
#         return(myDat$residStd)
#       }
#     }
#     paste0(c("AY: ", hover.output(input$residual.plot.hover, typeOfOutput = "AY")))
#      
#   })
# 
#   #print the location of the click
#   output$parameter.location <- renderText({
#     if(is.null(input$residual.plot.click)){
#       return("")
#     }
#     else{
#       x.loc <- round(input$residual.plot.click$x)
#       y.loc <- round(input$residual.plot.click$y)
#       HTML("x location: ", x.loc, "<br>y location: ", y.loc )
#     }
#   })
  
  #hetero adjustment####
  #auto, custom group, manual, clear, reset
  
    #auto hetero####
  observeEvent(input$autoHetero, handlerExpr = {
    automatic.hetero.adjustment(plots = FALSE)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })

  #refresh hetero ####
  observeEvent(input$refreshHetero, handlerExpr = {
    custom.group.hetero.adjustment(myComment = "Refreshed hetero adjustment", plots = FALSE, includeMessage = FALSE)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    graphics.off()
    })

  #manual hetero####
  observeEvent(input$manualHetero, handlerExpr = {
    manual.hetero.adjustment(plots = FALSE)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    graphics.off()
    })

  #clear hetero####
  observeEvent(input$clearHetero, handlerExpr = {
    clear.hetero.adjustment()
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$customHetero, handlerExpr = {
    custom.group.hetero.adjustment(plots = FALSE)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    graphics.off()
    })

  #hetero graphs
  observeEvent(input$hetero.residual.plot.click, handlerExpr = {
    t.add.hetero.parameter(resObj, xloc = round(input$hetero.residual.plot.click$x)+1)
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })
  
  #variable optimization####
  observeEvent(input$autoOptimize, handlerExpr = {automatic.variable.optimizer()})
  observeEvent(input$oneStepOptimize, handlerExpr = {one.step.variable.optimizer()})
  
  #outliers####
#   observeEvent(input$removeOutliers, handlerExpr = {remove.outliers()})
  observeEvent(input$reIncludeOutliers, handlerExpr = {
    add.outliers.back.in()
    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update hetero graphs
    output$hetero.residual.plot <- renderPlot({
      resPlot(resObj, option = 'DY', newWindow = FALSE, includeParameters = FALSE, includeHetero = TRUE)
    })
    output$hetero.structure.plot <- renderPlot({
      trendVarPlot(resObj, newWindow = FALSE, option = 'weight')
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$outlier.plot.click, handlerExpr = {
#     browser()
    dat <- resObj$dat
    if(ROCKY.settings$selected.model=="loglinear"){
      fitDat <- dat[!is.na(dat$logvalue),]
    }
    else if(ROCKY.settings$selected.model=="GLM"){
      fitDat <- dat[!is.na(dat$value),]
    }
    if(ROCKY.outlier == "DY"){
      outlierSelect <- data.frame(matrix(c(0, 0), nrow = 1, ncol = 2))
      names(outlierSelect) <- c('DY', 'residStd')
      outlierSelect$DY <- round(input$outlier.plot.click$x, digits = 0)
      outlierSelect$residStd <- input$outlier.plot.click$y
      
      newDat <- fitDat[fitDat$DY == outlierSelect$DY, ]
      
      rowToRemove <- which(abs(newDat$residStd - outlierSelect$residStd)==min(abs(newDat$residStd - outlierSelect$residStd)))
      
      outlier.to.remove <- newDat[rowToRemove, ]
    }
    else if(ROCKY.outlier == "CY"){
      outlierSelect <- data.frame()
      outlierSelect$CY <- input$outlier.plot.click$x
      outlierSelect$residStd <- input$outlier.plot.click$y
    }
    else if(ROCKY.outlier == "AY"){
      outlierSelect <- data.frame()
      outlierSelect$AY <- input$outlier.plot.click$x
      outlierSelect$residStd <- input$outlier.plot.click$y
    }
    
    
#     outlier <- data.frame(matrix(c(0, 0), nrow = 1, ncol = 2))
    
    outlier <- data.frame(id = outlier.to.remove$id, logvalue = outlier.to.remove$logvalue)

    outlier$id <- outlier.to.remove$id
    outlier$logvalue <- outlier.to.remove$logvalue
    outlier <- as.data.frame(outlier)
    
#     resObj$outlierList <- rbind(resObj$outlierList, outlier.to.remove)
    
#     browser()
    
    assign('resObj', value = removeOutliers(resObj, newWindow = FALSE, option = ROCKY.outlier, select.method = 'shiny', outlier.select = outlier), inherits = TRUE)
    
    myComment <- paste(c("Removed outlier from DY ", outlier.to.remove$DY, ", AY ", outlier.to.remove$AY,
                         ", and CY ", outlier.to.remove$CY, ", with a residual of ", round(outlier.to.remove$residStd, digits = 5)), sep = "", collapse = "")

#     fitModel(resObj, updateWeights = TRUE, plots = FALSE)

#     assign('resObj', value = refit.model(resObj, plots = FALSE, myComment = myComment), inherits = TRUE)

    update.trend.parameters(comment = myComment, writeToLog = TRUE, msgbox = FALSE, plots = FALSE)    

    #update residual graph
    output$residual.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.residual, newWindow = FALSE)
    })
    #update outlier stuff
    output$outliers.list <- renderTable({
      resObj$outliers
    })
    output$outlier.plot <- renderPlot({
      resPlot(resObj, option = ROCKY.outlier, newWindow = FALSE, includeParameters = TRUE)
    })
    #update normal diagnostics
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    
  })

#hover functionality
observeEvent(input$outlier.plot.hover, handlerExpr = {
  
  #get data for DY graph
  if(ROCKY.outlier == "DY"){
    myDY <- round(input$outlier.plot.hover$x, digits = 0)
    #get table of all points with myDY
    myDat <- resObj$dat[resObj$dat$DY==myDY,]
  }
  if(ROCKY.outlier == "AY"){
    myAY <- round(input$outlier.plot.hover$x, digits = 0)
    myDat <- resObj$dat[resObj$dat$AY==myAY,]
  }
  if(ROCKY.outlier == "CY"){
    myCY <- round(input$outlier.plot.hover$x, digits = 0)
    myDat <- resObj$dat[resObj$dat$CY==myCY,]
  }
  
  #y-value of hover
  myResidStd <- input$outlier.plot.hover$y
  
  #remove NA values
  myDat <- myDat[!is.na(myDat$residStd),]
  
  #         #get everything that matches up to 3 decimal places
  #         myDat <- myDat[round(myDat$residStd, digits = 3) == round(myResidStd, digits = 3),]
  
  #which row in myDat has the closest residual to the y-value?
  myRowNumber <- which(abs(myDat$residStd - myResidStd)==min(abs(myDat$residStd - myResidStd)))
  
  #data entry for residual hovering over
  myHover <- myDat[myRowNumber, ]
  
  myAY <- myHover$AY
  myCY <- myHover$CY
  myDY <- myHover$DY
  myValue <- myHover$value
  myLogvalue <- round(myHover$logvalue, digits = 3)
  myResidual <- round(myHover$residStd, digits = 3)
  
  #create string
  myStr1 <- paste0(c("DY: ", myDY, ", AY: ", myAY, ", CY: ", myCY), collapse = "")
  myStr2 <- paste0(c("Value: ", myValue, ", Logvalue: ", myLogvalue, ", Residual: ", myResidual), collapse = "")
  
  output$outlier.hover.text.1 <- renderText({expr = myStr1})
  output$outlier.hover.text.2 <- renderText({expr = myStr2})
  
})

  
  #AY filtering
  observeEvent(input$autoFiltering, handlerExpr = {automatic.AY.filtering()})
  observeEvent(input$manualFiltering, handlerExpr = {manual.AY.filtering()})
  observeEvent(input$clearFiltering, handlerExpr = {clear.AY.filtering()})
  
  #auto validation####
  observeEvent(input$autoValidate, handlerExpr = {automatic.validation()})
  observeEvent(input$autoValTable, handlerExpr = {automatic.validation.table()})
  observeEvent(input$autoValGraph, handlerExpr = {automatic.validation.graph()})
  
  #other graphs####
  observeEvent(input$residualGraphDY1, handlerExpr = {output$graph.plot <- renderPlot({resPlot(resObj, option = 'DY', newWindow = FALSE)})})
  observeEvent(input$residualGraphCY1, handlerExpr = {output$graph.plot <- renderPlot({resPlot(resObj, option = 'CY', newWindow = FALSE)})})
  observeEvent(input$residualGraphAY1, handlerExpr = {output$graph.plot <- renderPlot({resPlot(resObj, option = 'AY', newWindow = FALSE)})})
  observeEvent(input$residualGraphAll1, handlerExpr = {output$graph.plot <- renderPlot({resPlot(resObj, option = 'all', newWindow = FALSE)})})
  
  observeEvent(input$modelStructureGraphDY1, handlerExpr = {output$graph.plot <- renderPlot({trendVarPlot(resObj, newWindow = FALSE, option = 'DY')})})
  observeEvent(input$modelStructureGraphCY1, handlerExpr = {output$graph.plot <- renderPlot({trendVarPlot(resObj, newWindow = FALSE, option = 'CY')})})
  observeEvent(input$modelStructureGraphAY1, handlerExpr = {output$graph.plot <- renderPlot({trendVarPlot(resObj, newWindow = FALSE, option = 'AY')})})
  observeEvent(input$modelStructureGraphAll1, handlerExpr = {output$graph.plot <- renderPlot({trendVarPlot(resObj, newWindow = FALSE, option = 'all')})})
  
  observeEvent(input$normalQQ1, handlerExpr = {output$graph.plot <- renderPlot({diagnostic.plots.normal.QQ(newWindow = FALSE, pushToExcel = TRUE)})})
  observeEvent(input$boxPlot1, handlerExpr = {output$graph.plot <- renderPlot({diagnostic.plots.box.plot(newWindow = FALSE, pushToExcel = TRUE)})})
  observeEvent(input$histogram1, handlerExpr = {output$graph.plot <- renderPlot({diagnostic.plots.histogram(newWindow = FALSE, pushToExcel = TRUE)})})
  observeEvent(input$kernelDensity1, handlerExpr = {output$graph.plot <- renderPlot({diagnostic.plots.kernel.density(newWindow = FALSE, pushToExcel = TRUE)})})
  observeEvent(input$all4Normal1, handlerExpr = {output$graph.plot <- renderPlot({diagnostic.plots(newWindow = FALSE, pushToExcel = TRUE)})})
  
  #normal diagnostics####
  observeEvent(input$normalQQ, handlerExpr = {
    output$normal.plot <- renderPlot({diagnostic.plots.normal.QQ(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$boxPlot, handlerExpr = {
    output$normal.plot <- renderPlot({diagnostic.plots.box.plot(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$histogram, handlerExpr = {
    output$normal.plot <- renderPlot({diagnostic.plots.histogram(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$kernelDensity, handlerExpr = {
    output$normal.plot <- renderPlot({diagnostic.plots.kernel.density(pushToExcel = TRUE, newWindow = FALSE)})
    })
  observeEvent(input$allNormalDiag, handlerExpr = {
    output$normal.plot <- renderPlot({diagnostic.plots(pushToExcel = TRUE, newWindow = FALSE)})
    })
  
  #custom future CY trend####
  observeEvent(input$includeFutureCYTrend, handlerExpr = {include.custom.CY.trend()})  #include custom future CY trend
  observeEvent(input$excludeFutureCYTrend, handlerExpr = {exclude.custom.CY.trend()})  #include custom future CY se
  observeEvent(input$includeFutureCYError, handlerExpr = {include.custom.CY.se(StdError = input$customStdError)})  #exclude custom future CY trend
  observeEvent(input$excludeFutureCYError, handlerExpr = {exclude.custom.CY.se()})  #exclude custom future CY se
  
  #forecast output####
  observeEvent(input$pushForecastToExcel, handlerExpr = {push.summary.output()})  #push forecast output
  
  #settings####
  observeEvent(input$update.settings, handlerExpr = {
    update.settings(Data.StartingAY = input$shiny.startAY, Data.StartingCY = input$shiny.startCY, Data.ClipboardSize = input$shiny.clipboardSize, 
                    Hetero.SelectWeights = input$shiny.selectWeights, Hetero.MaxIter = input$shiny.HeteroMaxIter, 
                    Hetero.MinWtChange = input$shiny.minWtChange, Forecast.varEst = input$shiny.varEst, Forecast.varType = input$shiny.varType, 
                    Outliers.yminFactor = input$shiny.yMinFactor, Outliers.ymaxFactor = input$shiny.yMaxFactor, 
                    AYFilter.LogLikCutoff = input$shiny.logLikCutoff, AYFilter.NumberToLag = input$shiny.numberToLag, 
                    AYFilter.MaxIterations = input$shiny.filteringMaxIterations, Optimizer.tCutoff = input$shiny.tCutoff, 
                    Optimizer.maxDist = input$shiny.maxDist, AutoValidation.NumOfYears = input$shiny.AVnumberOfYears,
                    Output.PlotWidth = NULL, Output.PlotQuality = NULL,
                    Plots.Norm.QQ.Color = input$shiny.normalDiag.QQPlot.color, 
                    Plots.Norm.Hist.Title = input$shiny.normalDiag.hist.title, 
                    Plots.Norm.Hist.Freq = input$shiny.normalDiag.hist.freq, 
                    Plots.Norm.Hist.nClass = input$shiny.normalDiag.hist.nclass, 
                    Plots.Norm.Hist.Color = input$shiny.normalDiag.hist.color,
                    Plots.Norm.Box.isHoriz = input$shiny.normalDiag.boxplot.isHorizontal, 
                    Plots.Norm.Box.Title = input$shiny.normalDiag.boxplot.title, 
                    Plots.Norm.Box.Color = input$shiny.normalDiag.boxplot.color,
                    Plots.Norm.Density.Color = input$shiny.normalDiag.density.color, 
                    Plots.Norm.Density.Title = input$shiny.normalDiag.density.title,
                    Plots.Structure.SE.Color = shiny.trendVarPlot.SE.color, 
                    Plots.Structure.SE.Alpha = shiny.trendVarPlot.SE.alpha,
                    Plots.Structure.Points.Size = shiny.trendVarPlot.points.size, 
                    Plots.Structure.Points.Shape = shiny.trendVarPlot.points.shape,
                    Plots.Structure.ConnectingLine.Size = shiny.trendVarPlot.conLine.size, 
                    Plots.Structure.ZeroTrendLine.Color = shiny.trendVarPlot.zeroLine.color, 
                    Plots.Structure.ZeroTrendLine.Alpha = shiny.trendVarPlot.zeroLine.alpha, 
                    Plots.Structure.ZeroTrendLine.Size = shiny.trendVarPlot.zeroLine.size,
                    Plots.Structure.nonZeroTrendLine.Color = shiny.trendVarPlot.nonzeroLine.color, 
                    Plots.Structure.nonZeroTrendLine.Alpha = shiny.trendVarPlot.nonzeroLine.alpha, 
                    Plots.Structure.nonZeroTrendLine.Size = shiny.trendVarPlot.nonzeroLine.size,
                    Plots.Structure.DY.Title = shiny.trendVarPlot.dy.title, 
                    Plots.Structure.DY.yAxisTitle = shiny.trendVarPlot.dy.yaxisTitle,
                    Plots.Structure.CY.Title = shiny.trendVarPlot.cy.title, 
                    Plots.Structure.CY.yAxisTitle = shiny.trendVarPlot.cy.yaxisTitle,
                    Plots.Structure.AY.Title = shiny.trendVarPlot.ay.title, 
                    Plots.Structure.AY.yAxisTitle = shiny.trendVarPlot.ay.yaxisTitle,
                    Plots.Structure.weights.Title = shiny.trendVarPlot.hetero.title, 
                    Plots.Structure.weights.yAxisTitle = shiny.trendVarPlot.hetero.yaxisTitle,
                    Plots.Structure.Theme.LineType = shiny.trendVarPlot.theme.lineType,
                    Plots.autoVal.SE.Color = shiny.autoValidationPlot.se.color, 
                    Plots.autoVal.SE.Alpha2 = shiny.autoValidationPlot.se.alpha2se, 
                    Plots.autoVal.SE.Alpha1 = shiny.autoValidationPlot.se.alpha1se,
                    Plots.autoVal.CenterLine.Type = shiny.autoValidationPlot.centerLine.type, 
                    Plots.autoVal.CenterLine.Color = shiny.autoValidationPlot.centerLine.color,
                    Plots.autoVal.Line.Color = shiny.autoValidationPlot.meanLine.color, 
                    Plots.autoVal.Line.Size = shiny.autoValidationPlot.meanLine.size,
                    Plots.Residual.Res.Symbol = shiny.residualPlots.res.symbol, 
                    Plots.Residual.Res.Color = shiny.residualPlots.res.color, 
                    Plots.Residual.Res.BackgroundColor = shiny.residualPlots.res.backgroundColor,
                    Plots.Residual.DY.Title = shiny.residualPlots.dy.title, 
                    Plots.Residual.DY.xAxisTitle = shiny.residualPlots.dy.xAxisTitle, 
                    Plots.Residual.DY.yAxisTitle = shiny.residualPlots.dy.yAxisTitle,
                    Plots.Residual.AY.Title = shiny.residualPlots.ay.title, 
                    Plots.Residual.AY.xAxisTitle = shiny.residualPlots.ay.xAxisTitle, 
                    Plots.Residual.AY.yAxisTitle = shiny.residualPlots.ay.yAxisTitle,
                    Plots.Residual.CY.Title = shiny.residualPlots.cy.title, 
                    Plots.Residual.CY.xAxisTitle = shiny.residualPlots.cy.xAxisTitle, 
                    Plots.Residual.CY.yAxisTitle = shiny.residualPlots.cy.yAxisTitle,
                    Plots.Residual.ZeroLine.Color = shiny.residualPlots.zeroLine.color, 
                    Plots.Residual.ZeroLine.LineType = shiny.residualPlots.zeroLine.type,
                    Plots.Residual.MeanLine.Color = shiny.residualPlots.meanLine.color,
                    Plots.Residual.SE.OneFourthColor = shiny.residualPlots.stdError.colorOneFourth, 
                    Plots.Residual.SE.OneColor = shiny.residualPlots.stdError.colorOne, 
                    Plots.Residual.SE.TwoColor = shiny.residualPlots.stdError.colorTwo,
                    Plots.Residual.SE.ThreeColor = shiny.residualPlots.stdError.colorThree, 
                    Plots.Residual.SE.FourColor = shiny.residualPlots.stdError.colorFour,
                    Plots.Residual.ParameterLine.Type = shiny.residualPlots.parameterLine.type, 
                    Plots.Residual.ParameterLine.Width = shiny.residualPlots.parameterLine.width, 
                    Plots.Residual.ParameterLine.Color = shiny.residualPlots.parameterLine.color,
                    Plots.Residual.HeteroLine.Type = shiny.residualPlots.hetero.parameterLine.type, 
                    Plots.Residual.HeteroLine.Width = shiny.residualPlots.hetero.parameterLine.width, 
                    Plots.Residual.HeteroLine.Color = shiny.residualPlots.hetero.parameterLine.color,
                    Plots.Residual.Fitted.Title = shiny.residualPlots.fitted.title, 
                    Plots.Residual.Fitted.xAxisTitle = shiny.residualPlots.fitted.xAxisTitle, 
                    Plots.Residual.Fitted.yAxisTitle = shiny.residualPlots.fitted.yAxisTitle)
  })
  
  #reset settings to default
  observeEvent(input$default.settings, handlerExpr = {load("./set/default.ROCKYsettings")})

  #switch the model to GLM
  observeEvent(input$settings.make.loglinear, handlerExpr = {change.loglinear.model(plots = FALSE)})
  observeEvent(input$settings.make.odp.glm, handlerExpr = {change.glm.model(model = "odp", plots = FALSE)})
  observeEvent(input$settings.make.gamma.glm, handlerExpr = {change.glm.model(model = "gamma", plots = FALSE)})
  observeEvent(input$settings.make.normal.glm, handlerExpr = {change.glm.model(model = "gaussian", plots = FALSE)})

})