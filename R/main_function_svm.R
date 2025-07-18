#' @examples
#' \dontrun{
#' The following parameters are provided by users
#' library(mvnfast)
#' library(FKF)
#' Napf = N = 200
#' lag = 4
#' Time = 944
#' d_ = 1
#'
#' alpha = 0.986
#' beta = 0.69
#' theta = 0.13
#'
#' ini = obs_m = rep(0, d_)
#' ini_c <- theta^2/(1 - alpha^2)
#' tran_m = alpha
#' tran_c = theta^2
#'
#' parameters_ <- list(k = 7, tau = 0.5, kappa = 0.5)
#'
#
#' obs_p <- list(obs_mean = obs_m, obs_cov = beta^2)
#'
#'
#' model <- list(ini_mu = ini, ini_cov = ini_c, tran_mu = tran_m, tran_cov = tran_c, obs_params = obs_p,
#'  eval_likelihood = evaluate_likelihood_svm, simu_observation = simulate_observation_svm,
#'  parameters = parameters_, dist = 'lg')
#'
#' #obs_ <- sample_obs(model, Time, d_) #provided by users
#' obs_ <- 100*as.matrix(read.csv('R/data.csv', header = FALSE))
#'
#' #output <- generate_blocks_half(lag, length(obs_))
#' #breaks_ <- output[[1]]
#' #psi_index_ <- output[[2]]
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
#' data <- list(obs = obs_)
#'
#' kalman <- list(fkf.obj = filtering, fks.obj  = smoothing ) #provided by users
#'log_ratio <- vector()
#' log_ratio_rolling <- vector()
#' log_ratio_iapf <- vector()
#' log_ratio_apf <- vector()
#' avg <- matrix(nrow = 1, ncol = Time)
#' filtering_estimates <- 0
#'
#' num_runs <- 1
#' logZ_matrix_rolling_svm <- matrix(NA, nrow = num_runs, ncol = Time)
#'
#' for(i in 1:num_runs){
#' set.seed(i*2)
#' output <- Orc_SMC(lag, data, model, N)
#' logZ_matrix_rolling_svm[i, ] <- output$logZ
#' filtering_estimates <- output$f_means
#' log_ratio_rolling[i] <- compute_log_ratio(logZ_matrix_rolling_svm[i,Time], filtering)
#' print(log_ratio_rolling[i] )
#' }
#'
#'
#'log_ratio <- vector()
#'logZ <- vector()
#'avg <- matrix(nrow = 1, ncol = Time)
#'for(i in 1:1){
#'set.seed(i^2)
#'#run the algorithm
#' output <- run_quasi_online_pf(model, data, Napf, N)
#'
#' X<- output[[1]]
#' w<- output[[2]]
#' logZ[i] <- output[[3]]
#' psi_final <- output[[4]]
#' X_apf <- output[[5]]
#' w_apf <- output[[6]]
#'
#' print(logZ[i])
#' #dist <- compute_dKS(X, w, smoothing)
#'for (t in 1:Time){
#' avg[, t] <- length(unique(X[t,,,drop = FALSE]))/d_
#' }
#' plot(x = c(1:Time), y = avg[1,])
#' }
#' }


