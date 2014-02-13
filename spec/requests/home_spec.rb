require 'spec_helper'

describe "Home" do
  describe "GET /" do
    context "if we aren't in the season" do
      it "works" do
        get root_path
        expect(response.status).to eq 200
        expect(response).to render_template(:index)
        expect(response.body).not_to include("We are now in the season")
      end
    end
    context "if we are in the season" do
      it 'works' do
        create(:season)
        get root_path
        expect(response.status).to eq 200
        expect(response).to render_template(:index)
        expect(response.body).to include("We are now in the season")
      end
    end
  end
end
