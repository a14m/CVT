require 'rails_helper'

RSpec.describe TorrentDecorator, type: :decorator do
  subject { torrent.decorate }
  let(:transmission) { double('transmission') }
  let(:torrent) { Fabricate.build(:torrent) }
  before { allow(torrent).to receive(:transmission).and_return transmission }

  describe '#transmission' do
    it 'return the memoized transmission object' do
      expect(torrent).to receive(:transmission)
      subject.transmission
    end
  end

  describe '#percentage' do
    it 'returns 0.00' do
      allow(transmission).to receive(:percent_done).and_return 0.0
      expect(subject.percentage).to eq '0.00'
    end

    it 'returns 12.35' do
      allow(transmission).to receive(:percent_done).and_return 0.123456
      expect(subject.percentage).to eq '12.35'
    end

    it 'returns 100.00' do
      allow(transmission).to receive(:percent_done).and_return 1
      expect(subject.percentage).to eq '100.00'
    end
  end

  describe '#downloaded' do
    it 'returns 0 Bytes' do
      allow(transmission).to receive(:percent_done).and_return 0.0
      allow(transmission).to receive(:total_size).and_return 1_073_741_824 # 1GB
      expect(subject.downloaded).to eq '0 Bytes'
    end

    it 'returns 512 MB' do
      allow(transmission).to receive(:percent_done).and_return 0.50
      allow(transmission).to receive(:total_size).and_return 1_073_741_824 # 1GB
      expect(subject.downloaded).to eq '512 MB'
    end

    it 'returns 1 GB' do
      allow(transmission).to receive(:percent_done).and_return 1.00
      allow(transmission).to receive(:total_size).and_return 1_073_741_824 # 1GB
      expect(subject.downloaded).to eq '1 GB'
    end
  end

  describe '#status' do
    it 'returns :done' do
      allow(transmission).to receive(:percent_done).and_return 1.00
      allow(transmission).to receive(:status).and_return :stopped
      expect(subject.status).to eq :done
    end

    it 'returns :stopped' do
      allow(transmission).to receive(:percent_done).and_return 0.50
      allow(transmission).to receive(:status).and_return :stopped
      expect(subject.status).to eq :stopped
    end

    it 'returns :downloading' do
      allow(transmission).to receive(:percent_done).and_return 0.50
      allow(transmission).to receive(:status).and_return :something
      expect(subject.status).to eq :downloading
    end
  end

  describe '#size_status' do
    it 'returns #total_size' do
      allow(subject).to receive(:downloaded).and_return '512 MB'
      allow(subject).to receive(:total_size).and_return '1 GB'
      allow(subject).to receive(:status).and_return :done
      expect(subject.size_status).to eq '1 GB'
    end

    it 'returns #{downloaded} / #{total_size} with units' do
      allow(subject).to receive(:downloaded).and_return '512 MB'
      allow(subject).to receive(:total_size).and_return '1 GB'
      allow(subject).to receive(:status).and_return :downloading
      expect(subject.size_status).to eq '512 MB / 1 GB'
    end

    it 'returns #{downloaded} / #{total_size} without units' do
      allow(subject).to receive(:downloaded).and_return '512 MB'
      allow(subject).to receive(:total_size).and_return '1000 MB'
      allow(subject).to receive(:status).and_return :downloading
      expect(subject.size_status).to eq '512 / 1000 MB'
    end
  end
end
