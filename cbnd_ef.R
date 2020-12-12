dt1 = read.csv("metaboliteFIX.csv", header = TRUE, sep = ",")
dt2 = read.csv("efikasi.csv", header = TRUE, sep = ";")

dt = cbind(dt1,dt2)
dim(dt1)
dim(dt)
dt = dt[,-3591]
View(dt)

write.csv(x = dt,
          file = 'C:/Users/ACER/Documents/SKRIPSI/Depp_Learning_Jamu/dataset.csv',
          row.names = FALSE)

