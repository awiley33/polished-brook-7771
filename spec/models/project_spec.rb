require "rails_helper"

RSpec.describe Project, type: :model do

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
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "#avg_experience" do
    it "returns the avg years experience of all contestants that worked on the project" do

      expect(@news_chic.avg_experience).to eq(12.5)
      expect(@boardfit.avg_experience).to eq(8)
      expect(@upholstery_tux.avg_experience).to eq(10)
      expect(@lit_fit.avg_experience).to eq(0)
    end
  end
end
