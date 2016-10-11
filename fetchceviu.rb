require 'mechanize'
mechanize = Mechanize.new
page = mechanize.get('http://www.ceviu.com.br/buscar/empregos')
puts page.title
link = page.link_with(class: 'tituloVaga')
page = link.click
puts page.uri
puts page.title