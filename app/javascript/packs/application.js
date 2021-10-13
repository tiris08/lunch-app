// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@nathanvda/cocoon")
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


import '@doabit/semantic-ui-sass'
import 'application/sweet-alert-confirm';

$(document).on('turbolinks:load', function() {
  $('.ui.radio.checkbox').checkbox();
  $('.tabular.menu .item').tab();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
  
  $('select.dropdown')
  .dropdown()

  // order update form

  $('.ui.three.column.grid').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });
  $('.ui.three.column.grid').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });
  check_to_hide_or_show_add_link();
  function check_to_hide_or_show_add_link() {
    if ($('.nested-fields.column:visible').length == 3) {
      $('.ui.primary.labaled.button.nest').hide();
    } else {
      $('.ui.primary.labaled.button.nest').show();
    }
  }
})

// if you wan't to use custom variables, you should import custom styelesheet
// import 'stylesheets/semantic-ui.scss'

// import '@doabit/semantic-ui-sass/src/scss/semantic-ui.scss'
