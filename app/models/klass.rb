# == Schema Information
#
# Table name: klasses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Klass < ActiveRecord::Base
  has_many :sections
  has_many :students, through: :sections

  validates :name, presence: true

  def houses_count
    {
      "Red" =>    red_count,
      "Yellow" => yellow_count,
      "Blue" =>   blue_count,
      "Green" =>  green_count
    }
  end

private
  def red_count
    students.select{|st| st.house.name == "Red"}.count
  end

  def yellow_count
    students.select{|st| st.house.name == "Yellow"}.count
  end

  def blue_count
    students.select{|st| st.house.name == "Blue"}.count
  end

  def green_count
    students.select{|st| st.house.name == "Green"}.count
  end
end
