class CliAdoptPet::CLI
    def call
        puts "Welcome to pet finder! Please review the options"
        puts "enter zip code"
        @zipcode = gets.strip
        puts "enter cat or dog"
        @type = gets.strip.capitalize!
        puts "Here are your list of pets in your location. Please select a pet for more information"
        request = CliAdoptPet::API.new(@zipcode, @type)
        CliAdoptPet::Pet.list_pets
        puts "Select a pet for details"
    end
end