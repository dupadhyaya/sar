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
#write.table(mydata, 'socialdata.txt', sep='\t')


#3.3  Renaming Variables ----
attach(mydata)
names(mydata)
mydata
names(mydata)[3] = 'Sex'
names(mydata)[c(4,5)] = c('Smoke','Tum')
mydata

#load old Data
load('sar.RData')



#3.5 Merge ----
# Adding Coln
ID = c(1,2,3,4,5,6,7)
Age = c(25,24,34,21,32,22,27)
BP = c('yes','no', 'yes', 'yes', 'no', 'yes', 'no' )
mydata1 = data.frame(ID, Age, BP)
mydata1

merge.data = merge(mydata, mydata1, by='ID')
merge.data

#3.7 Transpose ----
datamy = mydata
t(datamy)

#3.8 Split
mydata
(ldf = split(mydata, mydata$gender))

#3.9 Aggregate ----
aggregate(mtcars, by=list(mtcars$cyl, mtcars$gear), FUN=mean)
mydata
aggregate(mydata['weight'], by=list(SEX=mydata$gender, CANCER=mydata$tumour), FUN=mean)
#using Rcdr

(AggregatedData<- aggregate(weight ~ gender + tumour, data=mydata, FUN=mean))

#3.22 Reshape ----
ID= c(1,1,2,2)
Time = c(1,2,1,2)
x1=c(7,3,4,2)
x2=c(4,5,8,1)
x = data.frame(ID, Time, x1,x2)
library(reshape)
x
(md = melt(x, id=c('ID', 'Time')))
(cd1 = cast(md, ID ~ variable, mean))
(cd2 = cast(md, Time ~ variable, mean))
(cd3 = cast(md, ID ~ Time, mean))
(cd4 = cast(md, ID + Time ~ variable))  # original
(cd5 = cast(md, ID + variable ~ Time)) 
(cd6 = cast(md, ID ~  variable + Time)) 

#3.12 Transform ----
(mydata = transform(mydata, weight=weight* 2.204))

#3.13 Transform using R Cdr

#3.14 Subsetting ---0

(femdata = mydata[gender=='female', ])
(maldata = mydata[gender=='male', ])
(malesmoking = mydata[gender=='male' & smoking=='yes', ])
(femalesmoking = mydata[gender=='female' & smoking=='yes',])
(maleover23 = mydata[gender=='male' & weight > 23,])
(mean(weight[gender=='female']))
(mean(weight[gender=='male']))

#3.14.1 Selecting/ Keeping ----
# create DF - no of variables
#1st Method
(myvars = paste("v",1:3, sep=''))
(newdata = mydata[myvars])
#2nd Method : 1st to 5th
(newdata = mydata[c(1,5:10)])
#3rd Method : variable names
myvars = c('ID', 'Gender', 'Tumour')
(newdata = mydata[myvars])

#3.14.2 Excluding / Dropping ----
#exclude variables v1,v2,v3
(myvars = names(mydata) %in% c('V1','V2','V3'))
(newdata = mydata[!myvars])

#delete variables V1 & V5
mydata$v3 = mydata$v5 = NULL

#exclude 3rd and 5th 
newdata = mydata[c(-3,-5)]

#exclude 4th variable
newdata = mydata[c(-4)]

#3.14.3 Selecting Obsvn ----
#1st 5 obsvn
newdata = mydata[1:5,]
#based on criteria
(newdata = mydata[which(mydata$gender=='female' & mydata$weight > 22),])

#Add/ Delete Colns
#Add
(mydata$age = c(30,35,40, 25, 33, 45, 56))
(mydata['age'] =c(30,35,40, 25, 33, 45, 56))
(mydata[,'age'] =c(30,35,40, 25, 33, 45, 56))
#Remove
(mydata$age = NULL)
(mydata['age'] = NULL)
(mydata[,'age'] = NULL)
(mydata[[6]] = NULL)
(mydata[,6] = NULL)
mydata

#3.14.5 Random Samples
set.seed(123)
sample(1:8, size=8, replace=T)
sample(1:8, size=8, replace=F)
sample(c('Achal','Apoorva','Lalit', 'Shruti', 'Vijay'), size=8, replace=T)

# from distributions
runif(5, min=1, max=6)
rnorm(8)
rbinom(20, size=5, prob=0.3)
rchisq(4,df=7)
rt(5,df=5, ncp=1)
rf(5, df1=2, df2=10)

#3.15 Subsetting using Rcmdr
str(mydata)
df9 <- subset(AggregatedData, subset=male)
subset(AggregatedData, select=c(gender,tumour))

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
#save(mydata, socialdata, file='sar.RData')
rm(list=ls())
load('sar.RData')
mydata
socialdata

socialdata[,1]

#3.16.2  Coding numeric to text
str(socialdata)
(socialdata$Incomecat1[socialdata$Income > 5000 & socialdata$Income <= 20000] = 'Low Income')
(socialdata$Incomecat1[socialdata$Income > 20001 & socialdata$Income <= 35000] = 'Medium Income')
(socialdata$Incomecat1[socialdata$Income > 35001 & socialdata$Income <= 60000] = 'High Income')
socialdata

#3.16.3 Text to Numeric
#male to 1, female to 2
#revalue, mapvalue (plyr)
library(plyr)
(socialdata$scode = plyr::revalue(socialdata$Gender, c('male'='1', 'female'='2')))
(socialdata$scode = plyr::mapvalues(socialdata$Gender,
        from =c('male','female'), to=c(1,2)))
(socialdata$scode = plyr::mapvalues(socialdata$Gender,
        from =c('male','female'), to=c('1','2')))
str(socialdata$scode)

(socialdata$scode[socialdata$Gender=='male'] = '1')
(socialdata$scode[socialdata$Gender=='female'] = '2')
socialdata[c('Gender','scode')]

#3.16.4 Using packages 
library(car)
as.numeric(socialdata$Gender)
as.character(socialdata$Gender)

#3.17 Binning using Rcmdr
#data -> Manage Var in active dataset- Bin numeric variable

#3.18 Continuous var to Cat variable
(socialdata$Income.Cat = cut(socialdata$Income, c(5000, 25000, 40000, 60000),
        c('Low','Medium', 'High') ))

#3.19 Using R Cdr
#data -> Manage var in active data set > convert numeric to factors
socialdata <- within(socialdata, {
  ic <- factor(Income, labels=c('a','b','c','d',
                                'e','f','g','h'))
})

#3.20 stack ----
Gold = c(25000, 27000, 22000, 21000, 29000)
Crude = c(4000, 5000, 4500, 6000, 7000)
(Commodity = data.frame(Gold, Crude))
(us =stack(Commodity))
unstack(us)

#3.21 Stack using Rcdr
#Data -> Active dataset -> Stack variables in active dataset
StackedData
