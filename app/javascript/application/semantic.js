$(document).on('turbolinks:load', () => {
  $('.ui.radio.checkbox').checkbox()
  $('.tabular.menu .item').tab()
  $('.message .close').on('click', () => {
    $(this).closest('.message').transition('fade')
  })

  $('select.dropdown').dropdown()
})
