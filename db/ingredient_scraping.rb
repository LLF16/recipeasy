require "open-uri"
require "nokogiri"

url = 'https://www.supercook.com/#/recipes'

html_file = open(url).read
doc = Nokogiri::HTML(html_file)
