require "nokogiri"
require "open-uri"
require "pry"

page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=700&lang=fr"))
names = page.css("//div/div/div//ul/li[1]/h2").to_a.map! {|k| k.text}
emails = page.css("//div/div[1]//ul/li[5]/a[2]").to_a.map! {|k| k.text}
puts [names,emails].transpose.map!{|k| [k[0],k[1]].to_h}
