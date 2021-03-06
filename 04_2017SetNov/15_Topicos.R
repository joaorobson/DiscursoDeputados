
# par�metros da an�lise
# ini <- 2015
# fim <- 2015
# partido <- "PT"

if(!require(tm)) { install.packages('tm') }
if(!require(qdap)) { install.packages('qdap') }
if(!require(RWeka)) { install.packages('RWeka') }

if(!require(tidyverse)) { install.packages('tidyverse') }
if(!require(tidytext)) { install.packages('tidytext') }
if(!require(tidyr)) { install.packages('tidyr') }
if(!require(dplyr)) { install.packages('dplyr') }

if(!require(quanteda)) { install.packages('quanteda') }

# se o arquivo de t�picos n�o existir, efetua toda a an�lise
topicos_discurso <- function(ini, fim, partido){

  print(paste0(partido, " - ", ini, " a ", fim))
  
  # l� arquivo do corpus sob an�lise
  pasta_corpora <- "..\\CorpusRDS\\"
  arq_corpora <- paste0("corpus_", partido, "_", ini, "_", fim, "_limpo.rds")
  lista <- readRDS(paste0(pasta_corpora, arq_corpora))
  docs <- lista[[1]]
  
  # monta vetor de textots para utiliza��o do pacote quanteda
  print('reconstru��o do vetor de discursos')
  docs <- docs$content
  n <- length(docs)
  vdisc <- vector("character", n)
  for(i in 1:n){
    vdisc[i] <- docs[[i]]$content
  }
  
  # fun��es do pacote quanteda
  myCorpus <- corpus(vdisc)
  myDfm <- dfm(myCorpus) # , stem = TRUE)
  ## Creating a dfm from a corpus ...
  ##    ... lowercasing
  ##    ... tokenizing
  ##    ... indexing documents
  ##    ... indexing features
  ##    ... stemming features (English)
  
  # remove termos pouco frequentes
  # http://stats.stackexchange.com/questions/160539/is-this-interpretation-of-sparsity-accurate/160599#160599
  print('remove termos esparsos')
  sparsityThreshold <- round(ndoc(myDfm) * (1 - 0.9999))
  myDfm <- dfm_trim(myDfm, min_docfreq = sparsityThreshold)
  nfeature(myDfm)
  
  rm(docs, lista, myCorpus, n, sparsityThreshold, vdisc, pasta_corpora, arq_corpora)
  
  # modelo Latent Dirichlet Allocation - LDA
  if(!require(topicmodels)) { install.packages('topicmodels') }
  
  SEED <- 2010
  k <- 5
  myDfm <- quantedaformat2dtm(myDfm)
  
  # Variational Expectation Maximization - VEM
  lda <- LDA(myDfm, k, control = list(seed = SEED))
  VEM <- terms(lda, 10)
  print("VEM")
  rm(lda)
  
  # VEM - fixed
  lda = LDA(myDfm, k = k, control = list(estimate.alpha = FALSE, seed = SEED))
  VEM_fixed <- terms(lda, 10)
  print("VEM - fixed")
  rm(lda)
  
  # Gibbs
  lda = LDA(myDfm, k = k, method = "Gibbs",
            control = list(seed = SEED, burnin = 1000,
                           thin = 100, iter = 1000))
  GIBBGS <- terms(lda, 10)
  print("Gibbs")
  rm(lda)
  
  termos <- list(VEM, VEM_fixed, GIBBGS)
  
  pasta_topicos <- "..\\Topicos\\"
  arq_topicos <- paste0(pasta_topicos, "topicos_", partido, "_", ini, "_", fim, ".rds")

  saveRDS(termos, arq_topicos)  
}



# Exemplo de clusteriza��o
# https://rstudio-pubs-static.s3.amazonaws.com/265713_cbef910aee7642dc8b62996e38d2825d.html
