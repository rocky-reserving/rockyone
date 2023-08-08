#' @title load.FileInputs
#' 
#' @description This function loads the StartAY and StartCY values from the Excel file by first running a VBScript that copies
#' the cells with the StartAY and StartCY values to the clipboard, then reading in the clipboard.
#' 
#' @return The StartAY and StartCY values are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' load.FileInputs()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include load.FileInputs.R
#' 
load.FileInputs <- function(){
  ROCKY.settings$StartAY <<- load.StartAY()
  ROCKY.settings$StartCY <<- load.StartCY()
}