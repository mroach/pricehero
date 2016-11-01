document.addEventListener('turbolinks:load', function() {
  moment.locale('en-GB');

  $('time[data-timestamp]').each(function() {
    var $el = $(this);
    $el.text(moment($el.attr('data-timestamp'), 'YYYY-MM-DD HH:mm').fromNow());
  });
});
