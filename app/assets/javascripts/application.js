//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree ./app/core
//= require_tree ./app/helpers
//= require_tree ./app/hooks

$(document).on("page:change", function(){
  Turbolinks.pagesCached(5);
  Paperboard.run();
});