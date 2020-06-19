require 'dotenv'


class CliAdoptPet::API
    attr_accessor :type, :breed, :size, :location, :request
    def initialize(location, type)
        @location = location
        @type = type
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
        if resp.include?("Could not determine location")
            puts "Could not determine location. Please try again"
            #CliAdoptPet::CLI.all[0].call
        else
            pets.each {|pet| 
            newPet = CliAdoptPet::Pet.new(pet)
            #binding.pry
            }
        end
        #binding.pry

        
        #binding.pry
    end
end

