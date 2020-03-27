require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit the Professors Show page /professors/:id" do 
    it "then I see a list of the names of the students the professors have." do 
      snape = Professor.create!(name: "Severus Snape", age: 45, specialty: "Potions")
      hagarid = Professor.create!(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create!(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      harry = Student.create!(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
      malfoy = Student.create!(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
      longbottom = Student.create!(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

      ProfessorStudent.create!(student: harry, professor: snape)
      ProfessorStudent.create!(student: harry, professor: hagarid)
      ProfessorStudent.create!(student: harry, professor: lupin)
      ProfessorStudent.create!(student: malfoy, professor: hagarid)
      ProfessorStudent.create!(student: malfoy, professor: lupin)
      ProfessorStudent.create!(student: longbottom, professor: snape)

      visit "/professors/#{snape.id}"

      expect(page).to have_content(harry.name)
      expect(page).to have_content(longbottom.name)
      expect(page).to have_no_content(malfoy.name)
    end 

    it "then I see the average age of all students for that professor." do
      snape = Professor.create!(name: "Severus Snape", age: 45, specialty: "Potions")
      hagarid = Professor.create!(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create!(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      harry = Student.create!(name: "Harry Potter" , age: 10 , house: "Gryffindor" )
      malfoy = Student.create!(name: "Draco Malfoy" , age: 20 , house: "Slytherin" )
      longbottom = Student.create!(name: "Neville Longbottom" , age: 30 , house: "Gryffindor" )

      ProfessorStudent.create!(student: harry, professor: snape)
      ProfessorStudent.create!(student: harry, professor: hagarid)
      ProfessorStudent.create!(student: harry, professor: lupin)
      ProfessorStudent.create!(student: malfoy, professor: hagarid)
      ProfessorStudent.create!(student: malfoy, professor: lupin)
      ProfessorStudent.create!(student: longbottom, professor: snape)

      visit "/professors/#{snape.id}"
      
      expect(page).to have_content(20)

      visit "/professors/#{hagarid.id}"

      expect(page).to have_content(15)

      visit "/professors/#{lupin.id}"

      expect(page).to have_content(15)
    end
  end 
end 