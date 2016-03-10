# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  klass_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ActiveRecord::Base
  belongs_to :klass
  has_many :students
  has_many :attendance_registries

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
