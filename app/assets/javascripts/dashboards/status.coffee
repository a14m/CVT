hoverStatus = (statusRow, statusBar)->
  statusRow
    .hover(
      ->
        statusBar.animate({borderLeftWidth: '8px'}, 100)
      ,
      ->
        statusBar.animate({borderLeftWidth: '2px'},  100)
    )
  null


document.addEventListener('turbolinks:load', ->
  statusBar = $('.quota .status')
  return unless statusBar.length > 0
  statusRow = statusBar.closest('.row')
  statusRow.one(hoverStatus(statusRow, statusBar))
)
