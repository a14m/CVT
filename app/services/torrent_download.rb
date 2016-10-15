# Service Object for torrent zipping torrent files and send file path
class TorrentDownload
  def call(torrent:)
    transmission = torrent.transmission
    return torrent_file_path(transmission) if transmission.files.size == 1
    torrent_zip_file_path(transmission)
  end

  private

  def torrent_file_path(transmission)
    "#{transmission.download_directory}/#{transmission.files.first['name']}"
  end

  def torrent_zip_file_path(transmission)
    # Return the previously zipped file instead of spending long time zipping
    zip_file = "#{Rails.root}/tmp/zip/#{transmission.name}.zip"
    return zip_file if File.exist?(zip_file)

    # zip the torrent if no zip exists before
    zip_file = File.new(zip_file, 'w+')
    torrent_files = transmission.files.map do |file|
      file['name']
    end

    # Initialize the temp file as a zip file
    Zip::OutputStream.open(zip_file) { |_| }
    # add files to the zip
    Zip::File.open(zip_file.path, Zip::File::CREATE) do |zip|
      torrent_files.each do |file_name|
        zip.add(file_name, transmission.download_directory + '/' + file_name)
      end
    end
    # send the zipped file path for download
    zip_file.path
  end
end
