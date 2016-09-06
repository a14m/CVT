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
  status = fileDrop.children('.status')
  status.removeClass('red').removeClass('green').addClass('orange')

updateResponseInfo = (fileDrop, options) ->
  fileDrop.find('.info').hide()
  fileDrop.find('.response').show().find('h4')
    .text($.parseJSON(options.responseText).message)
  setTimeout( ->
    window.location.reload()
  , 3000)

uploadSuccess = (e, options, fileDrop)->
  status = fileDrop.children('.status')
  status.removeClass('red').removeClass('orange').addClass('green')
  updateResponseInfo(fileDrop, options)

uploadFailure = (e, options, fileDrop)->
  status = fileDrop.children('.status')
  status.removeClass('orange').removeClass('green').addClass('red')
  updateResponseInfo(fileDrop, options)

setupFileDrop = (fileDrop, attachment)->
  jackUp = new JackUp.Processor(path: '/torrents')
  jackUp.on "upload:sentToServer", (e, options) ->
    fileSentToServer(fileDrop)

  jackUp.on "upload:success", (e, options) ->
    uploadSuccess(e, options, fileDrop)

  jackUp.on "upload:failure", (e, options) ->
    uploadFailure(e, options, fileDrop)

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

  # allow fileDrop to send feedback about uploading file
  fileDrop.bind 'drop', (e) ->
    fileSentToServer(fileDrop)

  setupFileDropClick(fileDrop, attachment)
  setupFileDrop(fileDrop, attachment)
)
