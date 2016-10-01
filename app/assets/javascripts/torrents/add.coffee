Dropzone.options.fileDrop = {
  url: '/torrents'
  maxFilesize: 1
  paramName: 'torrent[file]'
  uploadMultiple: false
  addRemoveLinks: false
  clickable: true
  acceptedFiles: 'application/octet-stream,.torrent'
  autoProcessQueue: true
  maxFiles: 1
  hiddenInputContainer: '#file-drop'
  previewTemplate: '<div></div>'
}

addDragHoverEffect = ($fileDrop)->
  $fileDrop.css(backgroundColor: '#eff0f1')
  null

removeDragHoverEffect = ($fileDrop)->
  $fileDrop.css(backgroundColor: '#ffffff')
  null

updateResponseInfo = ($fileDrop, response) ->
  $fileDrop.find('.info').hide()
  $responseHeader = $fileDrop.find('.response').show().find('h4')
  $responseHeader.text(response.message) if response.message
  $responseHeader.text(response) unless response.message
  setTimeout( ->
    window.location.reload()
  , 3000)

processing = ($fileDrop)->
  $status = $fileDrop.children('.status')
  $status.removeClass('red green').addClass('orange')

success = ($fileDrop, response)->
  $status = $fileDrop.children('.status')
  $status.removeClass('red orange').addClass('green')
  updateResponseInfo($fileDrop, response)

error = ($fileDrop, response, _xhr)->
  $status = $fileDrop.children('.status')
  $status.removeClass('orange green').addClass('red')
  updateResponseInfo($fileDrop, response)

setupDropzone = ($fileDrop) ->
  dropzone = new Dropzone('#file-drop')

  dropzone.on('addedfile', () ->
    processing($fileDrop)
  )
  dropzone.on('error', (file, errorMsg, response) ->
    error($fileDrop, errorMsg, response)
  )
  dropzone.on('success', (file, response) ->
    success($fileDrop, response)
  )

document.addEventListener('turbolinks:load', ->
  $fileDrop = $('.file-drop')
  return unless $fileDrop.length > 0

  $(document).bind 'dragover', (e) ->
    addDragHoverEffect($fileDrop)
    e.preventDefault()

  $(document).bind 'dragleave drop', (e) ->
    removeDragHoverEffect($fileDrop)
    e.preventDefault()

  setupDropzone($fileDrop)
)
