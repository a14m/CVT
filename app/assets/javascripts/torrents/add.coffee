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

setupFileDrop = (fileDrop, attachment)->
  status = fileDrop.children('.status').first()

  jackUp = new JackUp.Processor(path: '/torrents')
  jackUp.on "upload:sentToServer", (e, options) ->
    removeDragHoverEffect(fileDrop)

  jackUp.on "upload:success", (e, options) ->

  jackUp.on "upload:failure", (e, options) ->

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
