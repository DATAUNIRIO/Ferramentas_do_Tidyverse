library(tidyverse)
library(tidytuesdayR)
library(ggforce)

tt <- tt_load("2021-01-26")

tt %>% 
  map(glimpse)
# Wrangle
#Idea Analyze Companies from Mexico
plastics <- tt$plastics
mexico_2020 <- plastics %>%
  filter(country == "Mexico", year == 2020,
         parent_company != "null",
         parent_company != "Unbranded") %>%
  arrange(desc(grand_total)) %>%
  slice_head(n = 5)
company_names <- unique(mexico_2020$parent_company)
#Factor parent_company and select columns to pivot_longer
mexico_2020 <- mexico_2020 %>%
  mutate(parent_company = factor(parent_company, 
                                 levels = company_names)) %>%
  select(-year,-country, 
         -empty, -o, -grand_total, 
         -num_events, -volunteers) 
#pivot_longer to be able to gather_set_data, required format for Sankey plot 
longer <- pivot_longer(mexico_2020, 
                       cols = 2:7, 
                       names_to = "plastic_type", 
                       values_to = "n") %>% 
  arrange(desc(n))
#gather_set_data to obtain x, y, id for geom_parallel
gather_longer <- gather_set_data(data = longer, x = 1:2)

# Visualize
plot <- ggplot(gather_longer, aes(x = x, id = id, split = y, value = n)) +
  geom_parallel_sets(aes(fill = parent_company), alpha = 0.6, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.1) +
  #geom_parallel_sets_labels(angle = 0, color = "white") + #automatic labeling
  
  
  
  labs(title = "Just one word: Plastics", 
       subtitle = "Top 5 polluting brands in the 2020 Break Free from Plastic cleanups in Mexico. \n                 Some of the goals of this citizen science initiative are holding companies accountable and promoting systemic solutions.",
       x = "ff"  ,
       caption = c("PP: Polypropylene, HDPE: High Density Polyethylene,\n LDPE: Low Density Polyethylene, PS: Polystyrene", "Data from Break Free from Plastic \n Viz by Francisco GF")) +
  
  theme_void() +
  theme(plot.title = element_text(hjust = .1, size = 30, face = "bold"),
        plot.subtitle = element_text(hjust = .2),
        plot.caption = element_text(hjust = c(.9,.2)),
        legend.position = "none",
        plot.margin=unit(c(1,0,.5,-.5),"cm"))+
  scale_x_discrete(expand = c(-.24,.38)) +
  
  #Add specific colors to companies   
  scale_fill_manual(
    values = c(
      "The Coca-Cola Company" = "#F40009",
      "Pepsico" = "#005CB4",
      "Bimbo" = "#F0A202",
      "Grupo Lala" = "#FF47A9",
      "Danone" = "#A7CCED"
    ))+
  
  #Anotates labels manually
  #plastics
  annotate(
    geom = "text",
    x = 2.09,
    y = 400,
    label = "PET",
    size = 6) +
  annotate(
    geom = "text",
    x = 2.08,
    y = 200,
    label = "PP",
    size = 6) +
  annotate(
    geom = "text",
    x = 2.095,
    y = 90,
    label = "HDPE",
    size = 6) +
  annotate(
    geom = "text",
    x = 2.08,
    y = 55,
    label = "PVC",
    size = 4) +
  annotate(
    geom = "text",
    x = 2.08,
    y = 25,
    label = "LDPE",
    size = 4) +
  annotate(
    geom = "text",
    x = 2.08,
    y = 0,
    label = "PS",
    size = 4)+
  #Company Names
  annotate(
    geom = "text",
    x = 1.125,
    y = 400,
    label = "Coca-Cola",
    size = 6) +
  annotate(
    geom = "text",
    x = 1.11,
    y = 225,
    label = "Pepsico",
    size = 6) +
  annotate(
    geom = "text",
    x = 1.09,
    y = 100,
    label = "Bimbo",
    size = 5) +
  annotate(
    geom = "text",
    x = 1.1,
    y = 50,
    label = "Danone",
    size = 5) +
  annotate(
    geom = "text",
    x = 1.08,
    y = 10,
    label = "Lala",
    size = 5)

plot

# Save Image
ggsave(plot,
       filename = here::here("Output","2021_01_26_plastics","plastics_v2.png"),
       dpi= 300,
       height = 6,
       width = 10)
