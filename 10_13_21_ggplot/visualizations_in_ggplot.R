# Class 5: 10/13/21, Data visualization in R w/ ggplot2

library(ggplot2)

# will be using built-in ggplot dataset "cars"
# all ggplots have 3 layers: 
# data + aes + geoms
ggplot(data=cars) +
  aes(x=speed, y=dist) +
  geom_point() +
  geom_smooth(method="lm")+ 
  labs(title="The Stopping Distance of Old Cars", x="Speed(mph", y="Distance(ft)") + 
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5)) 

#mapping additional graph aesthetics 
#differential expression analysis w/ practice dataset 
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
nrow(genes)
ncol(genes)
table(genes$State)

#calculate % of genes in each State category
table(genes$State)/nrow(genes) * 100

#plot genes df
p <- ggplot(genes) + 
  aes(x=Condition1, y=Condition2, col=State)+ 
  geom_point() +
  labs(title="Differential Expression of Genes", x=
         "Control (no drug treatment)", y= "Drug Treatment") + 
  theme(plot.title = element_text(hjust = 0.5)) 
p

# Change the colors of points based on State column (up & down-regulated)
p + scale_colour_manual( values=c("blue","gray","red") )

#--------------------------------
# Advanced plotting in ggplot2
# Example dataset uses economic & demographic data from various countries since 1952

#install.packages("gapminder")
library(gapminder)
library(dplyr)

# Plot year vs Life expectancy 
ggplot(gapminder) + 
  aes(x=year, y=lifeExp) + 
  geom_point(alpha=0.4) #decrease opacity of points 

# Jitter points so they aren't stacked directly on top of each other
# Add boxplot to interpret distribution of points 
life_exp_plot <- ggplot(gapminder) + 
  aes(x=year, y=lifeExp, col=continent) + 
  geom_boxplot(aes(group=year, alpha=0.2)) + #alternatively, can use other plots (e.g. violin)
  geom_jitter(width=0.3, alpha=0.4) #offset points
  
# Filter df to year 2007
gapminder_2007 <- gapminder %>% filter(year==2007)

# For data from 2007, plot gdp per capita vs life expectancy 
ggplot(gapminder_2007) + 
  aes(x=gdpPercap, y=lifeExp) + 
  geom_point()

# Decrease opacity of the points to visualize overlapping points
ggplot(gapminder_2007) + 
  aes(x=gdpPercap, y=lifeExp) + 
  geom_point(alpha=0.5)

# Map continent to the color of the points and size to the population
ggplot(gapminder_2007) + 
  aes(x=gdpPercap, y=lifeExp, col=continent, size=pop) + 
  geom_point(alpha=0.5)

#---------------------------------------------
#generate interactive plot, shareable by URL
#install.packages("plotly")
library(plotly)
#ggplotly(life_exp_plot)
