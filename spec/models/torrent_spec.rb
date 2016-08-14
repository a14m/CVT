require 'rails_helper'

RSpec.describe Torrent, type: :model do
  it { is_expected.to belong_to(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:transmission_id) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:checksum) }
    it { is_expected.to validate_presence_of(:path) }
    it { should have_attached_file(:torrent) }
    it { should validate_attachment_presence(:torrent) }
    it do
      should validate_attachment_content_type(:torrent)
        .allowing('application/x-bittorrent')
    end
  end
end
