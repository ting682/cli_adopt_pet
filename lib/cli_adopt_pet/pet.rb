class CliAdoptPet::Pet
    attr_accessor :name, :breeds, :id, :size, :description, :gender
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
end