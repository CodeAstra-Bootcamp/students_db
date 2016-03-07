# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  section_id   :integer
#  name         :string
#  fathers_name :string
#  gender       :integer
#  email        :string
#  dob          :date
#  phone        :string
#  address      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  house_id     :integer
#  roll_number  :integer
#

class Student < ActiveRecord::Base
  module Gender
    MALE   = {code: 1, label: "Male"}
    FEMALE = {code: 2, label: "Female"}

    def self.label(code)
      if code == MALE[:code]
        return MALE[:label]
      else
        return FEMALE[:label]
      end
    end

    def self.all
      [MALE, FEMALE].collect{|hsh| OpenStruct.new(hsh)}
    end
  end

  belongs_to :section
  belongs_to :house
end
