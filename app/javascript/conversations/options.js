$(document).on('turbolinks:load', function() { 

    //  when add more contacts to a conversation button is clicked
    //  toggle contacts selection
    $('body').on('click', '.add-people-to-chat', function(e) {
        $(this).next().toggle(100, 'swing');
    });
  
  });