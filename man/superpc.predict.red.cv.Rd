\name{superpc.predict.red.cv}

\alias{superpc.predict.red.cv}

\title{
    Cross-validation of feature selection for supervised principal components
}

\description{
    Applies superpc.predict.red to cross-validation folds generates in superpc.cv.
    Uses the output to evaluate reduced models, and compare them to the
    full supervised principal components predictor.
}

\usage{
    superpc.predict.red.cv(fitred, 
                           fitcv, 
                           data, 
                           threshold, 
                           sign.wt="both")
}

\arguments{
    \item{fitred}{ Output of superpc.predict.red}
    \item{fitcv}{ Output of superpc.cv }
    \item{data}{ Training data object }
    \item{threshold}{Feature score threshold; usually estimated from superpc.cv}
    \item{sign.wt}{Signs of feature weights allowed: "both", "pos", or "neg"}
}

\value{
    \item{lrtest.reduced}{ Likelihood ratio tests for reduced models }
    \item{components }{Number of supervised  principal components used}
    \item{v.preval.red}{Outcome predictor from reduced models.
                        Array of num.reduced.models by (number of test observations)}
    \item{type }{Type of outcome}
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
    Maintainer: "Jean-Eudes Dazard, Ph.D."
}

\examples{
\dontrun{
set.seed(332)

#generate some data
x <- matrix(rnorm(50*20), ncol=20)
y <- 10 + svd(x[1:10,])$v[,1] + .1*rnorm(20)
ytest <- 10 + svd(x[1:10,])$v[,1] + .1*rnorm(20)
censoring.status <- sample(c(rep(1,15), rep(0,5)))
censoring.status.test <- sample(c(rep(1,15), rep(0,5)))

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
aa <- superpc.cv(a, data)
fit.red <- superpc.predict.red(a,
                               data, 
                               data.test, 
                               threshold=.6)
fit.redcv <- superpc.predict.red.cv(fit.red, 
                                    aa, 
                                    data, 
                                    threshold=.6)
}
}

\keyword{regression}
\keyword{survival}
