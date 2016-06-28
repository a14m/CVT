document.addEventListener('turbolinks:load', ->
  # setup parsley for the form
  authentication_form = $('.form-authentication')
  return unless authentication_form.length > 0
  authentication_form.parsley(
    trigger: 'input'
    errorClass: 'has-danger'
    successClass: 'has-success'
    errorsWrapper: '<small class="danger"></small>'
    errorTemplate: '<div></div>'
  )

  # TODO: setup animation for the parsley errors
)
