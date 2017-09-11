#Script to send data to TIBCO cloud and receive transated LAT LONG based in addresses in table.
#For use with JSON interface
#Change user(iesbrazil) and set your key provided by TIBCO.
#Made by Rodrigo Eiras

library(httr)
library(RJSONIO)

inTBL <- data.frame(SetTableWithAddresses)
baseURL <- 'http://geowebservices.maporama.com/iesbrazil/coder.json?maporamakey=setKEYhere==%20'

locs <- list()
Lats <- list()
Longs <- list()
Levels <- list()
Scores <- list()
States <- list()
Countries <- list()
EntireAddresses <- list()

for(i in 1:length(inTBL$Address)){
  mydata <- fromJSON(paste0(baseURL, "&country=", inTBL$Country[i], "&state=", inTBL$State[i], "&city=", inTBL$City[i], "&street=", inTBL$Address[i], "&zip=", inTBL$zip[i]), flatten=TRUE, simplify = FALSE)
  message("Retrieving data ", i)
  locs[[i]] <- mydata
}

for(j in 1:length(inTBL$Address)){
  
  Lats[[j]] <- print(locs[j][[1]][[1]]$Location$Latitude)
  Longs[[j]] <- print(locs[j][[1]][[1]]$Location$Longitude)
  Levels[[j]] <- print(locs[j][[1]][[1]]$Level)
  Scores[[j]] <- print(locs[j][[1]][[1]]$Score)
  States[[j]] <- print(locs[j][[1]][[1]]$State)
  Countries[[j]] <- print(locs[j][[1]][[1]]$Country)
  EntireAddresses[[j]] <- print(locs[j][[1]][[1]]$EntireAddress)
  
}

Lat <- as.numeric(unlist(Lats))
Long <- as.numeric(unlist(Longs))
Level <- as.integer(unlist(Levels))
Score <- as.numeric(unlist(Scores))
State <- unlist(States)
Country <- unlist(Countries)
Address <- unlist(EntireAddresses)


Encoding(State) <- "UTF-8"
Encoding(Country) <- "UTF-8"
Encoding(Address) <- "UTF-8"


GeoLocation <- data.frame(OrigAddress=inTBL$Address, ObjectNumber=inTBL$ObjectNumber, OrigState=inTBL$State, OrigZip=inTBL$zip, Lat=Lat, Long=Long, Score=Score, State=State, Country=Country, Address=Address)

