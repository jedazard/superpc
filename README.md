# Superpc
Supervised Principal Components for regression and survival analysis. 


===============
### Description

Does prediction in the case of a censored survival outcome, or a regression outcome, using the "supervised principal component" approach (Bair et al., 2006).
Superpc is especially useful for high-dimensional data when the number of features _p_ dominates the number of samples _n_ (_p_ >> _n_ paradigm), 
as generated, for instance, by high-throughput technologies.


===============
### Details

Supervised principal components is a generalization of principal components regression. The first (or first few) principal 
components are the linear combinations of the features that capture the directions of largest variation in a dataset. 
But these directions may or may not be related to an outcome variable of interest. To find linear combinations that are related 
to an outcome variable, we compute univariate scores for each gene and then retain only those features whose score exceeds a threshold. 
A principal components analysis is carried out using only the data from these selected features. 
Finally, these "supervised principal components" are used in a regression model to predict the outcome. 
To summarize, the steps are:

   + Compute (univariate) standard regression coefficients for each feature
   + Form a reduced data matrix consisting of only those features whose univariate coefficient exceeds a threshold theta 
      in absolute value (theta is estimated by cross-validation)
   + Compute the first (or first few) principal components of the reduced data matrix
   + Use these principal component(s) in a regression model to predict the outcome

This idea can be used in standard regression problems with a quantitative outcome, and also in generalized regression problems 
such as survival analysis. In the latter problem, the regression coefficients in step (1) are obtained from a proportional hazards model. 
The superpc R package handles these two cases: standard regression and survival data.

There is one more important point: the features (e.g genes) which important in the prediction are not necessarily the ones 
that passed the screen in step 2. There are other features that may have as high a correlation with the supervised PC predictor. 
So we compute an importance score for each feature equal to its correlation with the supervised PC predictor. 
A reduced predictor is formed by soft-thresholding the importance scores, and using these shrunken scores as weights. 
The soft-thresholding sets the weight of some features to zero, hence throwing them out of the model. The amount of shrinkage 
is determined by cross-validation. The reduced predictor often performs as well or better than than the supervised PC predictor, 
and is more interpretable.


============
### Branches

This branch (master) is the  default one, that hosts the current development release (version 1.10).

===========
### License

Package superpc is open source / free software, licensed under the GNU General Public License version 3 (GPLv3), 
sponsored by the [Free Software Foundation](https://www.fsf.org/). To view a copy of this license, visit 
[GNU Free Documentation License](https://www.gnu.org/licenses/gpl-3.0.html).


=============
### Downloads

CRAN downloads since initial release to CRAN (2004-09-16):
[![](https://cranlogs.r-pkg.org/badges/grand-total/superpc)](https://CRAN.R-project.org/package=superpc)
as tracked by [RStudio CRAN mirror](http://cran-logs.rstudio.com/)

CRAN downloads in the last month:
[![](https://cranlogs.r-pkg.org/badges/last-month/superpc)](https://CRAN.R-project.org/package=superpc)

CRAN downloads in the last week:
[![](https://cranlogs.r-pkg.org/badges/last-week/superpc)](https://CRAN.R-project.org/package=superpc)


================
### Requirements

superpc (>= 1.10) requires R-3.5.0 (2018-04-23). It was built and tested under R version 4.0.3 (2020-10-10) and Travis CI. 

Installation has been tested on Windows, Linux, OSX and Solaris platforms. 

See Travis CI build result:
[![Build Status](https://travis-ci.com/jedazard/superpc.svg)](https://travis-ci.com/jedazard/superpc)

See CRAN checks:
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/superpc)](https://cran.r-project.org/web/checks/check_results_superpc.html)


================
### Installation

* To install the stable version of `superpc`, simply download and install the current version 1.10) from the [CRAN](https://CRAN.R-project.org/package=superpc) 
repository:

```{r}
install.packages("superpc")
```

* Alternatively, you can install the most up-to-date development version (>= 1.10) of `superpc` from the [GitHub](https://github.com/jedazard/superpc) repository, 
simply run the following using devtools:

```{r}
install.packages("devtools")
library("devtools")
devtools::install_github("jedazard/superpc")
```

=========
### Usage

* To load the superpc library in an R session and start using it:

```{r}
library("superpc")
```

* Check details of new features, changes, and bug fixes with the following R command:

```{r}
superpc.news()
```

* Check on how to cite the package with the R command:

```{r}
citation("superpc")
```

etc...


==================
### Website - Wiki

- See Rob Tibshirani's [Website](http://www-stat.stanford.edu/~tibs/superpc) for more details, and a tutorial with examples and interpretation.


===================
### Acknowledgments

Authors: 
   + Eric Bair, Ph.D. <ebair@email.unc.edu>
   + Trevor Hastie, Ph.D. <hastie@stanford.edu>
   + Debashis Paul, Ph.D. <debpaul@ucdavis.edu>
   + Robert Tibshirani, Ph.D. <tibs@stanford.edu>

Maintainers: 
   + Jean-Eudes Dazard, Ph.D. <jean-eudes.dazard@case.edu>

Funding/Provision/Help:   
   + This work made use of the High Performance Computing Resource in the Core Facility for 
     Advanced Research Computing at Case Western Reserve University. 
   + Eric Bair was supported by an NSF graduate research fellowship. 
     Robert Tibshirani was partially supported by National Science Foundation Grant DMS-9971405 
     and National Institutes of Health Contract N01-HV-28183. Hastie was supported in part by
     National Science Foundation grant DMS-02-04612 and National Institutes of Health grant R01 CA 72028-07.


==============
### References

   + Bair E. and Tibshirani R.
     *Semi-supervised methods to predict patient survival from gene expression data*. 
     [PLoS Biol (2004), 2(4):e108](https://journals.plos.org/plosbiology/article/authors?id=10.1371/journal.pbio.0020108).

   + Bair E., Hastie T., Paul D., and Tibshirani R.
     *Prediction by supervised principal components*. 
     [J. Am. Stat. Assoc (2006), 101(473):119-137](https://www.tandfonline.com/doi/abs/10.1198/016214505000000628).
