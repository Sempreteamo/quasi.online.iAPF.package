#' @examples
#' \dontrun{
#' The following parameters are provided by users
#' library(mvnfast)
#' library(FKF)
#' Napf = N = 100
#' lag = 5
#' Time = 10
#' d_ = 1
#'
#' alpha = 0.42
#' tran_m <- matrix(nrow = d_, ncol = d_)
#' for (i in 1:d_){
#'   for (j in 1:d_){
#'       tran_m[i,j] = alpha^(abs(i-j) + 1)
#'   }
#' }
#' ini <- rep(0, d_)
#'
#' ini_c = tran_c = obs_m = obs_c = diag(1, nrow = d_, ncol = d_)
#' parameters_ <- list(k = 5, tau = 0.5, kappa = 0.5)
#' obs_p <- list(obs_mean = obs_m, obs_cov = obs_c)
#'
#' #output <- generate_blocks(lag, Time)
#' output <- generate_blocks_half(lag, Time)
#' breaks_ <- output[[1]]
#' psi_index_ <- output[[2]]
#'
#' model <- list(ini_mu = ini, ini_cov = ini_c, tran_mu = tran_m, tran_cov = tran_c, obs_params = obs_p,
#'  eval_likelihood = evaluate_likelihood_lg, simu_observation = simulate_observation_lg,
#'  parameters = parameters_, dist = 'lg')
#'
#' obs_ <- sample_obs(model, Time, d_) #provided by users
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
#'data_ =  data <- list(obs = obs_, breaks = breaks_, 
#' psi_index = psi_index_)
#'
#' kalman <- list(fkf.obj = filtering, fks.obj  = smoothing ) #provided by users
#'
#' log_ratio <- vector()
#' log_ratio_apf <- vector()
#' avg <- matrix(nrow = 1, ncol = Time)
#'
#'start_time <- Sys.time()
#'for(i in 1:50){
#' set.seed(i*2)
#' output_apf <- run_bpf(model, data, lag, Napf)
#' logZ <- output_apf[[3]]
#' log_ratio_apf[i] <- compute_log_ratio(logZ, filtering)
#' print(log_ratio_apf[i] )
#'}
#' end_time <- Sys.time()
#' bpf_time <- end_time - start_time
#'
#'start_time <- Sys.time()
#'for(i in 1:1){
#'set.seed(i+2)
#' #run the algorithm
#' output <- run_quasi_online_pf(model, data, Napf, N)
#'
#' X<- output[[1]]
#' w<- output[[2]]
#' logZ <- output[[3]]
#' psi_final <- output[[4]]
#' X_apf <- output[[5]]
#' w_apf <- output[[6]]
#' ancestors <- output[[7]]
#'
#' log_ratio[i] <- compute_log_ratio(logZ, filtering)
#' print(log_ratio[i] )
#' dist <- compute_dKS(X, w, smoothing)
#'
#' for (t in 1:Time){
#' avg[, t] <- length(unique(X[t,,,drop = FALSE]))/d_
#' }
#' 
#' plot(x = c(1:Time), y = avg[1,])
#' }
#' end_time <- Sys.time()
#' iapf_time <- end_time - start_time
#' 
#' specific_time = 105
#' 
#' #update observations:
#' 
#' if(nrow(obs_) < specific_time){
#' data$obs <- rbind(obs_, sample_obs(model, specific_time - nrow(obs_), d_)) 
#' }
#' 
#' output <- generate_blocks(lag, specific_time)
#' data$breaks <- output[[1]]
#' #data$psi_index <- output[[2]]
#' 
#' previous_info <- list(previous_time = 100, 
#' X_pre = X_apf, w_pre = w_apf, psi_final = psi_final, X = X, w = w)
#' output1 <- run_quasi_online_pf(model, data, Napf, N, previous_info)
#' logZ <- output1[[3]]
#' 
#' filter_t <- compute_fkf_filtering(params, data$obs)
#' filtering_t <- filter_t[[1]]
#' log_ratio_t <- compute_log_ratio(logZ, filtering_t)
#' }

