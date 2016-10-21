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

  describe '#quota' do
    it 'returns defualt quota' do
      expect(subject.quota).to eq 5 * 1024 * 1024 * 1024
    end
  end

  describe '#stripe_id' do
    it { is_expected.to validate_presence_of(:stripe_id).on(:update) }
  end

  describe '#expires_at' do
    it { is_expected.to validate_presence_of(:expires_at).on(:update) }
  end

  describe '#valid_subscription?' do
    context 'expires_at = value' do
      it 'returns true' do
        subject.expires_at = 1.day.from_now
        expect(subject.valid_subscription?).to be_truthy
      end

      it 'returns false' do
        subject.expires_at = 1.day.ago
        expect(subject.valid_subscription?).to be_falsy
      end
    end

    context 'expires_at = nil' do
      it 'returns false' do
        subject.expires_at = nil
        expect(subject.valid_subscription?).to be_falsy
      end
    end
  end
end
