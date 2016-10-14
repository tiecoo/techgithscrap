require 'mechanize'
require 'pry'
require "resolv-replace.rb"
require 'nokogiri'
require 'yaml'
require 'slowweb'
mechanize = Mechanize.new
mechanize.set_proxy("223.67.136.218", 80)

mechanize.user_agent_alias = 'Windows Chrome'
@i = 0
total_vagas = []
vaga_infos = {titulo: nil, descricao: nil, empresa: nil, uri: nil, moreinfo: nil}
@init = 0
@url = 'http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100'
@page = mechanize.get(@url)
while @page.at('.proxima a') do
   @pagelinks = @page.links.find_all { |l| l.attributes.parent.name == 'h4'}
    @pagelinks.each do |titulo|
         page = titulo.click
         vaga_infos[:uri] = page.uri
         vaga_infos[:titulo] = page.at('h2.titulo-vaga') ? page.at('h2.titulo-vaga').text : ""
         vaga_infos[:descricao] = page.at('div.descricao-vaga p') ? page.at('div.descricao-vaga p').text : ""
         vaga_infos[:empresa] = page.at('.nome-empresa') ? page.at('.nome-empresa') .text : ""
         vaga_infos[:moreinfo] = page.at('ul.list-unstyled.mais-informacoes') ? page.at('ul.list-unstyled.mais-informacoes').text : ""
         puts @i
         @i = 1 + @i
     end
     @init = 100 + @init
     @url = 'http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini='+ @init.to_s  + '&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100'
     @page = mechanize.get(@url)
     total_vagas.push(vaga_infos.clone)
end

FileUtils.mkdir_p "./seed/"
File.open("./seed/vagas.yaml",'w') do |out|
       out.write(total_vagas)
      puts "Arquivo criado com sucesso"
end
