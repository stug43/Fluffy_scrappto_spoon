require "nokogiri"
require "open-uri"
require "pry"

page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=700&lang=fr"))
names = page.css("/div[@class='main-block large-gutter']//ul//li[1]/text")
emails = page.css("/html/body/div[1]/main/div/div/div[1]//ul/li[5]/a").to_a.size
puts "#{names} #{emails}"
