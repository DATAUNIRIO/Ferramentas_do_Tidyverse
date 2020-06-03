# 2020 (2019) AKC dog bump chart
library(ggplot2) # CRAN v3.3.0
library(ggbump) # CRAN v0.1.0
library(dplyr) # [github::tidyverse/dplyr] v0.8.99.9003
library(tidyr) # CRAN v1.0.3
library(ggimage) # CRAN v0.2.8
library(scico) # CRAN v1.1.0
library(extrafont) # CRAN v0.17

# make dataset
dogranks <-
  tibble(
    Breed = c(
      "Retrievers (Labrador)", "German Shepherd Dogs",
      "Retrievers (Golden)", "French Bulldogs", "Bulldogs",
      "Beagles", "Poodles", "Rottweilers", "Yorkshire Terriers",
      "Pointers (German Shorthaired)", "Pembroke Welsh Corgis"
    ),
    r2019 = c(1L, 2L, 3L, 4L, 5L, 7L, 6L, 8L, 12L, 9L, 10L),
    r2018 = c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 10L, 9L, 13L),
    r2017 = c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 15L),
    r2016 = c(1L, 2L, 3L, 6L, 4L, 5L, 7L, 8L, 9L, 11L, 18L),
    r2015 = c(1L, 2L, 3L, 6L, 4L, 5L, 8L, 9L, 7L, 11L, 20L),
    r2014 = c(1L, 2L, 3L, 9L, 4L, 5L, 7L, 10L, 6L, 12L, 22L),
    r2013 = c(1L, 2L, 3L, 11L, 5L, 4L, 8L, 9L, 6L, 13L, 24L)
  )

# path to paw print image
dogranks$paw <- "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Black_Paw.svg/256px-Black_Paw.svg.png"

# melt df
dogs_long <- dogranks %>%
  pivot_longer(
    cols = r2019:r2013,
    names_to = "year", values_to = "rank"
  ) %>%
  mutate(year = readr::parse_number(year))

# plot
pups <-
  ggplot(dogs_long) +
  geom_bump(aes(year, rank, color = Breed), size = 2, smooth = 6) +
  scale_color_scico_d(palette = "hawaii", guide = FALSE) +
  scale_y_reverse(breaks = c(1:10, 11, 13, 24), expand = c(0.04, 0.02)) +
  geom_text(
    data = dogranks, aes(y = r2013, x = 2013, label = Breed),
    hjust = "right", nudge_x = -0.15, size = 5.4, color = "white", family = "Chilanka"
  ) +
#  geom_image(
#    data = dogranks, aes(y = r2019, x = 2019, image = paw), size = 0.04, nudge_x = 0.2,
#    nudge_y = 0.2
#  ) +
  geom_text(
    data = dogranks, aes(y = r2019, x = 2019, label = r2019),
    nudge_x = 0.2, size = 5, color = "#a0c4ff", family = "Purisa", fontface = "bold", nudge_y = 0.03
  ) +
  scale_x_continuous(breaks = c(2013:2019), expand = expansion(add = c(4.1, 0.4))) +
  theme_minimal(base_family = "Chilanka", base_size = 16) +
  theme(
    plot.background = element_rect(fill = "#252a32", color = "#252a32"),
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0.5, color = "#f9c74f"),
    plot.caption = element_text(color = "#fec89a")
  ) +
  labs(
    x = "", y = "",
    title = "American Kennel Club most popular breeds",
    caption = "source: AKC registration statistics  https://www.akc.org/expert-advice/dog-breeds/2020-popular-breeds-2019/\nby @LuisDVerde (www.liomys.mx)"
  )

# export (optional)
# ggsave(pups,filename = "akc2020.png",width = 10, height = 6,units = "in",dpi = 200)