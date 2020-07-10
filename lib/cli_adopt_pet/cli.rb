class CliAdoptPet::CLI

    @@grn="\e[1;32m"
    @@blu="\e[1;34m"
    @@mag="\e[1;35m"
    @@white="\e[0m"
    @@valid_numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    def call
        puts "Welcome to adopt a pet CLI!"
        enter_zip_code
        enter_cat_or_dog
        #if both enter_zip_code and enter_cat_dog have valid selections, instantiate then perform GET request
        request = CliAdoptPet::API.new(@zipcode, @pet_type)
        #binding.pry

        if request.get_listings && request.location_valid == true 
            view_listings


        elsif request.location_valid == false
            #if location is invalid, try again.
            call   
        end

    end
    # #view_listings method reviews the list of pets and checks if the user would like to view pet details
    def view_listings

        until @input == "exit"
            puts "Here are your list of pets in your location. Please select a pet for more information"
            list_pets
            puts "Select a pet for details. If you would like to exit, type 'exit'"
            
            @input = gets.strip
            if @input == "exit"
                break
            else
                @pet_selected = @input.strip.to_i - 1
                #binding.pry
                
                if @pet_selected.between?(0,6)
                    @current_pet = CliAdoptPet::Pet.all[@pet_selected]
                    pet_details(@current_pet)
                    puts "Would you like to review the contact information? (y/n)"
                    @input = gets.strip.downcase
                    if @input == "y"
                        view_contact
                    elsif @input == "n"
                        ask_pet_listings
                    elsif @input == "exit"
                        goodbye
                    else
                        puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
                        view_pet_details
                    end
                else
                    puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
                    view_pet_details
                end
            end
        end
        
    end
    # #view_contact shows the contact information in order to adopt the individual pet and provides the option of viewing the pet listings again.
    def view_contact
            
        pet_contact(@current_pet)
        puts "Would you like to view the pet listings again? (y/n)"
        @input = gets.strip.downcase
        if @input == "y"
            view_listings
        elsif @input == "n" || @input == "exit"
            goodbye
            @input = "exit"
            
        else
            puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
            view_contact
        end

    end
    def goodbye
        puts "We hope you found a companion! Have a nice day!"
    end
    # #enter_zip_code requests the user to provide a zip code. If the zip code is not a 5 digit number, the user is asked to re-enter a valid zip code.
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
                puts "#{@@mag}Invalid zip code. Please try again.#{@@white}"
                next
            end
        end
    end
    # #enter_cat_or_dog requests the user to enter a cat or dog as the pet to adopt. 
    def enter_cat_or_dog
        @valid_pet_type = false
        until @valid_pet_type == true
            puts "enter cat or dog"
            @pet_type = gets.strip.downcase
            if @pet_type == "cat" || @pet_type == "dog"
                @valid_pet_type = true
            else
                puts "#{@@mag}Invalid pet type. Please try again.#{@@white}"
            end
        end
    end
    # #view_pet_details allows the user to view the individual pet's profile then asks whether or not the user would like to review the contact information for the pet.
    def view_pet_details
        pet_details(@current_pet)
        puts "Would you like to review the contact information? (y/n)"
        @input = gets.strip.downcase
        if @input == "y"
            view_contact
        elsif @input == "n"
            ask_pet_listings
            #break
        elsif @input == "exit"
            goodbye
        else
            puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
            view_pet_details
        end
    end
    # #ask_pet_listings asks the user whether they would like to view the overall pet listings for their area.
    def ask_pet_listings
        puts "Would you like to view the pet listings? (y/n)"
        @input = gets.strip.downcase
        if @input == "y"
            view_listings
        elsif @input == "n" || @input == "exit"
            goodbye
            @input = "exit"
        else
            puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
            ask_pet_listings
        end
    end

    def list_pets
            CliAdoptPet::Pet.all.each_with_index {|pet, index|
            puts "#{index + 1}. #{pet.name}"
        }
    end
    def pet_details(pet)
        
        puts "#{@@blu}Name:#{@@white} #{pet.name}"
        puts "#{@@blu}Breed:#{@@white} #{pet.breeds}"
        puts "#{@@blu}Gender:#{@@white} #{pet.gender}"
        puts "#{@@blu}Description:#{@@white} #{pet.description}"
        puts "#{@@blu}Status:#{@@white} #{pet.status}"
        if @gender == "Female"
            puts "#{@@blu}Spayed?:#{@@white} #{pet.spayed_neutered}"
        else
            puts "#{@@blu}Neutered?:#{@@white} #{pet.spayed_neutered}"
        end
        
        puts "#{@@blu}Size:#{@@white} #{pet.size}"
        
        puts "#{@@blu}Personality:#{@@white} #{pet.personalities}" unless pet.personalities == "" || pet.personalities == nil
        puts "#{@@blu}Distance:#{@@white} #{pet.distance.ceil} miles"
        puts "#{@@blu}House trained?:#{@@white} #{pet.house_trained}"
    end
    def pet_contact(pet)
        
        puts "#{@@grn}Email:#{@@white} #{pet.email}"
        if @phone == nil
            puts "#{@@grn}No phone number provided.#{@@white}"
        else
            puts "#{@@grn}Phone number:#{@@white} #{pet.phone}"
        end
        if @address1 == nil
            puts "#{@@grn}No address provided.#{@@white}"
        else
            puts "#{@@grn}Address:#{@@white} #{pet.address1}"
            puts "         #{pet.address2}" unless pet.address2 == nil
            puts "         #{pet.city}, #{pet.state} #{pet.postcode}"
        end

    end
end