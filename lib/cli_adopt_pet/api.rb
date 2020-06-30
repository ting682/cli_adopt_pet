class InvalidAccessToken < StandardError ; end

require 'dotenv'

class CliAdoptPet::API
    @@mag="\e[1;35m"
    @@white="\e[0m"
    attr_accessor :pet_type, :location, :request, :location_valid, :valid_token
    def initialize(location, pet_type)
        @location = location
        @pet_type = pet_type
        @location_valid = true
        
    end
    # #get_listings takes the instance's location and pet type and performs a GET that provides a hash
    def get_listings
        Dotenv.load('file.env')
        #binding.pry
        #attempt get request with pet type, location, limit 7 results, and sort by distance
        resp = HTTParty.get("https://api.petfinder.com/v2/animals?type=#{@pet_type}&location=#{@location}&limit=7&sort=distance", {

            headers: {"Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"},
        })
      
        
        pets = resp["animals"]
        #binding.pry
        #This response only happens when there is a 5 digit number, but the zip code provided is still not valid.
        if resp.include?("Could not determine location")

            puts "#{@@mag}Could not determine location. Please try again.#{@@white}"
            @location_valid = false
            
        elsif resp.include?("Access token invalid or expired")
            #puts "#{@@mag}Access token invalid or expired.#{@@white}"
            raise InvalidAccessToken, "Invalid access token"
            
        else
            
            @location_valid = true

            #iterate each pet hash and instantiate new pet object based on individual attributes
            pets.each {|pet| 
                
                newPet = CliAdoptPet::Pet.new(pet)
                
            }
        end
        

    end
end

