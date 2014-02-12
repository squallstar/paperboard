//= require jquery
//= require typeahead
//= require jquery_ujs
//= require turbolinks
//= require_tree ./app/core
//= require_tree ./app/hooks

$(document).on("page:update", function(){
  Turbolinks.pagesCached(5);
  Paperboard.run();
});