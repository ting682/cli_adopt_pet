class CliAdoptPet::CLI
    @@all = []
    def initialize
        @@all << self
    end
    def self.all
        @@all
    end
    def call
        puts "Welcome to pet finder!"
        puts "enter zip code"
        @zipcode = gets.strip
        puts "enter cat or dog"
        @type = gets.strip.capitalize!
        request = CliAdoptPet::API.new(@zipcode, @type)
        if request.get_listings
            puts "Here are your list of pets in your location. Please select a pet for more information"
            CliAdoptPet::Pet.list_pets
            puts "Select a pet for details"
            @pet_selected = gets.strip.to_i - 1
            CliAdoptPet::Pet.pet_details(@pet_selected)
            until @looking == false 
                puts "Would you like to review another pet? (y/n)"
                @review_again = gets.strip.downcase
                #binding.pry
                if @review_again == "y"
                    CliAdoptPet::Pet.list_pets
                    puts "Select a pet for details"
                    @pet_selected = gets.strip.to_i - 1
                    #binding.pry
                    if @pet_selected.between?(0,6)
                        CliAdoptPet::Pet.pet_details(@pet_selected) 
                    else
                        puts "Invalid selection. Please try again."
                    end
                    
                else
                    @looking = false
                end
            end
        else
            self.call
        end

    end
end