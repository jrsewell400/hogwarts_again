class Student <ApplicationRecord
  validates_presence_of :name, :age, :house

  has_many :professor_students
  has_many :professors, through: :professor_students 

  def count 
    professors.count
  end

  def self.sort_students
    order('name ASC')
  end
end
