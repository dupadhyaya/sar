#Chapter - 3 : Data Manipulation
load('sar.RData')
mydata
names(mydata)

str(mydata)
levels(mydata$smoking)
dim(mydata)
class(gender)
class(weight)
mydata[1:3,]
head(mydata, n=10)
tail(mydata, n=3)
write.table(mydata, 'socialdata.txt', sep='\t')


#3.3  Renaming Variables ----
attach(mydata)
names(mydata)
mydata
names(mydata)[3] = 'Sex'
names(mydata)[c(4,5)] = c('Smoke','Tum')
mydata

#load old Data
load('sar.RData')



#3.5 Merge Command
ID = c(1,2,3,4,5,6,7)
Age = c(25,24,34,21,32,22,27)
BP = c('yes','no', 'yes', 'yes', 'no', 'yes', 'no' )
mydata1 = data.frame(ID, Age, BP)
mydata1

merge.data = merge(mydata, mydata1, by='ID')
merge.data




#3.16 Coding Numeric Data to Numeric
ID = scan(what=numeric())
Gender = scan(what=character())
Age = scan(what=numeric())
Weight = scan(what=numeric())
Height = scan(what=double())
Cholestrol = scan(what=integer())
Income = scan(what=numeric())
socialdata = data.frame(ID, Gender, Age, Weight,
            Height, Cholestrol, Income)
#ID; Gender ; Age ; Weight ;Height;
#Cholestrol ;Income
socialdata
save(socialdata, file='sar.RData')
rm(list=ls())
load('sar.RData')
mydata
socialdata
