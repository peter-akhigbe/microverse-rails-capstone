# spec/requests/entities_spec.rb
require 'rails_helper'

RSpec.describe "Entities", type: :request do
  let(:user) { User.create(name: 'Peter', email: 'peter@gmail.com', password: 'password') }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders the index template" do
      group = Group.create!(name: 'home', icon: 'icon', user: user)
      entity = Entity.create!(name: 'table', amount: 10.0, author: user)

      get group_entities_path(group)

      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      group = Group.create!(name: 'home', icon: 'icon', user: user)
      entity = Entity.create!(name: 'table', amount: 10.0, author: user)

      get group_entity_path(group, entity)

      expect(response).to render_template(:show)
      expect(response.body).to include(entity.name)
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      group = Group.create!(name: 'home', icon: 'icon', user: user)

      get new_group_entity_path(group)

      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do
    it "creates a new entity and redirects to show page" do
      group = Group.create!(name: 'home', icon: 'icon', user: user)

      entity_params = {
        name: 'table',
        amount: 10.0,
        author_id: user.id
      }

      expect {
        post group_entities_path(group), params: { entity: entity_params }
      }.to change(Entity, :count).by(1)
    end
  end
end
