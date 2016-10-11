require 'mechanize'
mechanize = Mechanize.new
page = mechanize.get('https://github.com/trending')
page.search('.select-menu-item-text.js-select-button-text.js-navigation-open').each do |languages|
  puts languages.text.strip
end
