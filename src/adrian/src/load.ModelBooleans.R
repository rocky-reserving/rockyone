format.clipboard <- function(){
  temp <- read.table(file = "clipboard", header = FALSE, sep = "\t")
  temp <- as.numeric(temp)
  return(temp)
}

#' @title load.ModelBooleans
#' 
#' @description This function loads the ModelBooleans values from the Excel file by first running a VBScript that copies
#' the cells with the ModelBooleans values to the clipboard, then reading in the clipboard. The ModelBooleans values are
#' loaded into the global environment. The function makes use of the format.clipboard helper function. The function returns
#' nothing.
#' 
#' @return The ModelBooleans values are loaded into the global environment.
#' 
#' @examples
#' load.ModelBooleans()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include load.ModelBooleans.R
#' 
load.ModelBooleans <- function(){
  #creates a vector (NewModel) of boolean values that tell us whether or not the model is empty or not 
  NewModel <- data.frame(c(1))  
  
  #NewModel
  shell(cmd = "./VBScripts/Check_NewModel.vbs", translate = TRUE)
  NewModel$NewModel <- format.clipboard()
  
  #HasAYGp
  shell(cmd = "./VBScripts/Check_HasAYGp.vbs", translate = TRUE)
  NewModel$HasAYGp <- format.clipboard()
  
  #HasAYgpFilters
  shell(cmd = "./VBScripts/Check_HasAYgpFilters.vbs", translate = TRUE)
  NewModel$HasAYgpFilters <- format.clipboard()
  
  #HasCYGp
  shell(cmd = "./VBScripts/Check_HasCYGp.vbs", translate = TRUE)
  NewModel$HasCYGp <- <- format.clipboard()
  
  #HasCYpt
  shell(cmd = "./VBScripts/Check_HasCYpt.vbs", translate = TRUE)
  NewModel$HasCYpt <- format.clipboard()
  
  #HasDYGp
  shell(cmd = "./VBScripts/Check_HasDYGp.vbs", translate = TRUE)
  NewModel$HasDYGp <- format.clipboard()
  
  #HasDYw
  shell(cmd = "./VBScripts/Check_HasDYw.vbs", translate = TRUE)
  NewModel$HasDYw <- format.clipboard()
  
  #HasDYwGp
  shell(cmd = "./VBScripts/Check_HasDYwGp.vbs", translate = TRUE)
  NewModel$HasDYwGp <- format.clipboard()
  
  #get this data outside this function
  ModelBooleans <<- NewModel
}
