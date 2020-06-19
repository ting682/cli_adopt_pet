class CliAdoptPet::Pet
    attr_reader :name, :breeds, :id, :size, :description, :gender, :status, :email, :house_trained, :spayed_neutered, :personalities
    @@all = []
    def initialize(attrs)
        # attrs.each do |k, v|
        #     send("#{k}=", v)
        # end
        @name = attrs["name"]
        @breeds = attrs["breeds"]["primary"]
        @id = attrs["id"]
        @size = attrs["size"]
        @description = attrs["description"]
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
        # attrs["tags"].each {|personality|
        #     binding.pry
        #     @personalities = @personalities + " #{personality}"
        # }
        save
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
    def self.pet_details(pet_selected)
        @pet_profile = @@all[pet_selected]
        puts "Name: #{@pet_profile.name}"
        puts "Breed: #{@pet_profile.breeds}"
        puts "Description: #{@pet_profile.description}"
        puts "Status: #{@pet_profile.status}"
        puts "Spayed or neutered: #{@pet_profile.spayed_neutered}"
        puts "Size: #{@pet_profile.size}"
        puts "Email: #{@pet_profile.email}"
        puts "Personality: #{@pet_profile.personalities}"
    end
end