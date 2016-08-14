hoverStatus = (statusRow)->
  plan  = statusRow.find('.plan')
  percentage = statusRow.find('.percentage')
  statusRow
    .hover(
      ->
        plan.stop().fadeOut(300, -> percentage.stop().fadeIn(300))
      ,
      ->
        percentage.stop().fadeOut(300, -> plan.stop().fadeIn(300))
    )
  null


document.addEventListener('turbolinks:load', ->
  statusBar = $('.quota .status')
  return unless statusBar.length > 0
  statusRow = statusBar.closest('.row')
  statusRow.one(hoverStatus(statusRow))
)
