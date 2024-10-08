#' Function to generate blocks that the iAPF runs within
#'
#' @param lag Lag of the blocks user specified
#' @param len Length of the time scale
#'
#' @return A list with two elements:
#' breaks is the break points on the time scale that the iAPF starts to iterate
#' psi_index indicates at each time point, the outputs generated by which iAFP layer the algorithm chooses
#'
#' @export
#'
generate_blocks <- function(lag, len){
  num_blocks <- ceiling(len / lag)

  psi_index <- numeric(len)

  breaks <- list()

  breaks[[1]] <- seq(1, len, by = lag)
  breaks[[2]] <- c(1, seq(lag/2 + 1, len, by = lag))

  if (utils::tail( breaks[[1]], 1) != len) {
    breaks[[1]] <- c(breaks[[1]], len + 1)
  }

  if (utils::tail(breaks[[2]], 1) != len) {
    breaks[[2]] <- c(breaks[[2]], len + 1)
  }

  for (i in 1:num_blocks) {

    start_time <- (i - 1) * lag + 1
    end_time <- min(i * lag, len)

    if (i == 1) {
      start_time <- start_time
      end_time <- floor((3/4) * lag)
    }
    else {
      start_time <- start_time + floor((1/4) * lag)
      end_time <- end_time - floor((1/4) * lag)
    }

    psi_index[start_time:end_time] <- 1
  }

  psi_index[psi_index == 0] <- 2

  return(list(breaks, psi_index))
}
#' @import utils
