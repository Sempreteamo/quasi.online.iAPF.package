#' Function to calculate the marginal smoothing L1-error between particles
#'
#'
#' @param data Observations
#' @param smooth_particle Smoothed particle generated by particle filters
#' @param time Time t that people want to calculate L1-error at
#'
#' @return L1-error between particles at time t
#' @export
#'
compute_l1_at_t <- function(data, smooth_particles, time) {
  L1_time <- numeric(length(time))
  i = 1
  d <- ncol(data$obs)
  Time <- nrow(data$obs)

  for(t in time){
    sum = 0
    for(j in 1:d){

      mu_true    <- smooth_means[t, j]
      theta2_true   <- smooth_covs[j, j, t]
      xs        <- seq(mu_true - 4*sqrt(theta2_true),
                       mu_true + 4*sqrt(theta2_true),
                       length.out = 200)
      #cdf of the real kalman distribution
      cdf_true <- pnorm(xs, mean = mu_true, sd = sqrt(theta2_true))

      #empirical cdf
      particles_k <- smooth_particles[, t, j]
      cdf_emp <- sapply(xs, function(x) mean(particles_k <= x))

      #L1 distance between cdfs
      dx <- xs[2] - xs[1]
      l1_k <- sum(abs(cdf_emp - cdf_true)) * dx

      sum = sum + l1_k
    }

    L1_time[i] <- sum/d
    i = i + 1
  }

  return(L1_time)
}
#' @import stats
