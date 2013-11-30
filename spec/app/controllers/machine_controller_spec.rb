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
    context 'when valid machine id is passed' do
      before do
        get '/machine/musics/1.json'
      end
      it 'returns correct array as JSON' do
        machine = Machine.find(1)
        expect(last_response.body).to eq machine.musics.to_json
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
    context 'when valid machine id is passed' do
      before do
        get '/machine/musics/1/201311.json'
      end
      it 'returns correct array' do
        machine = Machine.find(1)
        expect(last_response.body).to eq machine.current_musics(201311).to_json
      end
    end
    context 'when invalid machine id is passed' do
      before do
        get '/machine/musics/999999/201311.json'
      end
      it 'returns 404 Not Found' do
        expect(last_response.status).to eq 404
      end
    end
  end
end
