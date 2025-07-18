#' Function to calculate the marginal smoothing L1-error between particles
#'
#'
#' @param H_list Information generated by the particle filter algorithm
#'
#' @return smoothed particles
#' @export
#'
compute_backward_smoothing <- function(H_list) {
  T   <- length(H_list) - 1
  N   <- nrow(H_list[[1]]$X)
  d   <- ncol(H_list[[1]]$X)
  #

  idx_path <- matrix(NA_integer_, nrow = N, ncol = T)
  #
  final_w <- exp(H_list[[T+1]]$logW)
  idx_path[, T] <- sample(seq_len(N), size = N, replace = TRUE, prob = final_w)

  #
  for (t in T:2) {
    anc_t1 <- H_list[[t+1]]$anc
    idx_path[, t-1] <- anc_t1[idx_path[, t]]
  }

  #
  smooth_particles <- array(NA_real_, dim = c(N, T, d))
  for (t in 1:T) {
    smooth_particles[, t, ] <- H_list[[t+1]]$X[idx_path[, t], , drop = FALSE]
  }


  return(smooth_particles)
}
#' @import stats

