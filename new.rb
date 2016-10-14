require 'mechanize'
require 'nokogiri'
require 'pry'

agent = Mechanize.new
@init = 0
page = agent.get('http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100')
@i = 0
storage = []
vaga_infos = {titulo: nil, descricao: nil, empresa: nil, uri: nil, moreinfo: nil}
vagas_links = page.search('.tituloVaga')

while page.at('.proxima a') do
   vagas_links.each do |c|
         puts c[:href]
         puts "cool"
         puts @i
         @i = @i + 1
   end
   @init = 100 + @init
   url =  'http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100'
   page = agent.get(url)
end