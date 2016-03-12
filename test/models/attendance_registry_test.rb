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

class AttendanceRegistryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
