hoverStatus = (torrent)->
  $stats = $(torrent).find('.stats')
  $usage  = $stats.find('.usage')
  $percentage = $stats.find('.percentage')
  $stats
    .hover(
      ->
        $usage.stop().fadeOut(300, -> $percentage.stop().fadeIn(300))
      ,
      ->
        $percentage.stop().fadeOut(300, -> $usage.stop().fadeIn(300))
    )
  null


document.addEventListener('turbolinks:load', ->
  $torrents = $('.torrent')
  return unless $torrents.length > 0
  for $torrent in $torrents
    do ->
      $torrents.one(hoverStatus($torrent))
)
