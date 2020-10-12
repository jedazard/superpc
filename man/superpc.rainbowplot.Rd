\name{superpc.rainbowplot}

\alias{superpc.rainbowplot}

\title{
    Make rainbow plot of superpc and compeiting predictors
}

\description{
    Makes a heatmap display of outcome predictions from superpc, 
    along with expected survival time, and  values of competing predictors.
}

\usage{
    superpc.rainbowplot(data, 
                        pred, 
                        sample.labels,
                        competing.predictors,
                        call.win.metafile=FALSE)
}

\arguments{
    \item{data}{ List of (test) data, of form described in superpc.train documentation}
    \item{pred}{Superpc score from superpc.predict or  superpc.predict.red}
    \item{sample.labels}{Vector of sample labels of test data}
    \item{competing.predictors}{List of competing predictors to be plotted}
    \item{call.win.metafile}{Used only by Excel interface call to function}
}

\details{
    Any censored survival times are estimated by E(T|T > C), where $C$ is the observed censoring time 
    and the Kaplan-Meier estimate from the training set is used to estimate the expectation.
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
competing.predictors.test <- list(pred1=rnorm(30), 
                                  pred2=as.factor(sample(c(1,2),
                                                  replace=TRUE,
                                                  size=30)))
                                                  
data <- list(x=x, 
             y=y, 
             censoring.status=censoring.status, 
             featurenames=featurenames)
data.test <- list(x=x, 
                  y=ytest, 
                  censoring.status=censoring.status.test, 
                  featurenames=featurenames)
sample.labels <- paste("te", as.character(1:20), sep="")

a <- superpc.train(data, type="survival")
pred <- superpc.predict(a, 
                        data, 
                        data.test, 
                        threshold=.25, 
                        n.components=1)$v.pred
superpc.rainbowplot(data, 
                    pred, 
                    sample.labels, 
                    competing.predictors=competing.predictors.test)
}

\keyword{regression}
\keyword{survival}
