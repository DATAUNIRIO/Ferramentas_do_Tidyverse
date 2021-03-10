library(reticulate)
conda_list(conda = "auto")
use_condaenv()

#reticulate::conda_install(envname = NULL,'html2text',conda = "auto",forge=TRUE)
#reticulate::repl_python()

#conda install -c conda-forge html2text
r.text <-"<p><strong>Zed's</strong> dead baby, <em>Zed's</em> dead.</p>"
#----------------------------------------------------------
html2text<-reticulate::import('html2text',convert = TRUE)
html2text$html2text("<p><strong>Zed's</strong> dead baby, <em>Zed's</em> dead.</p>")
html2text$html2text(r.text)
reticulate::r_to_py(text)
#----------------------------------------------------------

os <- import("os")
os$listdir(".")
#----------------------------------------------------------

#reticulate::conda_install(envname = NULL,'urllib')
urllib<-reticulate::import('urllib')

fp = urllib$request$urlopen("http://www.unirio.br/")
mybytes = fp$read()

mystr = mybytes$decode("utf8")
mystr2 =html2text$html2text(mystr)
fp$close()

#----------------------------------------------------------


#----------------------------------------------------------
# from urllib.request import urlopen
# urllib$request$urlopen
#----------------------------------------------------------
urllib<-reticulate::import('urllib')
url = "http://www.unirio.br/"
page = urllib$request$urlopen(url)
page
html_bytes = page$read()
html = html_bytes$decode("utf-8")
print(html)
page$close()

#----------------------------------------------------------
#reticulate::conda_install(envname = NULL,'beautifulsoup4')
#reticulate::conda_install(envname = NULL,'requests')

bs4<-reticulate::import('bs4')
requests<-reticulate::import('requests')
#page = requests.get("http://www.unirio.br/")
page = requests$get("http://www.unirio.br/")
page

#from bs4 import BeautifulSoup
#soup = BeautifulSoup(page.content, 'html.parser')

soup = bs4$BeautifulSoup(page$content, 'html.parser')
soup
print(soup$prettify())


dados<-soup$find_all('p')
titulo<-soup$find_all('h2')
class(dados)
dados$get_text()

dados<-soup$find_all('p', class_='tileBody')
titulo<-soup$find_all('h2', class_='tileHeadline')

soup$find_all(id="portal-footer")


novosdados<-soup$select("div p")
novosdados<-
  novosdados[28]

for bloco in lista:
  print(novosdados[29])
aux = aux + 1

for(i in 0:29){
  print(novosdados[i])
}












