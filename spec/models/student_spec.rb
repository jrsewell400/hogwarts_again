require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :house}
  end

  describe 'relationships' do
    it {should have_many :professor_students}
    it {should have_many(:professors).through(:professor_students)}
  end

  describe 'instance methods' do
    it '#count' do
      snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
      hagarid = Professor.create(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      harry = Student.create!(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
      malfoy = Student.create!(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
      longbottom = Student.create!(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

      ProfessorStudent.create!(student: harry, professor: snape)
      ProfessorStudent.create!(student: harry, professor: hagarid)
      ProfessorStudent.create!(student: harry, professor: lupin)
      ProfessorStudent.create!(student: malfoy, professor: hagarid)
      ProfessorStudent.create!(student: malfoy, professor: lupin)
      ProfessorStudent.create!(student: longbottom, professor: snape)

      expect(harry.count).to eq(3)
      expect(malfoy.count).to eq(2)
      expect(longbottom.count).to eq(1)
    end
  end

  describe "class methods" do 
    it ".sort_students" do 
      snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
      hagarid = Professor.create(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      harry = Student.create!(name: "Harry Potter" , age: 10 , house: "Gryffindor" )
      malfoy = Student.create!(name: "Draco Malfoy" , age: 20 , house: "Slytherin" )
      longbottom = Student.create!(name: "Neville Longbottom" , age: 30 , house: "Gryffindor" )

      ProfessorStudent.create!(student: harry, professor: snape)
      ProfessorStudent.create!(student: harry, professor: hagarid)
      ProfessorStudent.create!(student: harry, professor: lupin)
      ProfessorStudent.create!(student: malfoy, professor: hagarid)
      ProfessorStudent.create!(student: longbottom, professor: lupin)
      ProfessorStudent.create!(student: longbottom, professor: snape)

      Student.sort_students.to_a == [malfoy, harry, longbottom]
    end
  end
end
