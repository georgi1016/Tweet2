\name{SentimentCloud}
\alias{SentimentCloud}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
tweet
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SentimentCloud(keyword, n)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{keyword}{
%%     ~~Describe \code{keyword} here~~
}
  \item{n}{
%%     ~~Describe \code{n} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (keyword, n) 
{
    chooseCRANmirror(ind = 74)
    install.packages("twitteR", "RCurl", "RJSONIO", "stringr", 
        "tm", "wordcloud")
    library("twitteR")
    library(RCurl)
    library(RJSONIO)
    library(stringr)
    library(tm)
    library(wordcloud)
    clean.text <- function(some_txt) {
        some_txt = gsub("(RT|via)((?:\\b\\W*@\\w))", "", some_txt)
        some_txt = gsub("@\\w", "", some_txt)
        some_txt = gsub("[[:punct:]]", "", some_txt)
        some_txt = gsub("[[:digit:]]", "", some_txt)
        some_txt = gsub("http\\w", "", some_txt)
        some_txt = gsub("[ \t]{2,}", "", some_txt)
        some_txt = gsub("^\\s|\\s$", "", some_txt)
        some_txt = gsub("amp", "", some_txt)
        try.tolower = function(x) {
            y = NA
            try_error = tryCatch(tolower(x), error = function(e) e)
            if (!inherits(try_error, "error")) 
                y = tolower(x)
            return(y)
        }
        some_txt = sapply(some_txt, try.tolower)
        some_txt = some_txt[some_txt != ""]
        names(some_txt) = NULL
        return(some_txt)
    }
    getSentiment <- function(text, key) {
        text <- URLencode(text)
        data <- getURL(paste("http://api.datumbox.com/1.0/TwitterSentimentAnalysis.json?api_key=", 
            key, "&text=", text, sep = ""))
        js <- fromJSON(data, asText = TRUE)
        sentiment = js$output$result
        return(list(sentiment = sentiment))
    }
    tweets = searchTwitter(keyword, n)
    tweet_txt = sapply(tweets, function(x) x$getText())
    tweet_clean = clean.text(tweet_txt)
    tweet_num = length(tweet_clean)
    tweet_df = data.frame(text = tweet_clean, sentiment = rep("", 
        tweet_num), stringsAsFactors = FALSE)
    db_key = "34948b7e13af842df4a94324273d3b53"
    sentiment = rep(0, tweet_num)
    for (i in 1:tweet_num) {
        tmp = getSentiment(tweet_clean[i], db_key)
        tweet_df$sentiment[i] = tmp$sentiment
        print(paste(i, " of ", tweet_num))
    }
    tweet_df <- tweet_df[tweet_df$sentiment != "", ]
    sents = levels(factor(tweet_df$sentiment))
    labels <- lapply(sents, function(x) paste(x, format(round((length((tweet_df[tweet_df$sentiment == 
        x, ])$text)/length(tweet_df$sentiment) * 100), 2), nsmall = 2), 
        "\%"))
    nemo = length(sents)
    emo.docs = rep("", nemo)
    for (i in 1:nemo) {
        tmp = tweet_df[tweet_df$sentiment == sents[i], ]$text
        emo.docs[i] = paste(tmp, collapse = " ")
    }
    emo.docs = removeWords(emo.docs, stopwords("german"))
    emo.docs = removeWords(emo.docs, stopwords("english"))
    corpus = Corpus(VectorSource(emo.docs))
    tdm = TermDocumentMatrix(corpus)
    tdm = as.matrix(tdm)
    colnames(tdm) = labels
    comparison.cloud(tdm, colors = brewer.pal(nemo, "Dark2"), 
        scale = c(3, 0.5), random.order = FALSE, title.size = 1.5)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
