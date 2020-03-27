require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit '/students" do 
    it "then I see a list of courses and the number of professors each student has." do 
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

      visit "/students"

      within "#student-#{harry.id}" do 
        expect(page).to have_content(3)
        expect(page).to have_content("Potions")
        expect(page).to have_content("Care of Magical Creatures")
        expect(page).to have_content("Defense Against The Dark Arts")
      end

      within "#student-#{malfoy.id}" do 
        expect(page).to have_content(2)
        expect(page).to have_content("Care of Magical Creatures")
        expect(page).to have_content("Defense Against The Dark Arts")
      end

      within "#student-#{longbottom.id}" do 
        expect(page).to have_content(1)
        expect(page).to have_content("Potions")
      end
    end

    it "then I see all students listed alphabetically." do 
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

      visit "/students"

      expect(page.all('.students')[0]).to have_content(malfoy.name)
      expect(page.all('.students')[1]).to have_content(harry.name)
      expect(page.all('.students')[2]).to have_content(longbottom.name)
    end 
  end 
end 