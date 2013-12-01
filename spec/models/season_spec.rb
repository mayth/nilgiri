require 'spec_helper'

describe Season do
  describe '#range' do
    before do
      @now = Time.local(2013, 12, 1, 9, 0, 0, 0)  # 2013-12-01 09:00:00
      Season.create(
        name: 'season testing 1',
        start: @now,
        expiry: @now.tomorrow
      )
      @season = Season.find_by_name('season testing 1')
    end
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
