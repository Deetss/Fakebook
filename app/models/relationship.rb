class Relationship < ApplicationRecord
    
    belongs_to :requestee, class_name: "User"
    belongs_to :requested, class_name: "User"
    
    def accepted?
        accepted == true
    end
end
