# /spec/models/entity_spec.rb
require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe 'validations' do
    it 'requires presence of name' do
      entity = Entity.new(amount: 10)
      expect(entity).not_to be_valid
      expect(entity.errors[:name]).to include("can't be blank")
    end

    it 'requires presence of amount' do
      entity = Entity.new(name: 'Example')
      expect(entity).not_to be_valid
      expect(entity.errors[:amount]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      is_expected.to belong_to(:author).class_name('User').with_foreign_key('author_id')
    end

    it 'has many group_entities' do
      is_expected.to have_many(:group_entities).dependent(:destroy)
    end

    it 'has many groups through group_entities' do
      is_expected.to have_many(:groups).through(:group_entities).dependent(:destroy)
    end
  end

  describe 'instance methods' do
    it 'returns author object' do
      user = User.create(name: 'Peter', email: 'peter@gmail.com', password: 'password')
      entity = Entity.new(author_id: user.id, name: 'Example', amount: 10)
      expect(entity.author).to be_a(User)
    end
  end

  describe 'associations through instance methods' do
    it 'has many group_entities' do
      entity = Entity.new(name: 'Example', amount: 10)
      group_entity = GroupEntity.new(group: Group.new, entity: entity)
      entity.group_entities << group_entity
      entity.save

      expect(entity.group_entities).to include(group_entity)
    end

    it 'has many groups through group_entities' do
      entity = Entity.new(name: 'Example', amount: 10)
      group = Group.new(name: 'Example Group')
      group_entity = GroupEntity.new(group: group, entity: entity)
      entity.group_entities << group_entity
      entity.save

      expect(entity.groups).to include(group)
    end
  end
end
