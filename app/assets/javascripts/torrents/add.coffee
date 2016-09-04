addDragHoverEffect = (fileDrop)->
  fileDrop.css(backgroundColor: '#eff0f1')
  null

removeDragHoverEffect = (fileDrop)->
  fileDrop.css(backgroundColor: '#ffffff')
  null

setupFileDropClick = (fileDrop, attachment)->
  fileDrop.on('click', ->
    attachment[0].click()
  )

fileSentToServer = (fileDrop)->
  removeDragHoverEffect(fileDrop)
  status = fileDrop.children('.status').first()
  status.removeClass('red')
  status.removeClass('green')
  status.addClass('orange')

uploadSuccess = (fileDrop)->
  status = fileDrop.children('.status').first()
  status.removeClass('red')
  status.removeClass('orange')
  status.addClass('green')
  null

uploadFailure = (fileDrop)->
  status = fileDrop.children('.status').first()
  status.removeClass('orange')
  status.removeClass('green')
  status.addClass('red')
  null

setupFileDrop = (fileDrop, attachment)->
  jackUp = new JackUp.Processor(path: '/torrents')
  jackUp.on "upload:sentToServer", (e, options) ->
    fileSentToServer(fileDrop)

  jackUp.on "upload:success", (e, options) ->
    uploadSuccess(fileDrop)

  jackUp.on "upload:failure", (e, options) ->
    uploadFailure(fileDrop)

  fileDrop.jackUpDragAndDrop(jackUp)
  attachment.jackUpAjax(jackUp)


document.addEventListener('turbolinks:load', ->
  fileDrop = $('.file-drop')
  return unless fileDrop.length > 0
  attachment = $('.attachment')

  $(document).bind 'dragover', (e) ->
    addDragHoverEffect(fileDrop)
    e.preventDefault()

  $(document).bind 'dragleave drop', (e) ->
    removeDragHoverEffect(fileDrop)
    e.preventDefault()

  setupFileDropClick(fileDrop, attachment)
  setupFileDrop(fileDrop, attachment)
)
