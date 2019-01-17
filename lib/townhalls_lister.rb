require "nokogiri"
require "open-uri"
require "pry"


def get_townhall_email(url)
	begin
      page =  Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"+url))
	return page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
	rescue OpenURI::HTTPError
      puts "HTML ERROR"
	end
end

def liste_dpts(page)
	liste_dpts = page.css("//tbody//tr//td//a[@class='lientxt']/@href").to_a
	liste_dpts.map! {|k| k.text}
end

def get_townhall_urls(liste_dpts,page)
	liste_cmmnes = []
	liste_noms = []
	nbpagescommunes = []
	liste_dpts.map do |lien|
		page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"+lien))
		nbpagescommunes += page.css("/html/body/table/tbody/tr[3]/td/table/tbody/tr/td[1]/p[4]//a/@href").to_a
		nbpages = 0
		while nbpages < nbpagescommunes.size+1
			if nbpagescommunes.size > 0
				page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"+nbpagescommunes[nbpages])) 
			end
			liste_cmmnes += page.css("//p/a.lientxt/@href").to_a
			liste_noms += page.css("//p/a.lientxt").to_a
			nbpages += 1
		end
	end
	return [liste_noms,liste_cmmnes]
end

def scrapping_master_function(arraydarrays)
	email_array = []
	arraydarrays[1].map do |k|
	email_array << get_townhall_email(k)
	end
	return [arraydarrays[0], email_array].transpose.map {|k| [k].to_h}
end

def perform
	page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"))
	return scrapping_master_function(get_townhall_urls(liste_dpts(page),page))
end

def perform_valdoiseversion
	page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"))
	return scrapping_master_function(get_townhall_urls(["val-d-oise.html"],page))
end

file = File.open("e-mairies","w+")
fichier = file
perform.map { |k| fichier.write("#{k.keys[0]}\t\t#{k.values[0]}\n")}
file.close

puts perform_valdoiseversion


