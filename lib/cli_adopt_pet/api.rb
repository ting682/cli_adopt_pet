class InvalidAccessToken < StandardError ; end

require 'dotenv'

class CliAdoptPet::API
    @@mag="\e[1;35m"
    @@white="\e[0m"
    attr_accessor :type, :breed, :size, :location, :request, :location_valid, :valid_token
    def initialize(location, type)
        @location = location
        @type = type
        @location_valid = true
        
    end
    def get_listings
        Dotenv.load('file.env')
        #binding.pry
        #attempt get request with pet type, location, limit 7 results, and sort by distance
        resp = HTTParty.get("https://api.petfinder.com/v2/animals?type=#{@type}&location=#{@location}&limit=7&sort=distance", {

            headers: {"Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"},
        })
      
        
        pets = resp["animals"]
        #binding.pry
        if resp.include?("Could not determine location")

            puts "#{@@mag}Could not determine location. Please try again.#{@@white}"
            @location_valid = false
            
        elsif resp.include?("Access token invalid or expired")
            #puts "#{@@mag}Access token invalid or expired.#{@@white}"
            raise InvalidAccessToken, "Invalid access token"
            
        else
           
            @location_valid = true
            pets.each {|pet| 
            newPet = CliAdoptPet::Pet.new(pet)
            #binding.pry
            }
        end
        #binding.pry

    end
end

