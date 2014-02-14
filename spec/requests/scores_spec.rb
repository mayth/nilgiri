require 'spec_helper'

describe "Scores" do
  describe "GET /scores" do
    context 'if the current season is unavailable' do
      it "shows the message instead of scores and seasons' name" do
        get scores_path
        expect(response.status).to eq 200
        expect(response.body).to include "We're going on a short trip"
      end
    end
    context 'if the current season is available' do
      before do
        @season = create(:season)
      end
      context 'if no scores registered' do
        before do
          get scores_path
        end
        it 'succeeds' do
          expect(response.status).to eq 200
        end
        it "shows the season's name" do
          expect(response.body).to include @season.name
        end
        it "shows the message instead of scores" do
          expect(response.body).to include "No scores"
        end
      end
      context 'if some scores registered' do
        before do
          @score = create(:score, season: @season)
          get scores_path
        end
        it "succeeds" do
          expect(response.status).to eq 200
        end
        it "shows the season's name" do
          expect(response.body).to include @season.name
        end
        it "shows the scores" do
          expect(response.body).to include @score.player.name
          expect(response.body).to include @score.music.name
          expect(response.body).to include @score.score.to_s
        end
      end
    end
  end
end
