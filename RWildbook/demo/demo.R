#demo for pulling data from the Wildbook interface with RWildbook package
#Pulling data of all the encounters of individual "A-001" in whaleshark.org
#All the datasets below are searching for the same set of data which is all the encounter of individual "A-001" in "whaleshark.org".

#Case 1. If you have a searchURL on hand
data1 <- searchWB(searchURL = "http://xinxin:changeme@whaleshark.org/api/jdoql?SELECT FROM org.ecocean.Encounter WHERE individualID == 'A-001'")

#Case 2. If you don't have the search URL but have the JDOQL query for the search:
#Opion 1. You can generate a search URL with the JDOQL query using function "WBsearchURL", and back to case 1.
searchURL2 <- WBsearchURL(username="xinxin",
                          password="changeme",
                          baseURL="whaleshark.org",
                          jdoql="SELECT FROM org.ecocean.Encounter WHERE individualID == 'A-001'")
data2.1 <- searchWB(searchURL = searchURL2)
#Option 2. You can use the function searchWB directly
data2.2 <- searchWB(username="xinxin",
                    password="changeme",
                    baseURL ="whaleshark.org",
                    jdoql="SELECT FROM org.ecocean.Encounter WHERE individualID == 'A-001'")

#Case 3. If you don't have searchURL or the JDOQL query ready for searching the data,
#Option 1. You can generate the JDOQL query with function "WBjdoql" and back to case 2.
jdoql3 <- WBjdoql(object="encounter",individualID = "A-001")

searchURL3 <- WBsearchURL(username="xinxin",
                          password="changeme",
                          baseURL="whaleshark.org",
                          jdoql=jdoql3)

data3.1 <- searchWB(searchURL = searchURL3)

#or,

data3.2 <- searchWB(username="xinxin",
                    password="changeme",
                    baseURL ="whaleshark.org",
                    jdoql=jdoql3)

#Option 2. You can filter variables directly in the function "searchWB".
data3.3 <- searchWB(username="xinxin",
                    password="changeme",
                    baseURL ="whaleshark.org",
                    object="Encounter",
                    individualID=c("A-001"))







