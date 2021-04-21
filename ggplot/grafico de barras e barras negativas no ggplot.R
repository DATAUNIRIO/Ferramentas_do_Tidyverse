library(tidyverse)
#create datafile ---------------------------------------------------------
  
ProficiencyLevel <- c("Did Not Yet Meet", "Partially Met", "Approached", "Did Not Yet Meet", "Partially Met", "Approached", "Did Not Yet Meet", "Partially Met", "Approached", "Did Not Yet Meet", "Partially Met", "Approached", "Met", "Exceeded", "Met", "Exceeded", "Met", "Exceeded" , "Met", "Exceeded" )
categoryPercent <- c(-0.10466272, -0.15630047, -0.25162533, -0.10447221, -0.16393284, -0.26625820, -0.09994016, -0.15219629, -0.25163375, -0.09522626, -0.14517377, -0.24564893, 0.38606153, 0.10134995, 0.38090988, 0.08442686, 0.39767804, 0.09855177, 0.40330958, 0.11064147)
EndYear <- c(2015, 2015, 2015, 2016, 2016, 2016, 2017, 2017, 2017, 2018, 2018, 2018, 2015, 2015, 2016, 2016, 2017, 2017, 2018, 2018)

testSummary <- tibble(ProficiencyLevel = ProficiencyLevel,
                      percentUpDn = categoryPercent,
                      EndYear = EndYear) %>%
  mutate(ProficiencyLevel = factor(ProficiencyLevel,
                                   levels = c("Did Not Yet Meet", "Partially Met", "Approached", "Met", "Exceeded"),
                                   labels = c("1.Did Not Yet Meet", "2.Partially Met", "3.Approached", "4.Met", "5.Exceeded")))
#Locking colors to factor values -----------------------------------------
colors5prof <- c("#C55859", "#ff7f0e", "#E7CD6A", "#2ca02c", "#1f77b4" )
names(colors5prof) <- c("1.Did Not Yet Meet", "2.Partially Met", "3.Approached", "4.Met", "5.Exceeded")
#Plotting ----------------------------------------------------------------
  
ggplot()+
  geom_bar(data = testSummary, aes(y=percentUpDn, x=EndYear, fill=ProficiencyLevel), stat="identity", alpha =.8)+
  labs(title = "CMAS ELA: District",
       y= "Proficiency Level",
       x = "End Year")+
  theme_minimal()+
  theme(axis.ticks.y = element_line(size =1),
        panel.grid = element_blank(),
        plot.title = element_text(size = 25, color = "darkgrey"),
        axis.title = element_text(size = 18, color = "darkgrey"),
        legend.position = "bottom")+
  scale_y_continuous(breaks = c(-1, 0, 1))+
  geom_hline(yintercept=0)+
  scale_fill_manual(values = colors5prof) #+
  #coord_flip()

