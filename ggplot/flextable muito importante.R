# https://ardata-fr.github.io/flextable-gallery/gallery/
# https://twitter.com/dgkeyes/status/1322220643446788096
library(tidyverse)
library(palmerpenguins)
library(flextable)

penguins %>%
  count(species) %>%
  flextable()

penguins %>%
  count(species) %>%
  set_names(c("especies", "tamanho")) %>%
  flextable() %>%
  bg(j= 'especies',
     i = ~tamanho >70,
     bg="yellow") 