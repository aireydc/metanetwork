rankedEdgeList <- function(network,symmetric=FALSE){
  require(dplyr)
  edgeMat <- matrix(paste0('e',1:(nrow(network)*ncol(network))),nrow(network),ncol(network))
  #rownames(edgeMat) <- rownames(network)
  #colnames(edgeMat) <- colnames(netw)
  if(!symmetric){
    whichMatrix <- ((network%>%abs) > 0) %>% which(T)
  }else {
    whichMatrix <- ((network%>%abs) > 0 & network%>%upper.tri) %>% which(T)    
  }
  internal <- function(ind,x){ return(x[ind[1],ind[2]])}
  rankedEdgeList <- cbind(rownames(network)[whichMatrix[,1]],colnames(network)[whichMatrix[,2]],apply(whichMatrix,1,internal,network))
  colnames(rankedEdgeList) <- c('var1','var2','value')
  #rownames(rankedEdgeList) <- paste0('edge',1:nrow(rankedEdgeList))
  rownames(rankedEdgeList) <- apply(whichMatrix,1,internal,edgeMat)
  rankedEdgeList <- rankedEdgeList %>% data.frame(stringsAsFactors = F)
  rankedEdgeList$value <- as.numeric(rankedEdgeList$value)
  rankedEdgeList <- rankedEdgeList[order((rankedEdgeList$value %>% abs),decreasing=T),]
  #rownames(rankedEdgeList) <- paste0('edge',1:nrow(rankedEdgeList))
  rankedEdgeList %>% return
}