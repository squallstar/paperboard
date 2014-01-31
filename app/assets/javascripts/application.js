//= require jquery
//= require typeahead
//= require jquery_ujs
//= require turbolinks
//= require_tree ./app/core
//= require_tree ./app/hooks

$(document).on("page:change", function(){
  Paperboard.run();
});