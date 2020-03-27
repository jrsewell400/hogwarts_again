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
  end 
end 