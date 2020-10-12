\name{superpc.fit.to.outcome}

\alias{superpc.fit.to.outcome}

\title{
    Fit predictive model using outcome of supervised principal components
}

\description{
    Fit predictive model using outcome of supervised principal components, 
    via either coxph (for surival data) or lm (for regression data)
}

\usage{
    superpc.fit.to.outcome(fit, 
                           data.test, 
                           score, 
                           competing.predictors=NULL, 
                           print=TRUE, 
                           iter.max=5)
}

\arguments{
    \item{fit}{Object returned by superpc.train.}
    \item{data.test}{Data object for prediction. Same form as data object documented in superpc.train.}  
    \item{score}{Supervised principal component score, from superpc.predict.}
    \item{competing.predictors}{Optional - a list of competing predictors to be included in the model.}
    \item{print}{Should a summary of the fit be printed? Default TRUE.}
    \item{iter.max}{Max number of iterations used in predictive model fit. Default 5. Currently only relevant for Cox PH model.}
}

\value{
    Returns summary of coxph or lm fit.
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
fit <- superpc.predict(a, 
                       data, 
                       data.test, 
                       threshold=1.0, 
                       n.components=1, 
                       prediction.type="continuous")
superpc.fit.to.outcome(a, 
                       data, 
                       fit$v.pred)
}

\keyword{regression}
\keyword{survival}

