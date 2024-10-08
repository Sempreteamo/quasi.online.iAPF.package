% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimize_psi.R
\name{optimize_psi}
\alias{optimize_psi}
\title{Function to optimize the Gaussian twisting function parameters}
\usage{
optimize_psi(x, lfn)
}
\arguments{
\item{x}{Locations}

\item{lfn}{Log function value}
}
\value{
Twisting function parameters
}
\description{
This function takes a collection of particle locations and the associated value of the log target
function evaluated at those points and fits a Gaussian twisting function via the controlled SMC approach.
}
