// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function () {
  $('.btn-like').on('click', function(event){
    event.preventDefault();
    $.post(this.href);
  });

  var connection = new WebSocketRails(window.location.host + '/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(post) {
    var postElem = $('.post[data-id=' + post.id + '] .btn-like')
    postElem.text('❤ ' + post.new_like_count);
  });

})