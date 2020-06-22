require 'dotenv'

@@mag="\e[1;35m"
@@white="\e[0m"
class CliAdoptPet::API
    attr_accessor :type, :breed, :size, :location, :request, :location_valid, :valid_token
    def initialize(location, type)
        @location = location
        @type = type
        @location_valid = true
        @valid_token = true
    end
    def get_listings
        Dotenv.load('file.env')
        #binding.pry
        #puts "#{Dotenv.parse(".env.local", ".env")}"
        resp = HTTParty.get("https://api.petfinder.com/v2/animals?type=#{@type}&location=#{@location}&limit=7&sort=distance", {
            # Some parameters are passed in via query string (eg term & location above - ?term=Spas&location=London) 
            # And some in headers (eg authorization below)
            # This can depend on the API itself - check the documentation if you're not sure where to start.
            headers: {"Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"},
        })
        # binding.pry - this is a great place to debug. See what `resp` is - is it the data you want? 
        #                                               Is it a message saying you forgot some authorization?

        
        #respJSON = JSON.parse(resp.to_s)
        #puts newJSON
        
        pets = resp["animals"]
        #binding.pry
        if resp.include?("Could not determine location")
            puts "#{@@mag}Could not determine location. Please try again.#{@@white}"
            @location_valid = false
            #CliAdoptPet::CLI.all[0].call
        elsif resp.include?("Access token invalid or expired")
            puts "#{@@mag}Access token invalid or expired.#{@@white}"
            @valid_token = false
        else
            @valid_token = true
            @location_valid = true
            pets.each {|pet| 
            newPet = CliAdoptPet::Pet.new(pet)
            #binding.pry
            }
        end
        #binding.pry

        
        #binding.pry
    end
end

