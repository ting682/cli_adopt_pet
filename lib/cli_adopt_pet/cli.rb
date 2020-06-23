class CliAdoptPet::CLI
    @@mag="\e[1;35m"
    @@white="\e[0m"
    @@valid_numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    def call
        puts "Welcome to adopt a pet CLI!"
        enter_zip_code
        enter_cat_or_dog
        #if both enter_zip_code and enter_cat_dog have valid selections, perform GET request
        request = CliAdoptPet::API.new(@zipcode, @type)
        #binding.pry

        if request.get_listings && request.location_valid == true 
            view_listings

        elsif request.valid_token == false
            #end program
        elsif request.location_valid == false
            #if location is invalid, try again.
            call   
        end

    end
    
    def view_listings
        until @input == "exit"
            puts "Here are your list of pets in your location. Please select a pet for more information"
            CliAdoptPet::Pet.list_pets
            puts "Select a pet for details. If you would like to exit, type 'exit'"
            
            @input = gets.strip
            if @input == "exit"
                break
            else
                @pet_selected = @input.strip.to_i - 1
                #binding.pry
                
                if @pet_selected.between?(0,6)
                    @current_pet = CliAdoptPet::Pet.all[@pet_selected]
                    @current_pet.pet_details 
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
    def view_contact
        #until @input == "exit"

            #binding.pry
            
        @current_pet.pet_contact
        puts "Would you like to view the pet listings again? (y/n)"
        @input = gets.strip.downcase
        if @input == "y"
            view_listings
        elsif @input == "n" || @input == "exit"
            goodbye
            @input = "exit"
            #break
        else
            puts "#{@@mag}Invalid selection. Please try again.#{@@white}"
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
                puts "#{@@mag}Invalid zip code. Please try again.#{@@white}"
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
                puts "#{@@mag}Invalid pet type. Please try again.#{@@white}"
            end
        end
    end

    def view_pet_details
        @current_pet.pet_details 
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

end