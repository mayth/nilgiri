require 'spec_helper'

describe Season do
  before do
    @now = Time.local(2013, 12, 1, 9, 0, 0, 0)  # 2013-12-01 09:00:00
    Season.create(
      name: 'season testing 1',
      start: @now,
      expiry: @now.tomorrow
    )
    @season = Season.find_by_name('season testing 1')
  end

  describe '::for' do
    context 'when there is a season for the given datetime' do
      context 'as Time' do
        subject { Season.for(Time.local(2013, 12, 1, 21, 0, 0, 0)) }
        it 'returns the season' do
          expect(subject).to eq @season
        end
      end
      context 'as String' do
        subject { Season.for('2013-12-01 21:00:00') }
        it 'returns the season' do
          expect(subject).to eq @season
        end
      end
    end
    context 'when there is not any seasons for the given datetime' do
      context 'as Time' do
        subject { Season.for(Time.local(2013, 12, 1, 8, 59, 59, 0)) }
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
      context 'as String' do
        subject { Season.for('2013-12-01 08:59:59') }
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end
    context 'when invalid object is given' do
      it 'raises error' do
        expect { Season.for([2013, 12, 1, 8, 59, 59, 0]) }.to raise_error
      end
    end
  end

  describe '#range' do
    subject { @season.range }
    it 'returns Range' do
      expect(subject).to be_kind_of Range
    end
    it 'returns correct range' do
      expect(subject.begin).to eql @now
      expect(subject.last).to eql @now.tomorrow
    end
  end
end
