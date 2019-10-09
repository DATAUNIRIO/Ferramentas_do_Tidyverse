#### APIs con R
#### http://pacha.hk/latinr/apis/#1


#------------------------------------------------------
#### Plumber
#### Genera una API REST
#### Similar a escribir paquetes de R
#### Usa los conceptos de get, post y put
#------------------------------------------------------
#### Modelo lineal, parte 1
#------------------------------------------------------
pacman::p_load_gh("cienciadedatos/datos")
modelo <- lm(precio ~ quilate, data = diamantes)
coef(modelo)

#------------------------------------------------------
#### Modelo lineal, parte 2
#### Usando plumber
#------------------------------------------------------
#* modelo
#* @param x variable independiente
#* @param y variable dependiente
#* @get /modelo
function(x, y) {
  form <- as.formula(paste(y, x, sep = "~"))
  summary(lm(form, data = diamantes))
}

#------------------------------------------------------
#### Modelo lineal, parte 3
#### Para ejecutar:

r <- plumb("plumber.R")
r$run(port=8000)


#------------------------------------------------------
#### Modelo lineal, parte 4
#### La prueba debe dar error, plumber por default devuelve un data.frame convertido a JSON.
#### Cambios necesarios:
  
  #* modelo
  #* @param x variable independiente
  #* @param y variable dependiente
  #* @get /modelo
  function(x, y) {
    form <- as.formula(paste(y, x, sep = "~"))
    broom::tidy(lm(form, data = diamantes))
  }

#------------------------------------------------------
#### Modelo lineal, parte 5
#### Más opciones:
  
  #* modelo2
  #* @param x variable independiente
  #* @param y variable dependiente
  #* @param m modelo
  #* @get /modelo2
  function(x, y, m) {
    form <- switch(m,
                   "lin" = as.formula(paste(y, x, sep = "~")),
                   "log" = as.formula(sprintf("I(log(%s)) ~ I(log(%s))", y ,x))
    )
    broom::tidy(lm(form, data = diamantes))
  }

#------------------------------------------------------
#### 
#### Advertencias
#### Plumber jamás debería usarse sin https cuando hay datos sensibles en uso
#### Sin una configuración https debería reservarse a la intranet
#### Por ejemplo, si no hago un control mínimo como x <- substr(x, 1, 5) un usuario podría pasar SELECT * FROM public.clientes u otro comando para obtener más datos de lo que quiero que vea
