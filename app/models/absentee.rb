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

require 'messenger_service'

class Absentee < ActiveRecord::Base
  belongs_to :attendance_registry
  belongs_to :student

  # after_create :send_absent_notification!
  # after_destroy :send_present_notification!

private
  def send_absent_notification!
    student = self.student
    msg = ""
    msg += "Dear Guardian, "
    msg += "FYI, your ward, #{student.name}, has not come to the school today."
    msg += "Regards, Code Astra Talent School"
    MessengerService.new.send_sms("+18325326571", student.phone, msg)
  end

  def send_present_notification!
    student = self.student
    msg = ""
    msg += "Dear Guardian, "
    msg += "FYI, your ward, #{student.name}, is at the school now."
    msg += "Regards, Code Astra Talent School"
    MessengerService.new.send_sms("+18325326571", student.phone, msg)
  end
end
