\name{superpc.decorrelate}

\alias{superpc.decorrelate}

\title{
    Decorrelate features  with respect to competing predictors
}

\description{
    Fits a linear model to the  features as a function of some competing predictors.
    Replaces the features by the residual from this fit.
    These "decorrelated" features are then used in the superpc model building process, to
    explicitly look for predictors that are independent of the competing predictors.
    Useful for example, when the competing predictors are clinical predictors like stage, grade etc.
}

\usage{
    superpc.decorrelate(x, 
                        competing.predictors) 
}

\arguments{
    \item{x}{ matrix of features. Different features  in different  rows, one observation per column}
    \item{competing.predictors}{List of one or more competing predictors.  Discrete predictors should be factors}
}

\value{
    Returns lm (linear model) fit of rows of x on compeiting predictors.
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
    Maintainer: "Jean-Eudes Dazard, Ph.D."
}

\examples{
set.seed(332)

#generate some data
x <- matrix(rnorm(50*30), ncol=30)
y <- 10 + svd(x[1:50,])$v[,1] + .1*rnorm(30)
censoring.status <- sample(c(rep(1,20), rep(0,10)))

featurenames <- paste("feature", as.character(1:50), sep="")
competing.predictors <- list(pred1=rnorm(30), 
                             pred2=as.factor(sample(c(1,2), 
                                             replace=TRUE, 
                                             size=30)))

#decorrelate x. Remember to decorrelate test data in the same way, before making predictions.
foo <- superpc.decorrelate(x, competing.predictors)
xnew <- t(foo$res)

#now use xnew in superpc
data <- list(x=xnew, 
             y=y, 
             censoring.status=censoring.status, 
             featurenames=featurenames)
a <- superpc.train(data, type="survival")

#etc. 
}

\keyword{regression}
\keyword{survival}

