\name{superpc.lrtest.curv}

\alias{superpc.lrtest.curv}

\title{
    Compute values of likelihood ratio test  from supervised  principal components fit
}

\description{
    Compute values of likelihood ratio test from supervised principal components fit 
}

\usage{
    superpc.lrtest.curv(object, 
                        data, 
                        newdata, 
                        n.components=1, 
                        threshold=NULL, 
                        n.threshold=20)
}

\arguments{
    \item{object}{ Object returned by superpc.train.}
    \item{data}{ List of training data, of form described in superpc.train documentation.}
    \item{newdata}{ List of test data; same form as training data.}
    \item{n.components}{ Number of principal components to compute. Should be 1,2 or 3.}
    \item{threshold}{ Set of thresholds for scores; 
                      default is n.threshold values equally spaced over the range of the feature scores.}
    \item{n.threshold}{ Number of thresholds to use; default 20. Should be 1,2 or 3.}
}

\value{
    \item{lrtest }{Values of likelihood ratio test statistic}
    \item{comp2 }{Description of 'comp2'}
    \item{threshold}{ Thresholds used}
    \item{num.features}{Number of features exceeding threshold}
    \item{type}{Type of outcome variable}
    \item{call}{calling sequence}
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
ytest <- 10 + svd(x[1:50,])$v[,1] + .1*rnorm(30)
censoring.status <- sample(c(rep(1,20), rep(0,10)))
censoring.status.test <- sample(c(rep(1,20), rep(0,10)))

featurenames <- paste("feature", as.character(1:50), sep="")
data <- list(x=x, 
             y=y, 
             censoring.status=censoring.status, 
             featurenames=featurenames)
data.test <- list(x=x, 
                  y=ytest, 
                  censoring.status=censoring.status.test, 
                  featurenames=featurenames)

a <- superpc.train(data, type="survival")
aa <- superpc.lrtest.curv(a, data, data.test)
#superpc.plot.lrtest(aa)
}

\keyword{regression}
\keyword{survival}
