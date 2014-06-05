$(document).ready(function() {
  $('.new_comment').on('submit', function(event){
    event.preventDefault();
    console.log("hello");

    $.post($(this).attr('action'), $(this).serialize(), function(response) {
      console.log(response);
      var currentPost = $('.post-container[data-id=' + response.post_id + ']');
      currentPost.find('.comments').prepend($('<li>' + response.comment + ' from ' + response.email + '</li>'));
      currentPost.find('input[type=text]').val('');
    });
  })
})