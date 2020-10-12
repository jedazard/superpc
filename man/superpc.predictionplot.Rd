\name{superpc.predictionplot}

\alias{superpc.predictionplot}

\title{
    Plot outcome predictions from superpc
}

\description{
    Plots outcome predictions from superpc
}

\usage{
    superpc.predictionplot(train.obj, 
                           data, 
                           data.test,
                           threshold, 
                           n.components=3,
                           n.class=2, 
                           shrinkage=NULL, 
                           call.win.metafile=FALSE)
}

\arguments{
    \item{train.obj}{ Object returned by superpc.train }
    \item{data}{ List of training data, of form described in superpc.train documentation}
    \item{data.test}{ List of test data; same form as training data }
    \item{threshold}{ Threshold for scores: features with abs(score) > threshold are retained. }
    \item{n.components}{ Number of principal components to compute. Should be 1,2 or 3. }
    \item{n.class}{Number of classes for survival stratification. 
                   Only applicable for survival data. Default 2.}
    \item{shrinkage}{Shrinkage to be applied to feature loadings. Default is NULL, meaning no shrinkage}
    \item{call.win.metafile}{Used only by Excel interface call to function}
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
superpc.predictionplot(a, 
                       data, 
                       data.test, 
                       threshold=1)
}

\keyword{regression}
\keyword{survival}
