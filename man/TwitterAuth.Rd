\name{TwitterAuth}
\alias{TwitterAuth}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
TwitterAuth(api_key, api_secret)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{api_key}{
%%     ~~Describe \code{api_key} here~~
}
  \item{api_secret}{
%%     ~~Describe \code{api_secret} here~~
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
function (api_key, api_secret) 
{
    install.packages(c("twitteR", "RCurl"))
    require(RCurl)
    require(twitteR)
    options(RCurlOptions = list(cainfo = system.file("CurlSSL", 
        "cacert.pem", package = "RCurl")))
    reqURL <- "https://api.twitter.com/oauth/request_token"
    accessURL <- "https://api.twitter.com/oauth/access_token"
    authURL <- "https://api.twitter.com/oauth/authorize"
    apiKey <- api_key
    apiSecret <- api_secret
    twitCred <- OAuthFactory$new(consumerKey = apiKey, consumerSecret = apiSecret, 
        requestURL = reqURL, accessURL = accessURL, authURL = authURL)
    twitCred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", 
        package = "RCurl"))
    registerTwitterOAuth(twitCred)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
