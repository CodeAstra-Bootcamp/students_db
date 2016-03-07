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

require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
