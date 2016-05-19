document.addEventListener('turbolinks:load', ->
  # clean old dangling errors due to turbolinks
  $('small.danger.filled').remove()

  # setup parsley for the form
  $('.form-authentication').parsley(
    trigger: 'input'
    errorClass: 'has-danger'
    successClass: 'has-success'
    errorsWrapper: '<small class="danger"></small>'
    errorTemplate: '<div></div>'
  )

  # TODO: setup animation for the parsley errors
)
