#training set (n = 387)
rm(list=ls())
library(readxl)
library(glmnet)
library(writexl) 
set.seed(1)
patients <- read_excel("C:/Users/Bing-Hua Chen/Desktop/RJ387internal training.xlsx") #仁济
View(patients)
patients <- as.data.frame(patients)


train_x <-patients[,3:8]


train_x <-as.data.frame(scale(train_x))
train_label <-patients[,2]

#处理缺失值
has_na <- any(is.na(train_x))
if (has_na) {
  train_x[is.na(train_x)] <- 0
}

###LASSO
cv_x <- as.matrix(train_x)
cv_y <- train_label
fit <- cv.glmnet(x = cv_x, y = cv_y, family = "binomial", type.measure = "deviance", 
                 alpha = 1,
                 nfolds =10)
?glmnet

# 提取lambda.min
lambda_min <- fit$lambda.min

# 计算log(lambda.min)
log_lambda_min <- log(lambda_min)

# 打印结果
cat("lambda.min:", lambda_min, "\n")
cat("log(lambda.min):", log_lambda_min, "\n")

# 可以绘制lambda值与交叉验证误差的关系图
plot(fit)


plot(x= fit, las= 1, xlab = "log(lambda)")
nocv_lasso <- glmnet(x = cv_x, y = cv_y, family = "binomial",alpha = 1)
plot(nocv_lasso, xvar = "lambda", las=1, lwd=2, xlab="log(lambda)")
abline(v = log(fit$lambda.min),lwd=1, lty=5, col= "red")
coefPara <- coef(object = fit, s= "lambda.min")
lasso_values <- as.data.frame(which(coefPara != 0,arr.ind = T))
lasso_values 
lasso_names <- rownames(lasso_values)[-1]
lasso_names
lasso_coef <- data.frame(Feature = rownames(lasso_values),
                         coef = coefPara[which(coefPara !=0,arr.ind = T)])
lasso_coef

train_set_lasso <- train_x[lasso_names] 
train_all=as.matrix(train_set_lasso)
xn = nrow(train_set_lasso)
yn = ncol(train_set_lasso)
beta = as.matrix(coefPara[which(coefPara !=0),])

beta
betai_Matrix = as.matrix(beta[-1])
beta0_Matrix = matrix(beta[1],xn,1)
Radcore_Matrix = train_all %*%betai_Matrix +beta0_Matrix
Radscore_train = as.numeric(Radcore_Matrix)
Radscore=as.data.frame(Radscore_train)
Radscore

Radscore=as.data.frame(Radscore_train)

# ========== 新增代码部分 ==========
# 将Radscore合并到原始数据
patients$Radscore <- Radscore$Radscore_train

# 定义新的文件名（避免覆盖原文件）
output_file <- "C:/Users/Bing-Hua Chen/Desktop/RJ387internal training_with_Radscore.xlsx"

# 保存到新文件（保留原文件） 
write_xlsx(patients, path = output_file)

# 如果确认需要覆盖原文件，可使用以下代码：
# write_xlsx(patients, path = "C:/Users/Bing-Hua Chen/Desktop/RJ387internal training.xlsx")

cat("Radscore已成功写入:", output_file, "\n")







#RJ166internal validation
rm(list=ls())
library(readxl)
library(glmnet)
library(writexl) 
set.seed(1)
patients <- read_excel("C:/Users/Bing-Hua Chen/Desktop/RJ166internal validation.xlsx") #仁济
View(patients)
patients <- as.data.frame(patients)


train_x <-patients[,3:8]


train_x <-as.data.frame(scale(train_x))
train_label <-patients[,2]

#处理缺失值
has_na <- any(is.na(train_x))
if (has_na) {
  train_x[is.na(train_x)] <- 0
}

###LASSO
cv_x <- as.matrix(train_x)
cv_y <- train_label
fit <- cv.glmnet(x = cv_x, y = cv_y, family = "binomial", type.measure = "deviance", 
                 alpha = 1,
                 nfolds =10)
?glmnet

# 提取lambda.min
lambda_min <- fit$lambda.min

# 计算log(lambda.min)
log_lambda_min <- log(lambda_min)

# 打印结果
cat("lambda.min:", lambda_min, "\n")
cat("log(lambda.min):", log_lambda_min, "\n")

# 可以绘制lambda值与交叉验证误差的关系图
plot(fit)


