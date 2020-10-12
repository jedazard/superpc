\name{superpc.predict}

\alias{superpc.predict}

\title{
    Form principal components predictor from a trained superpc object
}

\description{
    Computes supervised principal components, using scores from "object"
}

\usage{
    superpc.predict(object, 
                    data, 
                    newdata, 
                    threshold, 
                    n.components=3, 
                    prediction.type=c("continuous","discrete","nonzero"), 
                    n.class=2)
}

\arguments{
    \item{object}{ Obect returned by superpc.train }
    \item{data}{ List of training data, of form described in superpc.train documentation, }
    \item{newdata}{ List of test data; same form as training data }
    \item{threshold}{ Threshold for scores: features with abs(score) > threshold are retained. }
    \item{n.components}{ Number of principal components to compute. Should be 1,2 or 3. }
    \item{prediction.type}{ "continuous" for raw principal component(s);
                            "discrete" for principal component categorized in equal bins;
                            "nonzero" for indices of features that pass the threshold }
    \item{n.class}{ Number of classes into which predictor is binned (for prediction.type="discrete" }
}

\value{
    \item{v.pred}{Supervised principal componients predictor}
    \item{u}{U matrix from svd of feature matrix x}
    \item{d}{singual values  from svd of feature matrix x}
    \item{which.features}{Indices of features exceeding threshold}
    \item{n.components}{Number of supervised  principal components requested}
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
fit <- superpc.predict(a, 
                       data, 
                       data.test, 
                       threshold=1.0, 
                       n.components=1)
plot(fit$v.pred, ytest)
}

\keyword{regression}
\keyword{survival}
