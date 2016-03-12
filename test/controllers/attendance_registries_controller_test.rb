# == Schema Information
#
# Table name: attendance_registries
#
#  id         :integer          not null, primary key
#  date       :date
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AttendanceRegistriesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
