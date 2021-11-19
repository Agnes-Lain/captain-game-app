require 'rails_helper'
begin
  require "fighters_controller"
rescue LoadError
end

if defined?(FightersController)
  RSpec.describe FightersController, :type => :controller do

    let(:valid_attributes) do
      {
        name: "MeatBoy",
        life_points: 35,
        attack_points: 5,
        img_url: "https://avatarfiles.alphacoders.com/161/thumb-161317.png"
      }
    end

    let(:invalid_attributes) do
      { name: "" }
    end

    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all fighters as @fighters" do
        fighter = Fighter.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:fighters)).to eq([fighter])
      end
    end

    describe "GET show" do
      it "assigns the requested fighter as @fighter" do
        fighter = Fighter.create! valid_attributes
        get :show, params: {:id => fighter.to_param}, session: valid_session
        expect(assigns(:fighter)).to eq(fighter)
      end
    end

    describe "GET new" do
      it "assigns a new fighter as @fighter" do
        get :new, params: {}, session: valid_session
        expect(assigns(:fighter)).to be_a_new(Fighter)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Fighter" do
          expect {
            post :create, params: {:fighter => valid_attributes}, session: valid_session
          }.to change(Fighter, :count).by(1)
        end

        it "assigns a newly created fighter as @fighter" do
          post :create, params: {:fighter => valid_attributes}, session: valid_session
          expect(assigns(:fighter)).to be_a(Fighter)
          expect(assigns(:fighter)).to be_persisted
        end

        it "redirects to the created fighter" do
          post :create, params: {:fighter => valid_attributes}, session: valid_session
          expect(response).to redirect_to(Fighter.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved fighter as @fighter" do
          post :create, params: {:fighter => invalid_attributes}, session: valid_session
          expect(assigns(:fighter)).to be_a_new(Fighter)
        end

        it "re-renders the 'new' template" do
          post :create, params: {:fighter => invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

else
  describe "FightersController" do
    it "should exist" do
      expect(defined?(FightersController)).to eq(true)
    end
  end
end
