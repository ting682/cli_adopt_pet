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
        
        #@personalities = attrs["tags"].join(", ")
        @personalities = to_sentence(attrs["tags"])
        #binding.pry
        @distance = attrs["distance"]
        @phone = attrs["contact"]["phone"]
        
        @address1 = attrs["contact"]["address"]["address1"]
        @address2 = attrs["contact"]["address"]["address2"]
        @city = attrs["contact"]["address"]["city"]
        @state = attrs["contact"]["address"]["state"]
        @postcode = attrs["contact"]["address"]["postcode"]
        
        @id = @@all.length - 1
        save
        #binding.pry
    end
    def self.all
        @@all
    end
    def save
        @@all << self
    end

    # #to_sentence takes the personalities and forms it into a sentence.
    def to_sentence(array)
        
        case array.length

        when 2
            array[1] = array[1].downcase
            array.join(" and ")
        
        when 3..10
            #array_copy = array
            array_return = []
            array[-1] = "and #{array[-1]}"
            array.map.with_index(1) do |element, index|
                
                if index == 1
                    element
                else
                    element.downcase
                end
                
            end.join(', ')
            
            
        end
    end
end

