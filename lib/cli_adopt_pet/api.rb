require 'dotenv'


class CliAdoptPet::API
    def self.get_listings
        Dotenv.load('file.env')
        #binding.pry
        #puts "#{Dotenv.parse(".env.local", ".env")}"
        resp = HTTParty.get("https://api.petfinder.com/v2/animals?type=dog&location=31407", {
            # Some parameters are passed in via query string (eg term & location above - ?term=Spas&location=London) 
            # And some in headers (eg authorization below)
            # This can depend on the API itself - check the documentation if you're not sure where to start.
            headers: {"Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"},
        })
        # binding.pry - this is a great place to debug. See what `resp` is - is it the data you want? 
        #                                               Is it a message saying you forgot some authorization?
        #spas = resp["businesses"]
        #LondonSpas::Spa.new_from_collection(spas)
        
        newJSON = JSON.parse(resp.to_s)
        #puts newJSON
        binding.pry
    end
end

