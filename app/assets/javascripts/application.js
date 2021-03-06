// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

// Initialize tooltips
$(document).on('page:change', function () {
  $('[data-toggle="tooltip"]').tooltip();
});

$(document).ajaxError(function () {
  $('.ajax-error').show('slow').delay(2000).hide('slow');
});

$(document).ajaxSuccess(function () {
  $('.ajax-error').hide();
});

// Setup Ajax Resources
$(document).on('page:change', function () {
  $('.favorite-list').each(function() {
    var favorite = new FavoriteList(this);
    favorite.bindEvents();
  });

  $('.list-items').each(function() {
    var task = new Task(this);
    task.bindEvents();
  });
});
