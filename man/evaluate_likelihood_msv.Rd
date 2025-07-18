% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_likelihood_msv.R
\name{evaluate_likelihood_msv}
\alias{evaluate_likelihood_msv}
\title{Function to evaluate the log-likelihood of the observations for multivariate svm models}
\usage{
evaluate_likelihood_msv(x, y_t, obs_params)
}
\arguments{
\item{x}{State at which to evaluate}

\item{obs_params}{List containing parameters information of observation density}

\item{datum}{Data point at which to evaluate}
}
\value{
Log-density of the observation density
}
\description{
This function evaluates the log-likelihood of the observations for stochastic volatility obs_paramss.
It is expected to be updated to evaluate log-density of general potential functions.
}
