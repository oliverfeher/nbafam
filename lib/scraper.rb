require "pry"
require "nokogiri"
require "open-uri"

class Scraper

    def self.get_nba_info
        doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/National_Basketball_Association"))
        team_info = doc.css(".mw-parser-output p")[3].text
        team_info1 = doc.css(".mw-parser-output p")[4].text
        team_info2 = doc.css(".mw-parser-output p")[5].text
        puts "#{team_info}"
        puts ""
        puts "#{team_info1}"
    end

    def self.get_team_info
        # doc.css(".mw-parser-output p").text
        doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Boston_Celtics"))
        # binding.pry
    end
    Scraper.get_nba_info
end