require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do 
  describe "when I visit the Professors Index page /professors" do 
    it "then I see a list of each professor's name, age, and specialty." do 
      snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
      hagarid = Professor.create(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      visit "/professors"

      within "#professor-#{snape.id}" do 
        expect(page).to have_content(snape.name)
        expect(page).to have_content(snape.age)
        expect(page).to have_content(snape.specialty)
      end

      within "#professor-#{hagarid.id}" do 
        expect(page).to have_content(hagarid.name)
        expect(page).to have_content(hagarid.age)
        expect(page).to have_content(hagarid.specialty)
      end

      within "#professor-#{lupin.id}" do 
        expect(page).to have_content(lupin.name)
        expect(page).to have_content(lupin.age)
        expect(page).to have_content(lupin.specialty)
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

      visit "/professors"
      
      expect(page.all('.individual-professors')[0]).to have_content(lupin.name)
      expect(page.all('.individual-professors')[1]).to have_content(hagarid.name)
      expect(page.all('.individual-professors')[2]).to have_content(snape.name)
    end
  end 
end 