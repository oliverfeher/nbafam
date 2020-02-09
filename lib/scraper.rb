require "pry"
require "nokogiri"
require "open-uri"

class Scraper
    
    def self.get_team_info
        # doc.css(".mw-parser-output p").text
        doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Boston_Celtics"))
        # binding.pry
    end
    Scraper.get_team_info
end