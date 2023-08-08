#' @title Load StartCY
#' 
#' @description This function loads the StartCY value from the Excel file by first running a VBScript that copies
#' the cell with the StartCY value to the clipboard, then reading in the clipboard.
#' 
#' @return The StartCY value
#' @export
#' 
#' @examples
#' load.StartCY()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include load.StartCY.R
#' 
load.StartCY <- function(){
  #first, run the shell command that runs the VBScript and copies the cell with the StartCY value
  shell(cmd = "./VBScripts/Load_StartCY.vbs", translate = TRUE)
  
  #the proper cell (and value) is now on the clipboard on a 1x1 data frame
  #read it in
  temp <- read.table(file = "clipboard", header = FALSE, sep = "\t")
  
  #since just read in a data frame, convert variable to a simple integer
  temp <- as.numeric(temp)
  
  #now return the value
  return(temp)
}