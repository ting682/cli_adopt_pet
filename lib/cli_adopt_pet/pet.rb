class CliAdoptPet::Pet
    @@grn="\e[1;32m"
    @@blu="\e[1;34m"
    @@mag="\e[1;35m"
    @@white="\e[0m"
    attr_reader :name, :breeds, :size, :description, :gender, :status, :email, :house_trained, :spayed_neutered, :personalities, :distance, :address1, :address2, :city, :state, :postcode, :phone, :gender
    @@all = []
    def initialize(attrs)

        @name = attrs["name"]
        @breeds = attrs["breeds"]["primary"]
        #@url = attrs["url"]
        @size = attrs["size"]
        @gender = attrs["gender"]
        @description = attrs["description"].chomp
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
        # attrs["tags"].each {|personality|
        #     binding.pry
        #     @personalities = @personalities + " #{personality}"
        # }
        @phone = attrs["contact"]["phone"]
        
        @address1 = attrs["contact"]["address"]["address1"]
        @address2 = attrs["contact"]["address"]["address2"]
        @city = attrs["contact"]["address"]["city"]
        @state = attrs["contact"]["address"]["state"]
        @postcode = attrs["contact"]["address"]["postcode"]
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
        puts "#{@@blu}Name:#{@@white} #{@pet_profile.name}"
        puts "#{@@blu}Breed:#{@@white} #{@pet_profile.breeds}"
        puts "#{@@blu}Gender:#{@@white} #{@pet_profile.gender}"
        puts "#{@@blu}Description:#{@@white} #{@pet_profile.description}"
        puts "#{@@blu}Status:#{@@white} #{@pet_profile.status}"
        if @pet_profile.gender == "Female"
            puts "#{@@blu}Spayed?:#{@@white} #{@pet_profile.spayed_neutered}"
        else
            puts "#{@@blu}Neutered?:#{@@white} #{@pet_profile.spayed_neutered}"
        end
        
        puts "#{@@blu}Size:#{@@white} #{@pet_profile.size}"
        
        puts "#{@@blu}Personality:#{@@white} #{@pet_profile.personalities}" unless @pet_profile.personalities == ""
        puts "#{@@blu}Distance:#{@@white} #{@pet_profile.distance.ceil} miles"
        puts "#{@@blu}House trained?:#{@@white} #{@pet_profile.house_trained}"
    end
    def self.pet_contact(pet_selected)
        @pet_profile = @@all[pet_selected]
        puts "#{@@grn}Email:#{@@white} #{@pet_profile.email}"
        if @pet_profile.phone == nil
            puts "#{@@grn}No phone number provided.#{@@white}"
        else
            puts "#{@@grn}Phone number:#{@@white} #{@pet_profile.phone}"
        end
        if @pet_profile.address1 == nil
            puts "#{@@grn}No address provided.#{@@white}"
        else
            puts "#{@@grn}Address:#{@@white} #{@pet_profile.address1}"
            puts "         #{@pet_profile.address2}" unless @pet_profile.address2 == nil
            puts "         #{@pet_profile.city}, #{@pet_profile.state} #{@pet_profile.postcode}"
        end

    end
    # def self.find_by_name(name)
    #     @@all.find {|pet| pet.name == name}
    # end
end