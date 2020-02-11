class NBA_TEAM

    attr_accessor :name, :conference, :divison, :founded, :year, :arena, :location, :gm, :coach, :updated, :roster

    # CONSTRUCTOR
    
    @@all = []
    @@created = false

    def initialize(name)
        @name = name
        @updated = false
    end

    def self.create_teams
        names = Scraper.get_team_list
        names.each do |name|
            create(name)
        end
    end

    def self.create_nba_teams  # real creation also validation for existence
        self.create_teams if @@created == false
        @@created = true
    end


    def update_from_wiki
                                                    #Atlanta Hawks => [Atlanta, Hakws] => atlanta_hawks / boston_celtics
        url = "https://en.wikipedia.org/wiki/#{name.split(' ').join('_')}"

        hash_from_wiki = Scraper.get_team_info(url)

        update_from_hash(hash_from_wiki)         # Getting a hash from the scraper with all the props
    end

    def update_from_nba
                                      # /team/hawks or teams/celtics  => Boston Celtics => [Boston, Celtics] => Celtics => celtics
        url = "https://www.nba.com/teams/#{name.split(' ').last.downcase}"
        if url == "https://www.nba.com/teams/76ers"
            url = "https://www.nba.com/teams/sixers"
            self.roster = Scraper.get_team_roster(url)
        else
            self.roster = Scraper.get_team_roster(url)
        end
    end

    def update_from_hash(hash)
        hash.each { |k, v| send("#{k}=", v) if self.methods.include?("#{k}=".to_sym)}
    end

    def update
        update_from_wiki
        update_from_nba
        self.updated = true
    end

    def self.all
        @@all
    end

    def self.create(name)
        new(name).tap{|t| @@all << t}
    end

    def self.list
        <<~LIST
        #{all.map.with_index(1){|team, i| "#{i}. #{team.name}"}.join("\n")}
        LIST
    end

    def info
        update if !updated

        roster_lines = []
        self.roster.each { |key, value| roster_lines << "# #{key} - #{value}"}
        
        <<~INFO
        Name : #{self.name}                
        Arena : #{self.arena}
        Conference : #{self.conference}
        Divison : #{self.divison}
        Located at : #{self.location}
        Founded in : #{self.year}
        
        Roster:
        #{roster_lines.join("\n")}

        INFO
    end
end
