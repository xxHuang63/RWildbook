#' Transform a vector of date to a vector of millisecond.
#'
#' This function is to transform a period of time in date to millisecond according to the origin date and the format of date.
#'
#' A vector of size two represent a period of time. The start date of the period will be transform to the first millisecond of the date and the end of the period to the last millisecond.
#'
#' @param date A character vector represent a period of time from date[1] to date[2].
#'
#' @param origin A point of time which set to be zero in millisecond.
#'
#' @param format A format for date and origin arguments.
#'
#' @examples
#' dateTOmillisecond(date=c("1970-01-01","1970-02-01"))
#' #When the first date is after the second one
#' dateTOmillisecond(date=c("1970-02-01","1970-01-01"))
#'
#' #examples in different formats
#' dateTOmillisecond(date=c("1970-01-01","1970-02-01"),format="%Y-%d-%m")
#' dateTOmillisecond(date=c("1970/01/01","1970/02/01"),format="%Y/%m/%d")

dateTOmillisecond <-
function(date,origin="1970-01-01",format="%Y-%m-%d"){
  #This function is to transform the start minute of the date to millisecond according to the origin date.
  #The "date" argument is a character vector which means from date[1] to date[2]
  if(!is.null(date)){
    date1<-c((as.numeric(as.Date(date[1], origin = "1970-01-01", format))* 86400000),(as.numeric(as.Date(date[2], origin = "1970-01-01", format))* 86400000)+86340000)
    #The first element of "date" should smaller than the second one
    #Otherwise, function return the milliseconds in ascending order automatically with warning message
    if((date1[2]-date1[1]) < 0) {
      warning("The 'date' value should be in ascending order")
      date1 <- c((as.numeric(as.Date(date[2], origin = "1970-01-01", format))* 86400000),(as.numeric(as.Date(date[1], origin = "1970-01-01", format))* 86400000)+86340000)
    }
  }else date1 <- NULL
  return(date1)
}
