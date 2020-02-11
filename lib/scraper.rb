require "pry"
require "nokogiri"
require "open-uri"

class Scraper

    # Gets general information about the NBA
    # --------------------------------------------------------------------
    def self.get_nba_info
        infos = []
        doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/National_Basketball_Association"))
        team_info = doc.css(".mw-parser-output p")[3].text
        team_info1 = doc.css(".mw-parser-output p")[4].text
        infos.push(team_info, team_info1)
        infos
    end
    

    # Gets the selected team's general info and pushes it into a hash
    # --------------------------------------------------------------------
    def self.get_team_info(url)

        doc = Nokogiri::HTML(open(url))

        team = {}
        team[:name] = doc.css(".infobox th")[0].text
        team[:conference] = doc.css(".infobox td")[4].text
        team[:divison] = doc.css(".infobox td")[5].text
        team[:year] = doc.css(".infobox td")[6].text
        team[:arena] = doc.css(".infobox td")[8].text
        team[:location] = doc.css(".infobox td")[9].text

        team
    end

    # Gets the selected team roster, with player's name and jersey number
    # --------------------------------------------------------------------
    def self.get_team_roster(url)
        doc = Nokogiri::HTML(open(url))
        players = doc.css(".nba-player-index__name").collect do |player|
            new_p = player.text.split /(?=[A-Z])/
            new_p.join(" ")
        end
        numbers = doc.css(".nba-player-trending-item__number").collect { |number|number.text}     # I should put the roster as a team prop @roster for each NBA_TEAM instance
        team = Hash[numbers.zip(players)]
    end


    # Gets a list of all 30 NBA teams
    # --------------------------------------------------------------------
    def self.get_team_list
        doc = Nokogiri::HTML(open("https://www.nba.com/teams"))
        team_list = doc.css(".team__list").collect do |team|      
            team.text                                               
        end
    end
    
end

