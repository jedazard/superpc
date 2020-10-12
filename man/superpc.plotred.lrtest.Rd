\name{superpc.plotred.lrtest}

\alias{superpc.plotred.lrtest}

\title{
    Plot likelihood ratio test statistics from supervised principal components predictor
}

\description{
    Plot likelihood ratio test statistics from supervised principal components predictor
}

\usage{
    superpc.plotred.lrtest(object.lrtestred, 
                           call.win.metafile=FALSE)
}

\arguments{
    \item{object.lrtestred}{Output from either superpc.predict.red or superpc.predict.redcv}
    \item{call.win.metafile}{Used only by PAM Excel interface call to function}
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
\dontrun{
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
aa <- superpc.cv(a, data)
fit.red <- superpc.predict.red(a, 
                               data, 
                               data.test, 
                               .6)
fit.redcv <- superpc.predict.red.cv(fit.red, 
                                    aa, 
                                    data, 
                                    .6)
superpc.plotred.lrtest(fit.redcv)
}
}

\keyword{regression}
\keyword{survival}
