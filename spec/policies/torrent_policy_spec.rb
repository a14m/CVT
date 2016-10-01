require 'rails_helper'

RSpec.describe TorrentPolicy, type: :policy do
  let(:torrent) { double('torrent') }
  let(:user)    { Fabricate.build(:user) }

  subject { TorrentPolicy.new(user, torrent) }

  describe '#add?' do
    it 'returns true' do
      allow(subject).to receive(:expired_subscription?).and_return false
      allow(subject).to receive(:enough_space?).and_return true
      expect(subject.add?).to be_truthy
    end

    it 'fails TorrentCreationError(subscription.expired)' do
      allow(subject).to receive(:expired_subscription?).and_return true
      expect { subject.add? }.to raise_error TorrentCreationError,
        'subscription.expired'
    end

    it 'fails TorrentCreationError(subscription.enough_space)' do
      allow(subject).to receive(:expired_subscription?).and_return false
      allow(subject).to receive(:enough_space?).and_return false
      expect { subject.add? }.to raise_error TorrentCreationError,
        'subscription.enough_space'
    end
  end

  describe '#start?' do
    it 'returns true' do
      expect(torrent).to receive(:bytes_left).and_return 100
      expect(subject.start?).to be_truthy
    end

    it 'returns false' do
      expect(torrent).to receive(:bytes_left).and_return 0
      expect(subject.start?).to be_falsy
    end
  end

  describe '#enough_space?' do
    it 'returns true' do
      expect(user.torrents).to receive(:sum).and_return 0
      expect(torrent).to receive(:size).and_return 1
      expect(subject.send(:enough_space?)).to be_truthy
    end

    it 'returns false' do
      expect(user.torrents).to receive(:sum).and_return user.quota
      expect(torrent).to receive(:size).and_return 1
      expect(subject.send(:enough_space?)).to be_falsy
    end
  end

  describe '#expired_subscription?' do
    it 'returns true' do
      Timecop.freeze(Date.parse('2017-01-01')) do
        expect(subject.send(:expired_subscription?)).to be_truthy
      end
    end

    it 'returns false' do
      expect(subject.send(:expired_subscription?)).to be_falsy
    end
  end
end
