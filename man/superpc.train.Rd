\name{superpc.train}

\alias{superpc.train}

\title{
    Prediction by supervised principal components
}

\description{
    Does prediction of a quantitative regression or survival outcome, 
    by the supervised principal components method.
}

\usage{
    superpc.train(data, 
                  type=c("survival", "regression"), 
                  s0.perc=NULL)
}

\arguments{
    \item{data}{ Data object with components x- p by n matrix of features,
                 one observation per column; y- n-vector of outcome measurements;
                 censoring.status- n-vector of censoring censoring.status 
                 (1= died or event occurred, 0=survived, or event was censored), 
                 needed for a censored survival outcome}
    \item{type}{Problem type: 
                "survival" for censored survival outcome, or 
                "regression" for simple quantitative outcome}
    \item{s0.perc}{Factor for denominator of score statistic, between 0 and 1: 
                   the percentile of standard deviation values added to the denominator. 
                   Default is 0.5 (the median)}
}

\details{
    Compute wald scores for each feature (gene), for later use in superpc.predict and superpc.cv
}

\value{
    \item{feature.scores }{Score for each feature (gene)}
    \item{type }{problem type}
    \item{s0.perc}{Factor for denominator of score statistic}
    \item{call }{calling sequence}
}

\references{
    \itemize{
        \item E. Bair and R. Tibshirani (2004).
              "\emph{Semi-supervised methods to predict patient survival from gene expression data}."
              PLoS Biol, 2(4):e108.
        \item E. Bair, T. Hastie, D. Paul, and R. Tibshirani (2006).
              "\emph{Prediction by supervised principal components}."
              J. Am. Stat. Assoc., 101(473):119-137.
    }
}

\author{
    \itemize{
        \item "Eric Bair, Ph.D."
        \item "Jean-Eudes Dazard, Ph.D."
        \item "Rob Tibshirani, Ph.D."
    }
    Maintainer: "Rob Tibshirani, Ph.D."
}

\examples{
set.seed(332)

#generate some data
x <- matrix(rnorm(50*30), ncol=30)
y <- 10 + svd(x[1:50,])$v[,1] + .1*rnorm(30)
censoring.status <- sample(c(rep(1,20), rep(0,10)))

featurenames <- paste("feature", as.character(1:50), sep="")
data <- list(x=x, 
             y=y, 
             censoring.status=censoring.status, 
             featurenames=featurenames)

a <- superpc.train(data, type="survival")
}

\keyword{regression}
\keyword{survival}
