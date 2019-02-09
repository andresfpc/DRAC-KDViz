setwd("C:/Users/andre")
library("KDViz")

myKeywords <- c("impact fatigue","composite materials", "dcb", "track growth rate")
myBibDataOnline <- ArticleSearch(keywords = myKeywords, webSite = "ScienceDirect", saveCSV = TRUE, exportName = "Mech")
#myBibDataOnline <- read.table("KDKeywords.csv", header = TRUE, sep = ",")
myBibData <- myBibDataOnline

myCorpus <- BibToCorpus(bibData = myBibData, bibUnits = "Keywords", controlList = c("stripWhitespace"), stopWords = TRUE, wordsToRemove = c("analysis", "data", "text", "review", "topic", "theory", "protein"), replaceWords = "KDReplaceWords.txt")

termFreqTable <- TermFrequency(myCorpus)
head(termFreqTable, 100)
TermFreqByWord(termFreqTable = termFreqTable, word = "docume")

myDTM <- DTMFromCorpus(corpus = myCorpus, rowNames = row.names(myBibData))

mpaWords <- matrix.corpus.mpa(myCorpus, fmin = 8, cmin = 1)
mpaWords$Words

myKDSummary <- KDSummary(matrix.mpa = mpaWords, groupSize = 10)
myKDSummary$clustTable
myKDSummary$wordClasses

myWordGroupDTM <- GroupDTM(dtm = myDTM, kdSummary = myKDSummary)

KDViz(groupDTM = myWordGroupDTM, group = 1, export = TRUE)
KDViz(groupDTM = myWordGroupDTM, group = 12, export = TRUE)

myKDSummary$wordClasses[myKDSummary$wordClasses$Class == 11, ]

LoadArticle(myBibData, "A625")