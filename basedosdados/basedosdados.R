
# install.packages("bigrquery")

# https://basedosdados.org/
# https://basedosdados.github.io/mais/access_data_local/

library("bigrquery")

project_id = "basedosdados"
pib_per_capita = "SELECT 
    pib.id_municipio ,
    pop.ano, 
    pib.PIB / pop.populacao * 1000 as pib_per_capita
FROM `basedosdados.br_ibge_pib.municipios` as pib
INNER JOIN `basedosdados.br_ibge_populacao.municipios` as pop
ON pib.id_municipio = pop.id_municipio AND pib.ano = pop.ano
"

d <- bq_table_download(bq_project_query(project_id, pib_per_capita), page_size=500)
