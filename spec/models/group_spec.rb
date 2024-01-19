# spec/models/group_spec.rb
require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'Peter', email: 'peter@gmail.com', password: 'password') }

  it "is valid with valid attributes" do
    group = Group.new(name: "Example Group", icon: "example_icon", user: user)
    expect(group).to be_valid
  end

  it "is not valid without a name" do
    group = Group.new(icon: "example_icon", user: user)
    expect(group).not_to be_valid
  end

  it "is not valid without an icon" do
    group = Group.new(name: "Example Group", user: user)
    expect(group).not_to be_valid
  end

  it "is not valid without a user" do
    group = Group.new(name: "Example Group", icon: "example_icon")
    expect(group).not_to be_valid
  end

  it "belongs to a user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it "has many group_entities" do
    association = described_class.reflect_on_association(:group_entities)
    expect(association.macro).to eq :has_many
  end

  it "has many entities through group_entities" do
    association = described_class.reflect_on_association(:entities)
    expect(association.macro).to eq :has_many
    expect(association.options[:through]).to eq :group_entities
  end

  it "destroys associated group_entities when destroyed" do
    group = Group.create!(name: 'home', icon: 'icon', user: user)
    entity = Entity.create!(name: 'table', amount: 10.0, author: user)
    group_entity = GroupEntity.create(group_id: group.id, entity_id: entity.id)

    expect { group.destroy }.to change { GroupEntity.count }.by(-1)
  end
end
