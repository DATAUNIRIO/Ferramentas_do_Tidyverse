library(GGally)
data(tips, package = "reshape")

# differences with ggally_table()
ggally_table(tips, mapping = aes(x = day, y = time))
ggally_crosstable(tips, mapping = aes(x = day, y = time))

# display column proportions
ggally_crosstable(tips, mapping = aes(x = day, y = sex), cells = "col.prop")
# display row proportions
ggally_crosstable(tips, mapping = aes(x = day, y = sex), cells = "row.prop")

# change size of text
ggally_crosstable(tips, mapping = aes(x = day, y = sex), size = 8)

# change scale for fill
ggally_crosstable(tips, mapping = aes(x = day, y = sex), fill = "std.resid") +
     scale_fill_steps2(breaks = c(-2, 0, 2), show.limits = TRUE)





data(tips, package = "reshape")
ggally_table(tips, mapping = aes(x = smoker, y = sex))
ggally_table(tips, mapping = aes(x = day, y = time))
ggally_table(tips, mapping = aes(x = smoker, y = sex, colour = smoker))

# colour is kept only if equal to x or y
ggally_table(tips, mapping = aes(x = smoker, y = sex, colour = day))

# diagonal version
ggally_tableDiag(tips, mapping = aes(x = smoker))

# custom label size and color
ggally_table(tips, mapping = aes(x = smoker, y = sex), size = 16, color = "red")

# display column proportions
ggally_table(
  tips,
  mapping = aes(x = day, y = sex, label = scales::percent(after_stat(col.prop)))
)

# draw table cells
ggally_table(
  tips,
  mapping = aes(x = smoker, y = sex),
  geom_tile_args = list(colour = "black", fill = "white")
)


ggally_ratio(tips, ggplot2::aes(sex, day))
