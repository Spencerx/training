data = read.csv("benchmarks.csv")

implementations = tail(colnames(data), -1)
colors = rainbow(length(implementations))
test_names = data$Benchmark


m = matrix(0,length(implementations),length(test_names))

for(i in 1:length(implementations)) {
  m[i,] = data[[i+1]]
}


par(mar=c(15,5,5,5))

barplot(m, beside = TRUE, legend.text = implementations, col = colors,
  names.arg = test_names, las = 2)
