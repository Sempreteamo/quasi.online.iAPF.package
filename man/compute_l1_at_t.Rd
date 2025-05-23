% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_l1_at_t.R
\name{compute_l1_at_t}
\alias{compute_l1_at_t}
\title{Function to calculate the marginal smoothing L1-error between particles}
\usage{
compute_l1_at_t(data, smooth_particles, time)
}
\arguments{
\item{data}{Observations}

\item{time}{Time t that people want to calculate L1-error at}

\item{smooth_particle}{Smoothed particle generated by particle filters}
}
\value{
L1-error between particles at time t
}
\description{
Function to calculate the marginal smoothing L1-error between particles
}
