class AttendanceRegistry < ActiveRecord::Base
  belongs_to :section

  attr_accessor :absentee_ids
end
