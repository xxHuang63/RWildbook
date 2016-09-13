#' Pull data from the Wildbook framework.
#'
#' This function allows users to pull data from the Wildbook framework in R.
#'
#' @param searchURL A URL for data searching in the Wildbook framework.
#'
#' @param username The username in the Wildbook framework.
#'
#' @param password The password in the Wildbook framework.
#'
#' @param baseURL The URL represent the wildbook data base.
#'
#' @param jdoql The JDOQL string for data searching.
#'
#' @param object can be either "encounter" for the encounter search or "individual" for the individual search.
#'
#' @param location A string of character contained in location names.
#'
#' @param locationID A character vector for filtering the locationID.
#'
#' @param sighting_date A character for filtering encounters which are sighted during a period of time.
#'
#' @param encounter_submission_dates A character for filtering encounters which are submitted during a period of time.
#'
#' @param date_format The format for all the arguments of date valule.
#'
#' @param sex A character vector of maximum size of three represents the value for the sex filter.
#'
#' @param status A character vector of maximum size of two represents the value for the encounter status.
#'
#' @param measurement A numeric object sets the minimum individual measurement when searching in the Wildbook framework.
#'
#' @param individualID A character vector for searching data of specific individual ID.
#'
#' @param encounterID A character vector for searching data of specific encounter ID.
#'
#' @param encounter_type A character vector of maximum size of three for searching data with specific encounter type.
#'
#' @param Date_of_birth A character vector for searching data of individual which is borned during a period of time.
#'
#' @param Date_of_death A character vector for searching data of individual which is dead during a period of time.
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
#' @examples
#' ##same searches for users of different background.
#' data1 <- searchWB(searchURL = "http://xinxin:changeme@whaleshark.org/api/jdoql?SELECT FROM org.ecocean.MarkedIndividual WHERE individualID == 'A-001'")
#'
#' data2 <- searchWB(username="xinxin",password="changeme",baseURL ="whaleshark.org",jdoql="SELECT FROM org.ecocean.Encounter WHERE catalogNumber != null &&  (( dateInMilliseconds >= -189388800000 )&&( dateInMilliseconds <= 1483228740000 ))&&(( dwcDateAddedLong >= 1041379200000 )&&( dwcDateAddedLong <= 1483228740000 ))&&(( individualID == 'a-001' )) ")
#'
#' data3 <- searchWB(username="xinxin",password="changeme",baseURL ="whaleshark.org",object="Encounter",individualID=c("A-001"))
#'
searchWB <-
function(searchURL=NULL,
                   username=NULL,password=NULL,baseURL, jdoql=NULL,
                   object="encounter",
                   location=NULL,locationID=NULL,
                   sighting_date=c("1964-01-01","2016-12-31"),encounter_submission_dates=c("2003-01-01","2016-12-31"), date_format="%Y-%m-%d",
                   sex=c("male","female","unknown"),status=c("alive","dead"),
                   measurement=NULL,individualID=NULL,
                   encounterID=NULL,encounter_type=NULL,
                   Date_of_birth=NULL,Date_of_death=NULL){
  #This function is to get data from the Wildbook framework via the JDO API
  #For user of different level
  #Step 1. Define(generate) the JDOQL query
  if(is.null(searchURL)&&is.null(jdoql)){
    jdoql<-WBjdoql(object,
                   location,locationID,
                   sighting_date,encounter_submission_dates, date_format,
                   sex,status, measurement,individualID,
                   encounterID,encounter_type)
  }
  #Step 2.Define(generate) the search URL
  if(is.null(searchURL)){
    if(is.null(username)||is.null(password)){
      warning("Lack of username and password")
      break
    }
    searchURL<-WBsearchURL(username,password,baseURL,jdoql)
  }
  #Step 3. Get data from Wildbook framework with the search URL
  cat(searchURL)
  tmpdata <- readLines(searchURL,warn=FALSE)
  data <- fromJSON(tmpdata)
  #data <- fromJSON(url(searchURL))
}
