# == Schema Information
#
# Table name: absentees
#
#  id                     :integer          not null, primary key
#  student_id             :integer
#  attendence_registry_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Absentee < ActiveRecord::Base
  belongs_to :attendance_registry
  belongs_to :student

  after_create :send_absent_notification!
  after_destroy :send_present_notification!

private
  def send_absent_notification!
    puts ">>>>> Send ABSENT notification SMS to #{self.student.phone}"
  end

  def send_present_notification!
    puts ">>>>> Send PRESENT notification SMS to #{self.student.phone}"    
  end
end
