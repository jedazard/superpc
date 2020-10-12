\name{superpc.cv}

\alias{superpc.cv}

\title{
    Cross-validation for supervised principal components
}

\description{
    This function uses a form of cross-validation to estimate 
    the optimal feature threshold in supervised principal components
}
\usage{
    superpc.cv(fit,
               data, 
               n.threshold=20,
               n.fold=NULL,
               folds=NULL,
               n.components=3, 
               min.features=5, 
               max.features=nrow(data$x),
               compute.fullcv= TRUE,
               compute.preval=TRUE, 
               xl.mode=c("regular","firsttime","onetime","lasttime"), 
               xl.time=NULL,
               xl.prevfit=NULL)
}

\arguments{
    \item{fit}{ Object returned by superpc.train }
    \item{data}{ Data object of form described in superpc.train documentation }
    \item{n.threshold}{Number of thresholds to consider. Default 20.}
    \item{n.fold}{ Number of cross-validation folds. default is around 10 
                  (program pick a convenient value based on the sample size }
    \item{folds}{List of indices  of cross-validation folds (optional)   }
    \item{n.components}{ Number of cross-validation components to use: 1,2 or 3. }
    \item{min.features}{ Minimum number of features to include 
                         in determining range for threshold. 
                         Default 5.}
    \item{max.features}{ Maximum number of features to include 
                         in determining range for threshold.
                         Default is total number of features in the dataset  }
    \item{compute.fullcv}{ Should full cross-validation  be done? }
    \item{compute.preval}{ Should full pre-validation  be done? }
    \item{xl.mode}{Used by Excel interface only}
    \item{xl.time}{Used by Excel interface only}
    \item{xl.prevfit}{Used by Excel interface only}
}

\details{
    This function uses a form of cross-validation to estimate the optimal feature threshold in supervised principal components. 
    To avoid prolems with fitting Cox models to samll validation datastes, 
    it uses the "pre-validation" approach of Tibshirani and Efron (2002)
}

\value{
    \item{threshold}{Vector of thresholds considered}
    \item{nonzero}{Number of features exceeding each value of the threshold}
    \item{scor.preval}{Likelihood ratio scores from pre-validation}
    \item{scor}{Full CV scores}
    \item{folds}{Indices of CV folds used}
    \item{featurescores.folds}{Feature scores for each fold}
    \item{v.preval}{The pre-validated predictors}
    \item{type}{problem type}
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
aa <- superpc.cv(a, data)
}
}

\keyword{regression}
\keyword{survival}
