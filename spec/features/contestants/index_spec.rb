require 'rails_helper'

RSpec.describe "contestants index page" do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
  
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
  
    @cp_1 = ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    @cp_2 = ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    @cp_3 = ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    @cp_4 = ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    @cp_5 = ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    @cp_6 = ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  it "displays a list of all contestant names" do
    visit "/contestants"

    expect(page).to have_content("Jay McCarroll")
    expect(page).to have_content("Erin Robertson")
    expect(page).to have_content("Gretchen Jones")
    expect(page).to have_content("Kentaro Kameyama")
    expect(page).to_not have_content("Anna Wiley")
    expect(page).to_not have_content("Recycled Material")
  end

  it "displays a list of the contestants project names" do
    visit "/contestants"
    
    expect(page).to_not have_content("Litfit")
    expect(page).to have_content("Projects: News Chic, Upholstery Tuxedo")
    expect(page).to have_content("Projects: Boardfit, Upholstery Tuxedo")
  end
end