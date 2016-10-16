require 'rails_helper'

RSpec.describe Torrent, type: :model do
  it { is_expected.to belong_to(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:transmission_id) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_numericality_of(:size).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:checksum) }
    it { is_expected.to validate_uniqueness_of(:checksum).scoped_to(:user_id) }
    it { should have_attached_file(:torrent) }
    it { should validate_attachment_presence(:torrent) }
    it do
      should validate_attachment_content_type(:torrent)
        .allowing('application/x-bittorrent')
    end
  end

  describe '#transmission' do
    it 'Transmission::RPC::Torrent#find' do
      expect(Transmission::RPC::Torrent).to receive(:find)
        .with(subject.transmission_id).once.and_return Object.new
      subject.transmission
      subject.transmission
      subject.transmission
    end

    it 'raises NotFoundError' do
      expect(Transmission::RPC::Torrent).to receive(:find).and_return nil
      expect { subject.transmission }.to raise_error NotFoundError
    end
  end
end
