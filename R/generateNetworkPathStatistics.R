generateNetworkPathStatistics <- function(network,fxn){
  require(dplyr)
  network <- network %>% abs
  cutpoints <- (network[network %>% upper.tri %>% which] %>% unique) %>% sort(decreasing=T)
  internalFunction <- function(cut,network,fxn){
    argList <- list()
    argList$x <- network>=cut
    (fxn %>% do.call(args=argList)) %>% return
  }
  (cutpoints %>% sapply(internalFunction,network,fxn)) %>% return
}