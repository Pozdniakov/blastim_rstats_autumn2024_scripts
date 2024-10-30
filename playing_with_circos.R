#install.packages("circlize")

# Upload library
library(circlize)

# Create data
data = data.frame(
  factor = sample(letters[1:8], 1000, replace = TRUE),
  x = rnorm(1000), 
  y = runif(1000)
)

# Step1: Initialise the chart giving factor and x-axis.
circos.initialize( factors=data$factor, x=data$x )

# Step 2: Build the regions. 
circos.trackPlotRegion(factors = data$factor, y = data$y, panel.fun = function(x, y) {
  circos.axis()
})

# Step 3: Add points
circos.trackPoints(data$factor, data$x, data$y, col = "blue", pch = 16, cex = 0.5) 

set.seed(999)
bed = generateRandomBed()
head(bed)
bed = generateRandomBed(nr = 200, nc = 4)
nrow(bed)
bed = generateRandomBed(nc = 2, fun = function(k) sample(letters, k, replace = TRUE))
head(bed)
circos.initializeWithIdeogram()
text(0, 0, "default", cex = 1)
