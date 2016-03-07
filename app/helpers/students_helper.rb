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
  COLOR_TO_CLASS = {
    "Yellow" => "warning",
    "Red"    => "danger",
    "Blue"   => "primary",
    "Green"  => "success"
  }

  def student_house_label_class(student)
    house_name = student.house.name

    return COLOR_TO_CLASS[house_name]
  end

  # Sample argument:
  #   {"Yellow": 3, "Red": 4, "Blue": 6, "Green": 13}
  def house_counts_tag(hsh)
    str = ""
    hsh.each do |house_name, house_count|
      str += content_tag(:span, house_count,    class: "label label-#{COLOR_TO_CLASS[house_name]} pull-right")
    end

    raw(str)
  end
end
