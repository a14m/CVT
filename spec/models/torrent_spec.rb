require 'rails_helper'

RSpec.describe Torrent, type: :model do
  it { is_expected.to belong_to(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:transmission_id) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:checksum) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:file) }
  end
end
