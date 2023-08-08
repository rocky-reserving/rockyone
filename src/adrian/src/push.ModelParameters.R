#' @title push.ModelParameters
#' 
#' @description This function pushes the ModelParameters values to Excel by first running a VBScript that copies
#' the cells with the ModelParameters values to the clipboard, then reading in the clipboard.
#' 
#' @return The ModelParameters values are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.ModelParameters()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.ModelParameters.R
#' 
push.ModelParameters <- function(){
  push.AYGp()
  push.DYGp()
  push.CYGp()
  push.DYwGp()
  push.DYw()
  push.AYgpFilters()
}

#' @title push.AYGp
#' 
#' @description This function pushes the AYGp parameters to Excel by first running a VBScript that copies
#' the cells with the AYGp parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The AYGp parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.AYGp()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.AYGp.R
#' 
push.AYGp <- function(){
  copy.table(resObj$AYGp)
  shell(cmd = "./VBScripts/Push/Push_AYGp.vbs", translate = TRUE)
}

#' @title push.DYGp
#' 
#' @description This function pushes the DYGp parameters to Excel by first running a VBScript that copies
#' the cells with the DYGp parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The DYGp parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.DYGp()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.DYGp.R
#' 
push.DYGp <- function(){
  copy.table(resObj$DYGp)
  shell(cmd = "./VBScripts/Push/Push_DYGp.vbs", translate = TRUE)
}

#' @title push.CYGp
#' 
#' @description This function pushes the CYGp parameters to Excel by first running a VBScript that copies
#' the cells with the CYGp parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The CYGp parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.CYGp()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.CYGp.R
#' 
push.CYGp <- function(){
  copy.table(resObj$CYGp)
  shell(cmd = "./VBScripts/Push/Push_CYGp.vbs", translate = TRUE)
}

#' @title push.CYpt
#' 
#' @description This function pushes the CYpt parameters to Excel by first running a VBScript that copies
#' the cells with the CYpt parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The CYpt parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.CYpt()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.CYpt.R
#' 
push.CYpt <- function(){
  copy.table(resObj$CyProjTrendModel)
  shell(cmd = "./VBScripts/Push/Push_CYpt.vbs", translate = TRUE)
}

#' @title push.DYwGp
#' 
#' @description This function pushes the DYwGp parameters to Excel by first running a VBScript that copies
#' the cells with the DYwGp parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The DYwGp parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.DYwGp()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.DYwGp.R
#' 
push.DYwGp <- function(){
  copy.table(resObj$DYwGp)
  shell(cmd = "./VBScripts/Push/Push_DYwGp.vbs", translate = TRUE)
}

#' @title push.DYw
#' 
#' @description This function pushes the DYw parameters to Excel by first running a VBScript that copies
#' the cells with the DYw parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The DYw parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.DYw()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.DYw.R
#' 
push.DYw <- function(){
  copy.table(resObj$DYw)
  shell(cmd = "./VBScripts/Push/Push_DYw.vbs", translate = TRUE)
}

#' @title push.AYgpFilters
#' 
#' @description This function pushes the AYgpFilters parameters to Excel by first running a VBScript that copies
#' the cells with the AYgpFilters parameters to the clipboard, then reading in the clipboard.
#' 
#' @return The AYgpFilters parameters are loaded into the global environment. The function returns nothing.
#' 
#' @examples
#' push.AYgpFilters()
#' 
#' @importFrom utils read.table
#' @importFrom base shell
#' @importFrom base as.numeric
#' 
#' @include push.AYgpFilters.R
#' 
push.AYgpFilters <- function(){
  shell(cmd = "./VBScripts/Clear_AYFilters.vbs", translate = TRUE) #clear AY filter table before paste in new one
  copy.table(resObj$AYgpFilters)
  shell(cmd = "./VBScripts/Push/Push_AYgpFilters.vbs", translate = TRUE)
}