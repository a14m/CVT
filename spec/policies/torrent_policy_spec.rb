require 'rails_helper'

RSpec.describe TorrentPolicy, type: :policy do
  let(:torrent) { double('torrent') }
  let(:user)    { Fabricate.build(:user) }

  subject { TorrentPolicy.new(user, torrent) }

  describe '#add?' do
    it 'returns true' do
      allow(subject).to receive(:valid_subscription?).and_return true
      allow(subject).to receive(:enough_space?).and_return true
      expect(subject.add?).to be_truthy
    end

    it 'fails TorrentCreationError(subscription.expired)' do
      allow(subject).to receive(:valid_subscription?).and_return false
      expect { subject.add? }.to raise_error TorrentCreationError,
        'subscription.expired'
    end

    it 'fails TorrentCreationError(subscription.enough_space)' do
      allow(subject).to receive(:valid_subscription?).and_return true
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
      expect(user).to receive(:usage).and_return 0
      expect(torrent).to receive(:size).and_return 1
      expect(subject.send(:enough_space?)).to be_truthy
    end

    it 'returns false' do
      expect(user).to receive(:usage).and_return user.quota
      expect(torrent).to receive(:size).and_return 1
      expect(subject.send(:enough_space?)).to be_falsy
    end
  end

  describe '#valid_subscription?' do
    context 'has expires_at' do
      it 'returns true' do
        user.expires_at = 1.day.from_now
        expect(subject.send(:valid_subscription?)).to be_truthy
      end

      it 'returns false' do
        user.expires_at = 1.day.ago
        expect(subject.send(:valid_subscription?)).to be_falsy
      end
    end

    context 'no expires_at' do
      it 'returns false' do
        user.expires_at = nil
        expect(subject.send(:valid_subscription?)).to be_falsy
      end
    end
  end
end
