require 'rails_helper'

RSpec.describe TorrentCreation, type: :service do
  let(:file) { File.new("#{Rails.root}/spec/fixtures/files/test.torrent") }

  describe '.call' do
    let(:transmission_torrent) { double 'transmission_torrent' }

    it 'create Torrent object after checking policies' do
      expect(subject).to receive(:transmission_add!).and_return\
        transmission_torrent
      expect_any_instance_of(TorrentPolicy).to receive(:add?).and_return true
      expect(subject).to receive(:create_torrent!)
      expect_any_instance_of(TorrentPolicy).to receive(:start?).and_return true
      expect(transmission_torrent).to receive(:start!)

      expect { subject.call(user: Fabricate.build(:user), file: file) }.not_to\
        raise_error
    end
  end

  describe '.transmission_add' do
    it 'adds torrent to transmission daemon' do
      file.rewind

      expect(Transmission::RPC::Torrent).to receive(:add).with(
        metainfo: Base64.strict_encode64(file.read),
        paused: true
      ).and_return Object.new

      file.rewind
      subject.send(:transmission_add!, file)
    end

    it 'raises InvalidFileError' do
      expect(Transmission::RPC::Torrent).to receive(:add)
      expect { subject.send(:transmission_add!, file) }.to\
        raise_error InvalidFileError
    end

    it 'raises ApplicationError' do
      expect(Transmission::RPC::Torrent).to receive(:add)
        .and_raise(NoMethodError)
      expect { subject.send(:transmission_add!, file) }.to\
        raise_error ApplicationError
    end
  end

  describe '.create_torrent' do
    let(:user)    { Fabricate.create(:user) }
    let(:torrent) { double('torrent') }
    let(:torrent_file) { double('torrent_file') }

    it 'creates Torrent object' do
      allow(torrent).to receive(:name).and_return Faker::Name.name
      allow(torrent).to receive(:id).and_return Faker::Number.number(5)
      allow(torrent).to receive(:size).and_return Faker::Number.number(5)
      allow(torrent).to receive(:hash).and_return Faker::Crypto.sha1
      allow(torrent_file).to receive(:tempfile).and_return file

      expect { subject.send(:create_torrent!, user, torrent, torrent_file) }.to\
        change { Torrent.count }.by(1)
    end

    it 'fails ActiveRecord::RecordInvalid' do
      allow(torrent).to receive(:name)
      allow(torrent).to receive(:id)
      allow(torrent).to receive(:size)
      allow(torrent).to receive(:hash)
      allow(torrent_file).to receive(:tempfile)

      expect { subject.send(:create_torrent!, user, torrent, torrent_file) }.to\
        raise_error ActiveRecord::RecordInvalid
    end
  end
end
