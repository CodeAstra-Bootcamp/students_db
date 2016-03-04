class Section < ActiveRecord::Base
  belongs_to :klass
  has_many :students
end
