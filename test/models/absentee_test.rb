# == Schema Information
#
# Table name: absentees
#
#  id                     :integer          not null, primary key
#  student_id             :integer
#  attendance_registry_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class AbsenteeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
