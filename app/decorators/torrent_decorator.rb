# Torrent Decorator
class TorrentDecorator < ApplicationDecorator
  delegate_all

  def transmission
    torrent.transmission
  end

  def percentage
    h.number_with_precision(transmission.percent_done * 100.0, precision: 2)
  end

  def downloaded
    downloaded = transmission.percent_done * transmission.total_size
    h.number_to_human_size(downloaded)
  end

  def total_size
    h.number_to_human_size(transmission.total_size)
  end

  def size_status
    downloaded_unit = downloaded[-2..-1]
    total_size_unit = total_size[-2..-1]

    return total_size if status == :done
    return "#{downloaded} / #{total_size}" if downloaded_unit != total_size_unit
    "#{downloaded[0...-2]}/ #{total_size}" if downloaded_unit == total_size_unit
  end

  def status
    return :done if object.transmission.percent_done == 1
    return :stopped if object.transmission.status == :stopped
    :downloading
  end
end
