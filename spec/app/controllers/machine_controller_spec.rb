require 'spec_helper'

describe "MachineController" do
  describe 'difficulties' do
    context 'when valid id is passed' do
      before do
        get '/machine/difficulties/1.json'
      end
      it 'returns correct difficulty array' do
        machine = Machine.find(1)
        expect(JSON.parse(last_response.body)).to eq machine.difficulties
      end
    end
    context 'when invalid id is passed' do
      before do
        get '/machine/difficulties/999999.json'
      end
      it 'returns 404 Not found' do
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'playstyles' do
    context 'when valid id is passed' do
      context 'for machines whose players can select their play style' do
        before do
          get '/machine/playstyles/1.json'  # beatmania IIDX
          @machine = Machine.find(1)
        end
        it 'returns correct difficulty array' do
          expect(JSON.parse(last_response.body)).to eq @machine.playstyles
        end
      end
      context 'for machines whose players cannot select their play style' do
        before do
          get '/machine/playstyles/2.json'  # pop'n
        end
        it 'returns null' do
          expect(last_response.body).to eq 'null'
        end
      end
    end
    context 'when invalid id is passed' do
      before do
        get '/machine/playstyles/999999.json'
      end
      it 'returns 404 Not found' do
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'get musics' do
    before :all do
      @season = Season.create(
        name: "season #{rand}",
        start: Time.now,
        expiry: Time.now.next_month
      )
      @machine = Machine.find(1)
      @machine.musics.create(
        season: @season,
        name: 'sample 1',
        artist: 'sample 1 artist'
      )
      @machine.musics.create(
        season: @season,
        name: 'sample 2',
        artist: 'sample 2 artist'
      )
    end
    context 'when valid machine id is passed' do
      before do
        get "/machine/musics/#{@machine.id}.json"
      end
      it 'returns correct array as JSON' do
        expect(last_response.body).to eq @machine.musics.to_json
      end
    end
    context 'when invalid machine id is passed' do
      before do
        get '/machine/musics/999999.json'
      end
      it 'returns 404 Not Found' do
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'get musics for specified season' do
    before :all do
      @season = Season.create(
        name: "season #{rand}",
        start: Time.now,
        expiry: Time.now.next_month
      )
      @machine = Machine.find(1)
      @machine.musics.create(
        season: @season,
        name: 'sample 1',
        artist: 'sample 1 artist'
      )
      @machine.musics.create(
        season: @season,
        name: 'sample 2',
        artist: 'sample 2 artist'
      )
    end
    context 'when valid machine id is passed' do
      before do
        get "/machine/musics/#{@machine.id}/#{@season.id}.json"
      end
      it 'returns correct response' do
        expect(last_response.body).to eq @machine.musics_for(@season).to_json
      end
    end
    context 'when invalid machine id is passed' do
      before do
        get '/machine/musics/999999/1.json'
      end
      it 'returns 404 Not Found' do
        expect(last_response.status).to eq 404
      end
    end
  end
end
