data{
  int<lower=0> k;
  int<lower=0> n;
  int<lower=0, upper=1> y[n];
  matrix[n,k] X;
}

parameters{
  real beta0;
  vector[k] beta;
  real loglambda;
}

transformed parameters  {
  real lambda;
  vector[n] p;
  vector[n] prob;
  lambda = exp(loglambda);
  for (i in 1:n) {
  p[i] = cauchy_cdf(beta0 + X[i]*beta,0,1);
  prob[i] = pow(p[i],lambda);
  }
}

model {
  beta0 ~ normal(0.0,100);
  beta ~ normal(0.0,100);
  loglambda ~ uniform(-2,2);
  y ~ bernoulli(prob);
}