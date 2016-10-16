require 'rails_helper'

RSpec.describe TorrentDownload, type: :service do
  let(:transmission) { double('transmission') }
  let(:torrent) { Fabricate.build(:torrent) }
  before { allow(torrent).to receive(:transmission).and_return transmission }

  describe '#call' do
    it 'returns #torrent_file_path' do
      allow(transmission).to receive(:files).and_return %w(file)
      expect(subject).to receive(:torrent_file_path)
      subject.call(torrent: torrent)
    end

    it 'returns #torrent_zip_file_path' do
      allow(transmission).to receive(:files).and_return %w(file_1 file_2)
      expect(subject).to receive(:torrent_zip_file_path)
      subject.call(torrent: torrent)
    end
  end

  describe '#torrent_file_path' do
    it 'returns torrent download file path' do
      allow(transmission).to receive(:download_directory).and_return '/download'
      allow(transmission).to receive(:files).and_return ['name' => 'file']
      expect(subject.send(:torrent_file_path, transmission)).to eq \
        '/download/file'
    end
  end

  describe '#torrent_zip_file_path' do
    before { allow(transmission).to receive(:name).and_return 'torrent' }
    let(:zip_file_path) { "#{Rails.root}/tmp/zip/torrent.zip" }

    it 'returns already zipped file if found' do
      expect(File).to receive(:exist?).with(zip_file_path).and_return true
      subject.send(:torrent_zip_file_path, transmission)
    end

    it 'creates zip_file of the torrents' do
      file = double('file')
      zip = double('zip')

      allow(transmission).to receive(:download_directory).and_return '/download'
      expect(transmission).to receive(:files).and_return \
        [{ 'name' => 'f1' }, { 'name' => 'f2' }]

      expect(File).to receive(:exist?).with(zip_file_path).and_return false
      expect(File).to receive(:new).with(zip_file_path, 'w+').and_return file

      expect(Zip::OutputStream).to receive(:open).with(file)
      expect(Zip::File).to receive(:open)\
        .with(zip_file_path, Zip::File::CREATE).and_yield zip
      expect(zip).to receive(:add).with('f1', '/download/f1')
      expect(zip).to receive(:add).with('f2', '/download/f2')

      # once on Zip::File.open
      # once on zip_file.path method return
      expect(file).to receive(:path).twice.and_return zip_file_path
      subject.send(:torrent_zip_file_path, transmission)
    end
  end
end
