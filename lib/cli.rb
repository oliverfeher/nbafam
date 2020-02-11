class Cli
    attr_accessor :team_select

    def run
        puts "                                                            
NNNNNNNN        NNNNNNNNBBBBBBBBBBBBBBBBB               AAA.              
N:::::::N       N::::::NB::::::::::::::::B             A:::A              
N::::::::N      N::::::NB::::::BBBBBB:::::B           A:::::A             
N:::::::::N     N::::::NBB:::::B     B:::::B         A:::::::A            
N::::::::::N    N::::::N  B::::B     B:::::B        A:::::::::A           
N:::::::::::N   N::::::N  B::::B     B:::::B       A:::::A:::::A          
N:::::::N::::N  N::::::N  B::::BBBBBB:::::B       A:::::A A:::::A         
N::::::N N::::N N::::::N  B:::::::::::::BB       A:::::A   A:::::A        
N::::::N  N::::N:::::::N  B::::BBBBBB:::::B     A:::::A     A:::::A       
N::::::N   N:::::::::::N  B::::B     B:::::B   A:::::AAAAAAAAA:::::A      
N::::::N    N::::::::::N  B::::B     B:::::B  A:::::::::::::::::::::A     
N::::::N     N:::::::::N  B::::B     B:::::B A:::::AAAAAAAAAAAAA:::::A    
N::::::N      N::::::::NBB:::::BBBBBB::::::BA:::::A             A:::::A   
N::::::N       N:::::::NB:::::::::::::::::BA:::::A               A:::::A  
N::::::N        N::::::NB::::::::::::::::BA:::::A                 A:::::A 
NNNNNNNN         NNNNNNNBBBBBBBBBBBBBBBBBAAAAAAA                   AAAAAAA
"
        puts <<~WELCOME
        ---------------------------------------------------------------------------
                             Welcome to the NBA family!
                      All display data belongs to Wikipedia.com
                           Copyright © 2020 oliverfeher
         
        WELCOME
        list_options
    end

 
       # Listing main menu options + nested menu_input for user interaction
       def list_options
        puts <<~MAINMENU

        Select from the following options!

        1. Enter your team
        2. List of teams
        3. About the NBA
        4. Credits
        5. Exit


        MAINMENU
        menu_input
    end

    # Listing main menu options + nested menu_input for user interaction + clears the page
    def list_options2
        system "clear"
        puts <<~MAINMENUCLEAR
        Select from the following options!
       
        1. Enter your team
        2. List of teams
        3. About the NBA
        4. Credits
        5. Exit

        MAINMENUCLEAR
        menu_input
    end

    # Responsible for user interaction + nested logic for each selection
    def menu_input
        puts"Your selection is:" 
        user_input = gets.strip
        puts ""

        case user_input
        when "1"
            enter_team
        when "2"
            system "clear"
            NBA_TEAM.create_nba_teams
            puts NBA_TEAM.list
            select_team
        when "3"
            nba_info
        when "4"
            credits
        when "5"
            closing
        else
            puts "Incorrect selection!"
            list_options
        end
    end

    
    def little_menu_input
        user_input = gets.strip

        case user_input
        when "1"
            list_options2
        when "2"
            closing
        else
            puts "Incorrect selection!"
            menu_or_exit
        end
    end

    def menu_or_exit
        puts <<~MENUOREXIT
        Select from available options:
        1. Menu
        2. Exit
        
        Your selection is:
        MENUOREXIT
        little_menu_input
    end

    def self.select_another_exit
        puts <<~SELECTOREXIT
        -------------------------------
        
        Select from available options:
        1. Menu
        2. Select another team from list
        3. Exit
        
        Your selection is:
        SELECTOREXIT
        Cli.new.select_another_exit2
    end

    def select_another_exit2    
        user_input = gets.strip
        case user_input
        when "1"
            Cli.new.list_options2
        when "2"
            system "clear"
            puts NBA_TEAM.list
            select_team
        when "3"
            closing
        else
            puts "Incorrect selection!"
            Cli.select_another_exit
        end
    end



    # Responsible for team selection from the list
    def select_team
        puts <<~SELECT
        ----------------------
        Select team by number:
        SELECT
        select_team_input
    end

    def select_team_input
        user_input = gets.strip
        team = NBA_TEAM.all[user_input.to_i - 1]
        if user_input.to_i > 30 || user_input.to_i < 1 # Validation for userselection!!
            puts "Incorrect selection! Try it again!"
            select_team
        else 
            system "clear"
            puts team.info 
            Cli.select_another_exit
        end
    end
    
    # Responsible for team selection by entering the name
    def enter_team
        NBA_TEAM.create_nba_teams
        puts "Type your team name here:"
        user_input = gets.strip
        team = NBA_TEAM.all.detect {|a| a.name.downcase.include? "#{user_input}" }
        if !team # Validation for entry !!!
            puts "Incorrect selection! Try it again!"
            enter_team
        else
            system "clear"
            puts team.info 
            Cli.select_another_exit
        end
    end

    
    # Responsible for exiting the app
    def closing
        system "clear"
        puts <<~CLOSING
             
        ╔═╗┌─┐┌─┐  ┬ ┬┌─┐┬ ┬┬
        ╚═╗├┤ ├┤   └┬┘│ ││ ││
        ╚═╝└─┘└─┘   ┴ └─┘└─┘o

        Thank you for using NBA Family!
        Copyright © 2020 oliverfeher
        CLOSING
        exit
    end
    
    # Responsible for displaying the general info for the league with a scraper
    def nba_info
        system "clear"
        info = Scraper.get_nba_info
        puts <<~NBAINFO
         =========================================
         The National Basketball Association (NBA)
         =========================================
         
         #{info[0]}
         
         #{info[1]}
         
         NBAINFO
        menu_or_exit
    end

    # Responsible for displaying app credits
    def credits
        system "clear"
        puts <<~CREDITS
                   ----------------------------------------------
                   |         Welcome to the NBA family!         |
                   | All display data belongs to Wikipedia.com  |
                   |        Copyright © 2020 oliverfeher        |
                   ----------------------------------------------
        
         The NBA Family application was made by Oliver Feher.
         Oliver is currently a Flatiron School coding bootcamp student, 
         and this project was build for the first module of the curriculum.
         
         Contact information:
         --------------------
         E-mail: olcsee@gmail.com
         LinkedIn: https://www.linkedin.com/in/oliver-feher-10093912a/ 
         GitHub: https://github.com/oliverfeher 

        CREDITS
        menu_or_exit
    end
    


        
end