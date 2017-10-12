#Chapter - 2 : Data Management
ID = c(1,2,3,4,5,6,7)
weight = c(10,20,24,22,23,25,28)
gender = c('male','female' , 'female' , 'male' , 'male' , 'female' , 'male' )
smoking = c('no','yes', 'no', 'yes', 'yes', 'no', 'yes' )
tumour = c('small', 'large', 'medium', 'large', 'medium', 'large', 'small')
mydata = data.frame(ID, weight, gender, smoking, tumour)
mydata
save(mydata, file='sar.RData')
