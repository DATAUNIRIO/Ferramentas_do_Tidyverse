
library(sparklyr)
spark_install()
library(dplyr)
java_path <- normalizePath('C:/Program Files/Java/jre1.8.0_201')
Sys.setenv(JAVA_HOME=java_path)

# iniciando a conexao
sc <- spark_connect(master = "local")

# copiando para o spark
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")

# mostrando as tabelas
src_tbls(sc)

# filter by departure delay and print the first few records
flights_tbl %>% filter(dep_delay == 2)
delay <- flights_tbl %>% 
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>%
  collect

# plot delays
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area(max_size = 2)

