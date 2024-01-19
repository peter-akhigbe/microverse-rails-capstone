# /spec/requests/groups_spec.rb
require 'rails_helper'

RSpec.describe "Groups", type: :request do
  let(:user) { User.create(name: 'Peter', email: 'peter@gmail.com', password: 'password') }

  before do
    sign_in user
  end

  describe "GET /groups" do
    it "renders the index template" do
      get groups_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /groups/:id" do
    let(:group) { Group.create!(name: 'home', icon: 'icon', user: user) }

    it "renders the show template" do
      get group_path(group)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /groups/new" do
    it "renders the new template" do
      get new_group_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /groups" do
    it "creates a new group" do
      expect {
        post groups_path, params: { group: { name: "New Group", icon: "home" } }
      }.to change(Group, :count).by(1)

      expect(response).to redirect_to(groups_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
      expect(flash[:notice]).to be_present
    end
  end

  describe "GET /groups/:id/edit" do
    let(:group) { Group.create!(name: 'home', icon: 'icon', user: user) }

    it "renders the edit template" do
      get edit_group_path(group)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /groups/:id" do
    let(:group) { Group.create!(name: 'home', icon: 'icon', user: user) }

    it "updates the group" do
      patch group_path(group), params: { group: { name: "Updated Group" } }
      expect(response).to redirect_to(group_path(group))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
      expect(flash[:notice]).to be_present
      expect(group.reload.name).to eq("Updated Group")
    end
  end

  describe "DELETE /groups/:id" do
    let!(:group) { Group.create!(name: 'home', icon: 'icon', user: user) }

    it "destroys the group" do
      expect {
        delete group_path(group)
      }.to change(Group, :count).by(-1)

      expect(response).to redirect_to(groups_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
      expect(flash[:notice]).to be_present
    end
  end
end
