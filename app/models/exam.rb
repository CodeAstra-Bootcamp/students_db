class Exam < ActiveRecord::Base
  belongs_to :student

  attr_accessor :file
end