plot(x= fit, las= 1, xlab = "log(lambda)")
nocv_lasso <- glmnet(x = cv_x, y = cv_y, family = "binomial",alpha = 1)
plot(nocv_lasso, xvar = "lambda", las=1, lwd=2, xlab="log(lambda)")
abline(v = log(fit$lambda.min),lwd=1, lty=5, col= "red")
coefPara <- coef(object = fit, s= "lambda.min")
lasso_values <- as.data.frame(which(coefPara != 0,arr.ind = T))
lasso_values 
lasso_names <- rownames(lasso_values)[-1]
lasso_names
lasso_coef <- data.frame(Feature = rownames(lasso_values),
                         coef = coefPara[which(coefPara !=0,arr.ind = T)])
lasso_coef

train_set_lasso <- train_x[lasso_names] 
train_all=as.matrix(train_set_lasso)
xn = nrow(train_set_lasso)
yn = ncol(train_set_lasso)
beta = as.matrix(coefPara[which(coefPara !=0),])

beta
betai_Matrix = as.matrix(beta[-1])
beta0_Matrix = matrix(beta[1],xn,1)
Radcore_Matrix = train_all %*%betai_Matrix +beta0_Matrix
Radscore_train = as.numeric(Radcore_Matrix)
Radscore=as.data.frame(Radscore_train)
Radscore

Radscore=as.data.frame(Radscore_train)

# ========== 新增代码部分 ==========
# 将Radscore合并到原始数据
patients$Radscore <- Radscore$Radscore_train

# 定义新的文件名（避免覆盖原文件）
output_file <- "C:/Users/Bing-Hua Chen/Desktop/RJ166internal validation_with_Radscore.xlsx"

# 保存到新文件（保留原文件） 
write_xlsx(patients, path = output_file)

# 如果确认需要覆盖原文件，可使用以下代码：
# write_xlsx(patients, path = "C:/Users/Bing-Hua Chen/Desktop/RJ166internal validation.xlsx")

cat("Radscore已成功写入:", output_file, "\n")









#ComBat统计分析校正多中心多机器型号CMR的图像结果，即校正上面的6个参数重新计算Radscore2
rm(list=ls())
library(readxl)
library(glmnet)
set.seed(1)
patients <- read_excel("C:/Users/Bing-Hua Chen/Desktop/ComBatRJandAZAI.xlsx") #仁济和安贞
View(patients)
patients <- as.data.frame(patients)


train_x <-patients[,3:8]


train_x <-as.data.frame(scale(train_x))
train_label <-patients[,2]

#处理缺失值
has_na <- any(is.na(train_x))
if (has_na) {
  train_x[is.na(train_x)] <- 0
}

###LASSO
cv_x <- as.matrix(train_x)
cv_y <- train_label
fit <- cv.glmnet(x = cv_x, y = cv_y, family = "binomial", type.measure = "deviance", 
                 alpha = 1,
                 nfolds =10)
?glmnet

# 提取lambda.min
lambda_min <- fit$lambda.min

# 计算log(lambda.min)
log_lambda_min <- log(lambda_min)

# 打印结果
cat("lambda.min:", lambda_min, "\n")
cat("log(lambda.min):", log_lambda_min, "\n")

# 可以绘制lambda值与交叉验证误差的关系图
plot(fit)


plot(x= fit, las= 1, xlab = "log(lambda)")
nocv_lasso <- glmnet(x = cv_x, y = cv_y, family = "binomial",alpha = 1)
plot(nocv_lasso, xvar = "lambda", las=1, lwd=2, xlab="log(lambda)")
abline(v = log(fit$lambda.min),lwd=1, lty=5, col= "red")
coefPara <- coef(object = fit, s= "lambda.min")
lasso_values <- as.data.frame(which(coefPara != 0,arr.ind = T))
lasso_values 
lasso_names <- rownames(lasso_values)[-1]
lasso_names
lasso_coef <- data.frame(Feature = rownames(lasso_values),
                         coef = coefPara[which(coefPara !=0,arr.ind = T)])
lasso_coef

train_set_lasso <- train_x[lasso_names] 
train_all=as.matrix(train_set_lasso)
xn = nrow(train_set_lasso)
yn = ncol(train_set_lasso)
beta = as.matrix(coefPara[which(coefPara !=0),])
beta
betai_Matrix = as.matrix(beta[-1])
beta0_Matrix = matrix(beta[1],xn,1)
Radcore_Matrix = train_all %*%betai_Matrix +beta0_Matrix
Radscore_train = as.numeric(Radcore_Matrix)
Radscore=as.data.frame(Radscore_train)
Radscore

