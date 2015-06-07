library(NHPoisson)
source("generate_sequence.r")
source("analyze_approximation.r")
source("chi_squared.r")

n       <- 10000
rows    <- 3
columns <- 2
sample.time <- seq(5, 30, 5)
sample.size = length(sample.time)
sample.prediction_degree = 2
sample.poly = poly(sample.time, sample.prediction_degree, raw=TRUE)
#lambda.default = c(40, 40, 42, 35, 36, 35)
lambda.default = c(40, 38, 41, 40, 35, 30)
needed.percentage = c(.01, .05, .20, .35, .25, .15)

groups.number = 4
groups.names = c("Не класиф.", "Зміш.", "Слабкий", "Неврів.", "Рухливий", "Інерт.")

global.groups = rep(0, length(groups.number))
global.percentage = rep(0, length(groups.number))
global.distances = rep(0, length(groups.number))

png('output.png', width=22, height=22, units="cm", res=300)
par(mfrow=c(rows,columns))

result = rep(-1, n)
res <- rep(0, groups.number+2)
for (j in 2:(rows*columns+1)) {
    for (i in 1:n) {
        ## Generate non-homogeneous Poisson process trajectory
        sample.current <- generate_trajectory(lambda.default)
        # Calculate approximation
        abc <- find_abc(sample.current)
        # Get group
        result[i] <- get_group(abc[1], abc[2], abc[3])
    }
    elements_in_group <- function(x) length(result[result==x])
    groups <- unlist(Map(elements_in_group, -1:groups.number))
    print(sprintf("%.2f", groups/n))
    print(sprintf("%.2f", chi_squared.distance(n, tail(groups/n, 5), tail(needed.percentage,5))))
    barplot(groups, ylim=c(0, 70), names.arg=groups.names)
    global.groups <- global.groups + groups
}
print('Result:')
global.percentage = global.groups / (n*rows*columns)
print(sprintf("%.2f", global.percentage))
print(sprintf("%.2f", chi_squared.distance(n, tail(global.percentage, 5), tail(needed.percentage,5))))
