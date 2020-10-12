\name{superpc.plotcv}

\alias{superpc.plotcv}

\title{
    Plot output from superpc.cv
}

\description{
    Plots pre-validation results from plotcv, to aid in choosing best threshold
}
\usage{
    superpc.plotcv(object, 
                   cv.type=c("full","preval"),
                   smooth=TRUE, 
                   smooth.df=10, 
                   call.win.metafile=FALSE, ...)
}

\arguments{
    \item{object}{Object returned by superpc.cv.}
    \item{cv.type}{Type of cross-validation used - 
                   "full" (Default; this is "standard" cross-validation; recommended) and "preval"- pre-validation.}
    \item{smooth}{ Should plot be smoothed?  Only relevant to "preval". Default FALSE.}
    \item{smooth.df}{Degrees of freedom for smooth.spline, default 10.
                     If NULL, then degrees of freedom is estimated by cross-validation.}
    \item{call.win.metafile}{Ignore: for use by PAM Excel program.}
    \item{\dots}{Additional plotting args to be passed to matplot.}
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
censoring.status <- sample(c(rep(1,20), rep(0,10)))

featurenames <- paste("feature", as.character(1:50), sep="")
data <- list(x=x, 
             y=y, 
             censoring.status=censoring.status, 
             featurenames=featurenames)

a <- superpc.train(data, type="survival")
aa <- superpc.cv(a,data)

superpc.plotcv(aa)
}
}

\keyword{regression}
\keyword{survival}
