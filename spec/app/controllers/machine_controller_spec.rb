require 'spec_helper'

describe "MachineController" do
  describe 'difficulties' do
    context 'when valid id is passed' do
      before do
        get '/machine/difficulties/1.js'
      end
      it 'returns correct difficulty array' do
        machine = Machine.find(1)
        expect(JSON.parse(last_response.body)).to eq machine.difficulties
      end
    end
    context 'when invalid id is passed' do
      before do
        get '/machine/difficulties/999999.js'
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
          get '/machine/playstyles/1.js'  # beatmania IIDX
          @machine = Machine.find(1)
        end
        it 'returns correct difficulty array' do
          expect(JSON.parse(last_response.body)).to eq @machine.playstyles
        end
      end
      context 'for machines whose players cannot select their play style' do
        before do
          get '/machine/playstyles/2.js'  # pop'n
        end
        it 'returns null' do
          expect(last_response.body).to eq 'null'
        end
      end
    end
    context 'when invalid id is passed' do
      before do
        get '/machine/playstyles/999999.js'
      end
      it 'returns 404 Not found' do
        expect(last_response.status).to eq 404
      end
    end
  end
end
