# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  student_id  :integer
#  english     :integer
#  hindi       :integer
#  mathematics :integer
#  science     :integer
#  social      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
