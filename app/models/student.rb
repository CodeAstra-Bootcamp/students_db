class Student < ActiveRecord::Base
  module Gender
    MALE = 1
    FEMALE = 2

    def self.all
      [MALE, FEMALE]
    end
  end

  belongs_to :section
  belongs_to :house
end
