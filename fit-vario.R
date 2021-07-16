library(gstat)
library(readr)
#library(geoR)
#library(rstudioapi)
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
raw.vgm <- read_csv("raw.vgm.csv", col_names = FALSE)

raw.vgm <- read_csv("~/Dropbox/SAE/Oct 10/processed/ 333r1.csv", 
                    col_names = FALSE)

names(raw.vgm) <- c("np", "dist","gamma","dir.hor","dir.ver")
raw.vgm[] <- lapply(raw.vgm, as.numeric)
class(raw.vgm) = c("gstatVariogram", "data.frame")
plot(raw.vgm)

fit <- fit.variogram(raw.vgm,fit.method=6, vgm(psill = 0.00008,"Gau",nugget=0.00001))
#fit <- fit.variogram(raw.vgm,fit.method=7 ,vgm("Mat"))
plot(raw.vgm, fit)
theta<- cbind(fit$psill[1],1*fit$psill[2],fit$range[2])

fit2 <- fit.variogram(raw.vgm,fit.method=7 ,vgm("Exp"))


theta <- cbind(fit$psill[2],fit$range[2],fit$psill[1])
plot(raw.vgm, fit)
write.table(theta, file = "theta.csv",sep = ",", row.names = FALSE, col.names=FALSE, qmethod = "double")

#fit1 <- fit.variogram(raw.vgm,fit.method=6, vgm(psill = 0.4,"Exp",range = 20, nugget=0))
#plot(raw.vgm, fit1)

#plot(variogramLine(vgm(0.06, "Exp", 18.3), maxdist=128,n=128,min=1), type = 'l')
#x <- seq(1, 32)
#y <- seq(1, 32)
#xy1 <- expand.grid(x = x, y = y)
#names(xy1) <- c("x","y")
#g.dummy <- gstat(formula=z~1, locations=~x+y, dummy=T, beta=1, model=vgm(0.06, "Exp", 18.3),nmax=20)
#yy1 <- predict(g.dummy, newdata=xy1, nsim=1)
#write.table(yy1, file = "fo1.csv", sep = ",", row.names = FALSE, col.names=FALSE, qmethod = "double")

#image(grf(256*256, grid = "reg", cov.pars = c(1, 0.25)),col = gray(seq(1, 0.1, l = 51)), xlab = "", ylab = "")
#tmp=grf(256*256, grid = "reg",cov.pars = c(0.06, 18))
#image(tmp)
#write.table(tmp, file = "fo1.csv", sep = ",", row.names = FALSE, col.names=FALSE, qmethod = "double")