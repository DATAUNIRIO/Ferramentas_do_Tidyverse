library(gapminder)
library(plotly)
library("ggplot2")

#-----------------------------------------------------------------------------------
data("gapminder")
head(gapminder)

p <- ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  scale_x_log10()
fig <- ggplotly(p)
fig

#-----------------------------------------------------------------------------------

df <- data.frame(
  x = c(1, 2, 2, 1, 1, 2),
  y = c(1, 2, 2, 1, 1, 2),
  z = c(1, 1, 2, 2, 3, 3)
)
plot_ly(df) %>%
  add_markers(x = 1.5, y = 1.5) %>%
  add_markers(x = ~x, y = ~y, frame = ~z)

plot_ly(mtcars, x = ~wt, y = ~mpg, frame = ~cyl) 

