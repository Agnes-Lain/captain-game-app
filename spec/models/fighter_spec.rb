require 'rails_helper'

RSpec.describe "Fighter", :type => :model do
  let(:valid_attributes) do
    {
      name: "MeatBoy",
      life_points: 35,
      attack_points: 5
    }
  end

  it "has a name" do
    fighter = Fighter.new(valid_attributes)
    expect(fighter.name).to eq("MeatBoy")
  end

  it "raises an error if a fighter are not existing" do
    expect {
      Fighter.find(999)
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "has its name cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:name)
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "life_points cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:life_points)
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "life_points cannot be float" do
    attributes = valid_attributes
    attributes[:life_points] = 40.5
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "life_points above range is not a valid value" do
    attributes = valid_attributes
    attributes[:life_points] = 51
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "life_points under range is not a valid value" do
    attributes = valid_attributes
    attributes[:life_points] = 29
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "life_points in the range is a valid value" do
    attributes = valid_attributes
    fighter = Fighter.new(attributes)
    expect(fighter).to be_valid
  end

  it "attack_points cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:attack_points)
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "attack_points cannot be float" do
    attributes = valid_attributes
    attributes[:attack_points] = 3.3
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "attack_points above range is not a valid value" do
    attributes = valid_attributes
    attributes[:attack_points] = 7
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

   it "attack_points under range is not a valid value" do
    attributes = valid_attributes
    attributes[:attack_points] = 1
    fighter = Fighter.new(attributes)
    expect(fighter).not_to be_valid
  end

  it "attack_points in the range is a valid value" do
    attributes = valid_attributes
    fighter = Fighter.new(attributes)
    expect(fighter).to be_valid
  end

  # it "has many reviews" do
  #   restaurant = Restaurant.new(valid_attributes)
  #   expect(restaurant).to respond_to(:reviews)
  # end

  # it "should destroy child reviews when destroying self" do
  #   restaurant = Restaurant.create!(valid_attributes)
  #   3.times { restaurant.reviews.create! content: "great!", rating: 5 }
  #   expect { restaurant.destroy }.to change { Review.count }.from(3).to(0)
  # end
end
