require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  subject { user.decorate }
  let(:user) { Fabricate.build(:user) }

  describe '#usage' do
    it 'returns 0.0' do
      allow(user).to receive(:usage).and_return 0
      expect(subject.usage).to eq '0.0'
    end

    it 'returns 1.0' do
      allow(user).to receive(:usage).and_return 1_073_741_824 # 1 GB
      expect(subject.usage).to eq '1.0'
    end

    it 'returns 2.5' do
      allow(user).to receive(:usage).and_return 2_684_354_560 # 2.5 GB
      expect(subject.usage).to eq '2.5'
    end
  end

  describe '#percentage' do
    it 'returns 0.0' do
      allow(user).to receive(:usage).and_return 0
      expect(subject.percentage).to eq 0.0
    end

    it 'returns 20.0' do
      allow(user).to receive(:usage).and_return 1_073_741_824 # 1 GB
      expect(subject.percentage).to eq 20.0
    end

    it 'returns 50.0' do
      allow(user).to receive(:usage).and_return 2_684_354_560 # 2.5 GB
      expect(subject.percentage).to eq 50.0
    end
  end

  describe '#expires_at' do
    it 'formats expires_at(%d %b %Y)' do
      allow(user).to receive(:expires_at).and_return Date.parse('1970-01-01')
      expect(subject.expires_at).to eq '01 Jan 1970'
    end
  end

  describe '#plan_size' do
    it 'returns 5 GB' do
      expect(subject.plan_size).to eq '5 GB'
    end
  end

  describe '#usage_percentage' do
    it 'formats #percentage' do
      helpers = double('h')
      expect(subject).to receive(:h).and_return helpers
      expect(helpers).to receive(:number_with_precision).with(
        subject.percentage,
        precision: 1
      )
      subject.usage_percentage
    end
  end

  describe '#status' do
    it 'returns green' do
      allow(subject).to receive(:percentage).and_return 0
      expect(subject.status).to eq 'green'

      allow(subject).to receive(:percentage).and_return 59
      expect(subject.status).to eq 'green'
    end

    it 'returns orange' do
      allow(subject).to receive(:percentage).and_return 60
      expect(subject.status).to eq 'orange'

      allow(subject).to receive(:percentage).and_return 80
      expect(subject.status).to eq 'orange'
    end

    it 'returns red' do
      allow(subject).to receive(:percentage).and_return 81
      expect(subject.status).to eq 'red'

      allow(subject).to receive(:percentage).and_return 101
      expect(subject.status).to eq 'red'
    end
  end
end
