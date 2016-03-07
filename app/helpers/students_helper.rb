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

module StudentsHelper
  def student_house_label_class(student)
    house_name = student.house.name
    class_names = {
      "Yellow" => "warning",
      "Red"    => "danger",
      "Blue"   => "primary",
      "Green"  => "success"
    }

    return class_names[house_name]
  end
end
