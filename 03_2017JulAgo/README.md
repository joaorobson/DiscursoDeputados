﻿# CRONOGRAMA: julho e agosto de 2017

## Scripts R

### 08_CriaCorporaArquivosDiscursos.R

Lê arquivos "discurso_AAAA.csv", compreendidos entre ano inicial e final informados, e consolida todos os discrusos em um único arquivo "discurso_ini_fim.rds" na pasta "..\\CorporaRDS". Converte os respectivos arquivos "discurso_AAAA_dit.csv" para o formato "rds" e grava na mesma pasta.

### 09_ListaNomesMembrosMesa.R

Produz lista de nomes dos membros da Mesa Diretora das legislaturas informadas com a finalidade de retirar os nomes dos discursos.

### 10_CorpusPorCriterios.R

A partir dos critérios ano inicial, ano final e partido, cria corpus "corpus_partido_ini_fim.rds" com os discursos de inteiro teor na pasta "..\\CorpusRDS".

### 11_LimpaCorpusParaAnalise.R

Contém a função **limpa_corpus** que efetua as etapas essenciais do PLN: transformações para minúscula; remoção de números, pontuação, plurais, acentuação e espaços; remoção de stopwords (palavras com pouca informação) a partir de dicionário com 200 palavras específicas do discurso parlamentar, além de conjunto com nomes próprios encontrados no discurso parlamentar (arquivos "stopwords_####.txt").

O resultado final é armazenado em arquivo cujo nome é formado pela estrutura "corpus_partido_ini_fim_limpo.rds".

### 12_NuvemDePalavrasFreq.Rmd

Cria a matriz de frequência de termos e documentos; identifica as palavras mais frequentes; efetua a penalização de palavras por meio do algoritmo de inversão da frequência de documentos; filtra termos escassos; constrói nuvens de palavras.

Exemplos:  
["12_NuvemDePalavrasFreq_PT_2003_2016.html"](http://htmlpreview.github.com/?https://github.com/Fpschwartz1/DiscursoDeputados/blob/master/03_2017JulAgo/12_NuvemDePalavrasFreq_PT_2003_2016.html)  
["12_NuvemDePalavrasFreq_PT_2016_2017.html"](http://htmlpreview.github.com/?https://github.com/Fpschwartz1/DiscursoDeputados/blob/master/03_2017JulAgo/12_NuvemDePalavrasFreq_PT_2016_2017.html)

### 13_ExecutaArquivos_10_11_12.R

Script que executa, em sequência, os arquivos "10_CorpusPorCriterios.R", "11_LimpaCorpusParaAnalise.R" e "12_NuvemDePalavrasFreq.Rmd", a partir da informação dos parâmetros "ini", "fim" e "partido".

### 14_AjustaArquivosStopwords.R

Remove repetições dos arquivos de stopwords e ordena alfabeticamente.
