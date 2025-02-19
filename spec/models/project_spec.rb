require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  #user story 3
  describe "contestants on project" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)

    it "counts contestants" do
      expect(news_chic.num_contestants).to eq(2)
    end

    it "calculates average years of experience" do
      expect(news_chic.average_experience).to eq(12.5)
    end

  end

end
