# https://www.rdocumentation.org/packages/rstatix/versions/0.7.0/topics/get_summary_stats


library(rstatix)
library(reactable)
# Full summary statistics
data("ToothGrowth")
ToothGrowth %>% get_summary_stats(len) %>%  reactable()
ToothGrowth %>% group_by(supp) %>%
  get_summary_stats(len) %>%  reactable()

# Summary statistics of grouped data
# Show only common summary
ToothGrowth %>%
  group_by(dose, supp) %>%
  get_summary_stats(len, type = "common")  %>%  reactable()

# Robust summary statistics
ToothGrowth %>% get_summary_stats(len, type = "robust")

# Five number summary statistics
ToothGrowth %>% get_summary_stats(len, type = "five_number") %>%  reactable()

# Compute only mean and sd
ToothGrowth %>% get_summary_stats(len, type = "mean_sd")  %>%  reactable()

# Compute full summary statistics but show only mean, sd, median, iqr
ToothGrowth %>%
  get_summary_stats(len, show = c("mean", "sd", "median", "iqr"))