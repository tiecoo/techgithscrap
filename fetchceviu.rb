require 'mechanize'
require 'pry'
mechanize = Mechanize.new
# page = mechanize.get('http://www.ceviu.com.br/buscar/empregos')
# puts page.title
# link = page.link_with(class: 'tituloVaga')
# page = link.click
# puts page.uri
# puts page.title
@init = 0
@url = 'http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100'
@page = mechanize.get(@url)
while @page.at('.proxima a') do
    @page.search('.tituloVaga').each do |titulo|
       puts titulo.text.strip
       puts @i
       @i = @i + 1
     end
     @init = 100 + @init
     @url = 'http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100'
     @page = mechanize.get(@url)
end