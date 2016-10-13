require 'mechanize'
mechanize = Mechanize.new
page = mechanize.get('http://www.ceviu.com.br/buscar/empregos?level=1&novaPesquisa=1&ini=0&termoPesquisa=&salarioMin=0&salarioMax=99999&salarioCombinar=1&diasMin=0&diasMax=90&ordenar=0&itensPagina=100')

page.search('.pagina a').each do |paginacao|
   link = page.link_with(class: '.pagina')
   link.click
   paginacao.search('.tituloVaga').each do |titulo|
      puts titulo.text.strip
   end
end