% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/survival.R
\name{get_survival}
\alias{get_survival}
\alias{get_survival}
\alias{survival_fit}
\alias{get_survival}
\alias{calcSurvProb}
\title{Calculate survival object}
\usage{
get_survival(surv_data)

survival_fit(surv_obj, class = NULL)

calcSurvProb(fit, n_years = 5)
}
\arguments{
\item{surv_data}{tibble; Includes columns vitalStatus and FU, date of last
follow-up.}

\item{fit}{survfit; A survfit object.}

\item{n_years;}{numeric Years to examine survival.}
}
\value{
The survival fit.

The survival probability.
}
\description{
Calculate survival object

Calculate survival probability
}
\author{
Jason T. Serviss

Jason T. Serviss
}
