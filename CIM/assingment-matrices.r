# a a
print(seq(50, 5, by = -5))

# a b
print(rep(1:2, each = 4))

# a c
a <- c(15, 67 ,35 ,65, 28)
print(mean(a))
print(sd(a))

m1 = matrix(c(1,2,3,2,3,4,1,0,2), nrow = 3, ncol = 3, byrow = TRUE)
m2 = matrix(c(2,1,3,0,0,0,3,2,1), nrow = 3, ncol = 3, byrow = TRUE)
# b i
print(m1-m2)

# b ii
print(m2/3)

# b iii
print(m1 %*% m2) # dot

# b iv
print(solve(m1, m2)) # solve x

TestData <- data.frame(
    ID = 1:10,
    gender = c("M", "M", "M", "M", "M", "F", "F", "F", "F", "F"),
    chest = c(34, 37, 38, 36, 38, 36, 36, 34, 33, 36),
    waist = c(30, 32, 30, 33, 29, 24, 25, 24, 22, 26),
    hip = c(32, 37, 36, 39, 33, 35, 37, 37, 34, 38)
)

# c i
print(nrow(TestData)) # no of data records
print(ncol(TestData)) # no of data variables

# c ii
TestData[TestData$ID==6,]$chest<-40
print(TestData[TestData$ID==6,]$chest)

# c iii
print(TestData[TestData$hip>35,]$ID)

# c iv
print(mean(TestData$hip))

# c v
print(tapply(TestData$waist, TestData$gender, mean))