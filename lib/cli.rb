class Cli

    def run
        puts "                                                            
NNNNNNNN        NNNNNNNNBBBBBBBBBBBBBBBBB               AAA               
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
        puts "---------------------------------------------------------------------------"
        puts "                    Welcome to the NBA family!"
        puts "             All display data belongs to Wikipedia.com"
        puts "                   Copyright © 2020 oliverfeher"
        puts ""
        puts ""
        list_options
    end

    def list_options
        puts ""
        puts "Select from the following options!"
        puts ""
        puts <<-DOC.gsub /^\s*/, ''
            1. Enter your team
            2. List of teams
            3. About the NBA
            4. Credits
            5. Exit
        DOC
        puts ""
        puts ""
        menu_input
    end

    def menu_input
        puts"Your selection is:" 
        user_input = gets.strip
        puts ""

        case user_input
        when "5"
            closing
        when "1"
            enter_team
        when "2"
            list_teams
        when "3"
            nba_info
        when "4"
            credits
        else
            puts "Incorrect selection!"
            list_options
        end
    end

    def enter_team
        puts "Type your team name here:"
        user_input = gets.strip
    end
    

    def closing
        puts ""
        puts "Thank you for using NBA Family"
        puts "See you next time!"
        exit
    end
    
    def nba_info
        puts ""
        puts "========================================="
        puts "The National Basketball Association (NBA)"
        puts "========================================="
        puts ""
        Scraper.get_nba_info
        puts ""
        puts ""
        menu_or_exit
    end

    def menu_or_exit
        puts "Select from available options:"
        puts "1. Menu"
        puts "2. Exit"
        puts ""
        puts"Your selection is:"
        user_input = gets.strip

        case user_input
        when "1"
            list_options
        when "2"
            closing
        end
    end

    


        
end