require 'spec_helper'

describe Season do
  describe 'create' do
    context 'when the valid input is given' do
      it 'should be saved' do
        expect(build(:season).save).to be_true
      end
    end
    context 'when the invalid input is given' do
      it 'fails if the name is empty' do
        expect(build(:season, name: '').save).to be_false
      end
      it 'fails if the start is nil' do
        expect(build(:season, start: nil).save).to be_false
      end
      it 'fails if the expiry is nil' do
        expect(build(:season, expiry: nil).save).to be_false
      end
      it 'fails if the expiry is before start' do
        expect(build(:season, start: Time.now, expiry: Time.now.yesterday).save).to be_false
      end
    end
  end

  describe '.for' do
    before do
      @season = create(:season)
      @t = Time.now
    end

    context 'when there is a season for the given datetime' do
      context 'when the datetime is given as Time' do
        it 'returns the season' do
          expect(Season.for(@t)).to eq @season
        end
      end

      context 'when the datetime is given as String' do
        it 'returns the season' do
          expect(Season.for(@t.to_s)).to eq @season
        end
      end
    end

    context 'when there is no seasons for the given datetime' do
      context 'when the datetime is given as Time' do
        it 'returns nil' do
          expect(Season.for(1.weeks.ago(@t))).to be_nil
        end
      end

      context 'when the datetime is given as String' do
        it 'returns nil' do
          expect(Season.for(1.weeks.ago(@t).to_s)).to be_nil
        end
      end
    end
  end

  describe '#range' do
    before do
      @now = Time.now
      @season = create(:season, start: @now.yesterday, expiry: @now.tomorrow)
    end
    subject { @season.range }
    it 'returns Range' do
      expect(subject).to be_kind_of Range
    end
    it 'returns correct range' do
      expect(subject.begin).to eql @now.yesterday
      expect(subject.last).to eql @now.tomorrow
    end
  end
end
