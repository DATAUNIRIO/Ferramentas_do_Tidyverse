# https://rfortherestofus.com/2020/05/color-titles-ggtext/
# https://gist.github.com/dgkeyes

library(ggplot2)
library(dplyr)
library(ggtext)
library(hrbrthemes)
iris %>% 
  group_by(Species) %>% 
  summarize(mean_petal_width = mean(Petal.Width)) %>% 
  ungroup() %>% 
  ggplot(aes(Species, mean_petal_width,
             fill = Species)) +
  geom_col(show.legend = FALSE) +
  theme_ipsum() +
  scale_fill_manual(values = c("setosa" = "lightgray",
                               "versicolor" = "lightgray",
                               "virginica" = "red")) +
  labs(x = NULL,
       y = NULL,
       title = "<span style = 'color: red;'>Virginica irises</span> have the largest average sepal width") +
  theme(plot.title = element_markdown())
