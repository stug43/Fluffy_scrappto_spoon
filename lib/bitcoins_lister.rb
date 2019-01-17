require "nokogiri"
require "open-uri"
require "pry"

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

names = page.css("//td[@class='text-left col-symbol']/text()").to_a
values = page.css("//*[@class='price']/@data-usd").to_a
final_array = [names.map! {|k| k.text}, values.map!{|k| k.text}].transpose.map! {|k| [k].to_h}
puts final_array

file = File.open("bitcoins.txt","w+")
fichier = file
final_array.map { |k| fichier.write("#{k.keys[0]}\t\t#{k.values[0]}\n")}
file.close
