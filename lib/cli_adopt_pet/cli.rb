class CliAdoptPet::CLI
    @@valid_numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    def call
        puts "Welcome to adopt a pet CLI!"
        enter_zip_code
        enter_cat_or_dog
        

        
        request = CliAdoptPet::API.new(@zipcode, @type)
        #binding.pry
        if request.get_listings && request.location_valid == true 
            view_listings

        elsif request.valid_token == false
        
        elsif request.location_valid == false
            call   
        end

    end
    
    def view_listings
        until @looking == false
            puts "Here are your list of pets in your location. Please select a pet for more information"
            CliAdoptPet::Pet.list_pets
            puts "Select a pet for details. If you would like to exit, type 'exit'"
            
            @pet_selected = gets.strip
            if @pet_selected == 'exit'
                @looking = false
                next
            else
                @pet_selected = @pet_selected.strip.to_i - 1

                if @pet_selected.between?(0,6)
                    CliAdoptPet::Pet.pet_details(@pet_selected) 
                    view_contact

                else
                    puts "Invalid selection. Please try again."
                    view_listings
                end
            end
        end
    end
    def view_contact
        puts "Would you like to review the contact information? (y/n)"
        @contact = gets.strip.downcase
        #binding.pry
        if @contact == "y"
            CliAdoptPet::Pet.pet_contact(@pet_selected)
            puts "Would you like to view the pet listings again? (y/n)"
            @view_pet_listings = gets.strip.downcase
            if @view_pet_listings == "y"
                view_listings
            elsif @view_pet_listings == "n"
                goodbye
                @looking = false
            end
        elsif @contact == "n"
            puts "Would you like to view the pet listings again? (y/n)"
            @view_pet_listings = gets.strip.downcase
            if @view_pet_listings == "y"
                view_listings
            elsif @view_pet_listings == "n"
                goodbye
                @looking = false
            end
        else
            puts "Invalid selection. Please try again."
            view_contact
        end
    end
    def goodbye
        puts "We hope you found a companion! Have a nice day!"
    end
    def enter_zip_code
        #binding.pry
        @valid_zip_code = false
        until @valid_zip_code == true
            puts "Please enter your zip code."
            @zipcode = gets.strip
            @check_zip_code = @zipcode.split("")
            #binding.pry
            if @check_zip_code.all? {|digit| @@valid_numbers.include?(digit)} && @zipcode.length == 5
                @valid_zip_code = true        
            else
                puts "Invalid zip code. Please try again."
                next
            end
        end
    end
    def enter_cat_or_dog
        @valid_pet_type = false
        until @valid_pet_type == true
            puts "enter cat or dog"
            @type = gets.strip.capitalize!
            if @type == "Cat" || @type == "Dog"
                @valid_pet_type = true
            else
                puts "Invalid pet type. Please try again."
            end
        end
    end
end