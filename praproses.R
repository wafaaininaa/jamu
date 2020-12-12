data_plant = read.csv(file = 'C:/Users/ACER/Documents/SKRIPSI/plantmetabolite.csv',
                      header = TRUE,
                      sep = ';')
data_jamu = read.csv(file = 'C:/Users/ACER/Documents/SKRIPSI/jamuherbs.csv',
                     header = TRUE,
                     sep = ',')
dim(data_jamu)
View(data_jamu)
View(data_plant)
colnames(data_plant)

# Handle NA
for (i in 1:dim(data_plant)[1]) {
  for (j in 1:dim(data_plant)[2]) {
    if (is.na(data_plant[i,j]) == TRUE) {
      data_plant[i,j] = 0
    }
    else {
      data_plant[i,j] = data_plant[i,j]
    }
  }
}
write.csv(x = data_plant,
          file = 'C:/Users/ACER/Documents/SKRIPSI/data_plant_no_na.csv',
          row.names = FALSE)
data_plant = read.csv(file = 'C:/Users/ACER/Documents/SKRIPSI/data_plant_no_na.csv',
                      header = TRUE,
                      sep = ',')

# Pre-processing Plant Data
a = 1:(dim(data_jamu)[2]-1)
b = data_plant[,1]
index = a %in% b
c = a[index == FALSE]
df_new = cbind(Row.Labels = c,
               data_plant[1:length(c),2:dim(data_plant)[2]])
View(df_new)
for (i in 1:dim(df_new)[1]) {
  for (j in 2:dim(df_new)[2]) {
    if (df_new[i,j] == 1) {
      df_new[i,j] = 0
    }
    else {
      df_new[i,j] = df_new[i,j]
    }
  }
}
# Merge Data
data_plant_1 = rbind(df_new,
                     data_plant)
index_order = order(x = data_plant_1$Row.Labels,
                    decreasing = FALSE)
data_plant_1 = data_plant_1[index_order,]
View(data_plant_1)
#data_jamu = data_jamu[1:2,]
dim(data_plant_1)

# Save Data plant
write.csv(x = data_plant_1,
          file = 'C:/Users/ACER/Documents/SKRIPSI/data_plant_FIX.csv',
          row.names = FALSE)

# Checking metabolite in jamu
df_dummy = cbind(data_jamu$IDJamu,
                 data_plant_1[c(5,9),2:dim(data_plant_1)[2]])
mean_vector = c()
for (i in 2:dim(df_dummy)[2]) {
  mean_1 = mean(df_dummy[,i])
  mean_vector[i] = mean_1
}
mean(mean_vector,na.rm = TRUE)

for (i in 1:dim(data_jamu)[1]) {
  for (j in 2:dim(data_jamu)[2]) {
    if (data_jamu[i,j] == 1) {
      df_dummy[i,2:dim(df_dummy)[2]] = df_dummy[i,2:dim(df_dummy)[2]] +
        data_plant_1[j-1,2:dim(data_plant_1)[2]]
    }
  }
}

write.csv(x = df_dummy,
          file = 'C:/Users/ACER/Documents/SKRIPSI/df_dummy.csv',
          row.names = FALSE)

df <- read.csv2("df_dummy.csv", header = TRUE, sep = ",")
View(df)

#Change counter to binary
for (i in 1:dim(df)[1]){
  for (j in 2:dim(df)[2]){
    if(df[i,j]>1){
      df[i,j] <- 1
    }
    else{
      df[i,j]<- df[i,j]
    }
  }
}
write.csv(x = df,
          file = 'C:/Users/ACER/Documents/SKRIPSI/metaboliteFIX.csv',
          row.names = FALSE)
