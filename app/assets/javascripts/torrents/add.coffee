setupFileDropClick = (fileDrop, attachment)->
  fileDrop.on('click', ->
    attachment[0].click()
  )

setupFileDrop = (fileDrop, attachment)->
  status = fileDrop.children('.status').first()

  jackUp = new JackUp.Processor(path: '/torrents')
  jackUp.on "upload:sentToServer", (e, options) ->
    status.removeClass('red')
    status.addClass('orange')
    status.removeClass('green')

  jackUp.on "upload:success", (e, options) ->
    status.removeClass('red')
    status.removeClass('orange')
    status.addClass('green')

  jackUp.on "upload:failure", (e, options) ->
    status.addClass('red')
    status.removeClass('orange')
    status.removeClass('green')

  fileDrop.jackUpDragAndDrop(jackUp)
  attachment.jackUpAjax(jackUp)


document.addEventListener('turbolinks:load', ->
  fileDrop = $('.file-drop')
  return unless fileDrop.length > 0
  attachment = $('.attachment')

  $(document).bind 'drop dragover', (e) ->
    e.preventDefault()
    # setup the drag and drop span to show the hover effect on drag and drop

  setupFileDropClick(fileDrop, attachment)
  setupFileDrop(fileDrop, attachment)
)
