class CliAdoptPet::Pet
    @@grn="\e[1;32m"
    @@blu="\e[1;34m"
    @@mag="\e[1;35m"
    @@white="\e[0m"
    attr_reader :name, :breeds, :size, :description, :gender, :status, :email, :house_trained, :spayed_neutered, :personalities, :distance, :address1, :address2, :city, :state, :postcode, :phone, :gender, :id
    @@all = []
    def initialize(attrs)

        @name = attrs["name"]
        @breeds = attrs["breeds"]["primary"]
        #@url = attrs["url"]
        @size = attrs["size"]
        @gender = attrs["gender"]
        @description = attrs["description"].gsub(/\s+/, " ")
        @status = attrs["status"]
        @email = attrs["contact"]["email"]
        if attrs["attributes"]["house_trained"]
            @house_trained = "Yes"
        else
            @house_trained = "No"
        end
        if attrs["attributes"]["spayed_neutered"]
            @spayed_neutered = "Yes"
        else
            @spayed_neutered = "No"
        end
        @personalities = attrs["tags"].join(", ")
        @distance = attrs["distance"]
        @phone = attrs["contact"]["phone"]
        
        @address1 = attrs["contact"]["address"]["address1"]
        @address2 = attrs["contact"]["address"]["address2"]
        @city = attrs["contact"]["address"]["city"]
        @state = attrs["contact"]["address"]["state"]
        @postcode = attrs["contact"]["address"]["postcode"]
        save
        @id = @@all.length - 1
        #binding.pry
    end
    def self.all
        @@all
    end
    def save
        @@all << self
    end
    def self.list_pets
        @@all.each_with_index {|pet, index|
            puts "#{index + 1}. #{pet.name}"
        }
    end
    def pet_details
        
        puts "#{@@blu}Name:#{@@white} #{@name}"
        puts "#{@@blu}Breed:#{@@white} #{@breeds}"
        puts "#{@@blu}Gender:#{@@white} #{@gender}"
        puts "#{@@blu}Description:#{@@white} #{@description}"
        puts "#{@@blu}Status:#{@@white} #{@status}"
        if @gender == "Female"
            puts "#{@@blu}Spayed?:#{@@white} #{@spayed_neutered}"
        else
            puts "#{@@blu}Neutered?:#{@@white} #{@spayed_neutered}"
        end
        
        puts "#{@@blu}Size:#{@@white} #{@size}"
        
        puts "#{@@blu}Personality:#{@@white} #{@personalities}" unless @personalities == ""
        puts "#{@@blu}Distance:#{@@white} #{@distance.ceil} miles"
        puts "#{@@blu}House trained?:#{@@white} #{@house_trained}"
    end
    def pet_contact
        
        puts "#{@@grn}Email:#{@@white} #{@email}"
        if @phone == nil
            puts "#{@@grn}No phone number provided.#{@@white}"
        else
            puts "#{@@grn}Phone number:#{@@white} #{@phone}"
        end
        if @address1 == nil
            puts "#{@@grn}No address provided.#{@@white}"
        else
            puts "#{@@grn}Address:#{@@white} #{@address1}"
            puts "         #{@address2}" unless @address2 == nil
            puts "         #{@city}, #{@state} #{@postcode}"
        end

    end
    # def self.find_by_name(name)
    #     @@all.find {|pet| pet.name == name}
    # end
end