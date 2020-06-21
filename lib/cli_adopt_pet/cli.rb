class CliAdoptPet::CLI

    def call
        puts "Welcome to pet finder!"
        puts "enter zip code"
        @zipcode = gets.strip
        puts "enter cat or dog"
        @type = gets.strip.capitalize!
        request = CliAdoptPet::API.new(@zipcode, @type)
        if request.get_listings
            view_listings
            #until @looking == false 
                # puts "Would you like to review another pet? (y/n)"
                # @review_again = gets.strip.downcase

                
                # if @review_again == "y"
                #     CliAdoptPet::Pet.list_pets
                #     puts "Select a pet for details"
                #     @pet_selected = gets.strip.to_i - 1
                #     #binding.pry
                #     if @pet_selected.between?(0,6)
                #         CliAdoptPet::Pet.pet_details(@pet_selected) 
                #     else
                #         puts "Invalid selection. Please try again."
                #     end
                    
                # else
                #     @looking = false
                # end
            #end
        else
            self.call
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
end