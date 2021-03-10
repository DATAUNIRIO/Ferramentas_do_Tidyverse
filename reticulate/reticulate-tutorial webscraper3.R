library(reticulate)
conda_list(conda = "auto")
use_condaenv()

main <- import_main()
py <- import_builtins()
math <- import("math")

num = py$float(py$input("\nEntre com um número: "))
raiz = math$sqrt(num)

paste0("A raiz quadrada de ", num ," é ", raiz)

#----------------------------------------------------------
# Módulos Python para Web Scraping
#----------------------------------------------------------
# Carregando as bibliotecas
#----------------------------------------------------------
#reticulate::conda_install(envname = NULL,'pandas')
#reticulate::conda_install(envname = NULL,'webbrowser')
#reticulate::conda_install(envname = NULL,'selenium')

webbrowser <- reticulate::import('webbrowser', convert = FALSE)
bs4        <-reticulate::import('bs4', convert = FALSE)
requests   <-reticulate::import('requests', convert = FALSE)
selenium   <-reticulate::import('selenium', convert = FALSE)

webbrowser$open('https://bsi.uniriotec.br')

chromedriver<-"C:/Users/Hp/Downloads/chromedriver/chromedriver.exe"

chrome = selenium$webdriver$chrome$webdriver
chrome$WebDriver$get("https://bsi.uniriotec.br")


firefox = webdriver.Firefox()
firefox.get('http://google.com.br')

from selenium import webdriver

# Criar instância do navegador
firefox = webdriver.Firefox()

# Abrir a página do Python Club
firefox.get('http://pythonclub.com.br/')

# Seleciono todos os elementos que possuem a class post
posts = firefox.find_elements_by_class_name('post')

# Para cada post printar as informações
for post in posts:
  
  # O elemento `a` com a class `post-title`
  # contém todas as informações que queremos mostrar
  post_title = post.find_element_by_class_name('post-title')

# `get_attribute` serve para extrair qualquer atributo do elemento
post_link = post_title.get_attribute('href')

# printar informações
print u"Títutlo: {titulo}, \nLink: {link}".format(
  titulo=post_title.text,
  link=post_link
)

# Fechar navegador
firefox.quit()