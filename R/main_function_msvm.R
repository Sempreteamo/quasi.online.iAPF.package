#' @examples
#' \dontrun{
#' The following parameters are provided by users
#' library(mvnfast)
#' library(FKF)
#' Napf = N = 200
#' lag = 10
#' Time = 200
#' d_ = 2
#'
#'
#' ini <- rep(0.1, d_)
#' ini_c = obs_c = diag(0.2,d_)
#' tran_m = diag(0.95, d_)
#' tran_c = diag(0.2, d_)
#' obs_c <- diag(1, d_)
#'
#'
#' parameters_ <- list(k = 5, tau = 0.5, kappa = 0.5)
#'
#'
#' obs_p <- list(obs_mean = rep(0, d_), obs_cov = obs_c)
#'
#'
#' model <- list(ini_mu = ini, ini_cov = ini_c, tran_mu = tran_m, tran_cov = tran_c, obs_params = obs_p,
#'  eval_likelihood = evaluate_likelihood_msvm, simu_observation = simulate_observation_msvm,
#'  parameters = parameters_, dist = 'lg')
#'
#' obs_ <- sample_obs(model, Time, d_) #provided by users
#' #obs_ <- 100*as.matrix(read.csv('data.csv')[1][1:944,])
#'
#' output <- generate_blocks(lag, nrow(obs_))  #might not consistent with 1d
#' breaks_ <- output[[1]]
#' psi_index_ <- output[[2]]
#'
#' dt_ <- ct_ <- matrix(0, d_, 1)
#' Tt_ <- as.matrix(tran_m)
#' P0_ <- Zt_ <- Ht_ <- Gt_ <- diag(1, d_, d_)
#' a0_ <- rep(0, d_)
#' params <- list(dt = dt_, ct = ct_, Tt = Tt_, P0 = P0_, Zt = Zt_,
#'                Ht = Ht_, Gt = Gt_, a0 = a0_, d = d_)
#'
#' filter <- compute_fkf_filtering(params, obs_)
#' filtering <- filter[[1]]
#' smoothing <- filter[[2]]
#'
#' data <- list(obs = obs_, breaks = breaks_, psi_index = psi_index_)
#'
#' kalman <- list(fkf.obj = filtering, fks.obj  = smoothing ) #provided by users
#'
#'log_ratio <- vector()
#'logZ <- vector()
#'
#'for(i in 1:7){
#'set.seed(i*2)
#' #run the algorithm
#' output <- run_quasi_online_pf(model, data, lag, Napf, N)
#' #output <- run_bpf(model, data, lag, Napf)
#' X<- output[[1]]
#' w<- output[[2]]
#' logZ[i] <- output[[3]]
#' #avg <- output[[5]]
#'
#' #log_ratio[i] <- compute_log_ratio(logZ, filtering)
#' print(logZ[i])
#' #dist <- compute_dKS(X, w, smoothing)
#'
#' #plot(x = c(1:Time), y = avg[1,])
#' }
#' }

