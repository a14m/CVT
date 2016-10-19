require 'rails_helper'

RSpec.describe User, type: :model do
  subject { Fabricate.build(:user) }

  it { is_expected.to have_many :torrents }

  describe '#email' do
    let(:invalid_emails) { ['inv@lid', 'inv@li.d', 'i±v@l.id', 'i<v@l.id'] }
    let(:valid_emails) { ['v@l.id', 'v+1@l.id', 'v.1@l.id'] }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_values(*valid_emails).for(:email) }
    it { is_expected.not_to allow_values(*invalid_emails).for(:email) }
  end

  describe '#password' do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
  end

  it '#quota' do
    expect(subject.quota).to eq 5 * 1024 * 1024 * 1024
  end

  it '#expires_at' do
    expect(subject.expires_at).to eq Date.parse('2016-12-31')
  end
end
