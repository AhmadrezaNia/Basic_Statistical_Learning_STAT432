#install.packages("glmnet", repos = "https://cran.us.r-project.org")
library(glmnet)

#help(matrix)  # To see the documentation of R function
library(MASS) # for the matrix() function

X <-matrix(rnorm(12*14) , nrow = 12, ncol = 14) # generate gaussian random matrix
b <- c(0,0,0,2,0,0,0,-1,0,0,0,1,0,0)
dim(b) <- c(14,1)
Y <- X %*% b + 0.001*matrix(rnorm(12*1) , nrow = 12, ncol = 1) # gaussian random vector
mod_cv <- cv.glmnet(X, Y, alpha=1) # alpha=1 means lasso (alpha=0 is ridge regression)
# cv.glmnet performs cross-validation
model.lasso <- glmnet(X,Y,lambda = mod_cv$lambda.min, alpha=1)
#use the best lambda selected by cross validation`
blasso <- model.lasso$beta # fitted values using lasso
print(blasso) # print results

model.lasso <- glmnet(X,Y, alpha=1,standardize=FALSE, intercept=FALSE)
plot(model.lasso) # plot the entire path
#standardize=TRUE normalizes the columns of X to be zero mean and unit variance, which is default
#intercept=TRUE is default. Note that model.lasso$beta only contains the coefficients for non-intercept variables. To show the coefficient for the intercept also, use coeff(model.lasso)


