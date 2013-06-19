function ScrollController() {
  var thisView = this;
  var scrollbarWidth;

  $('.scrollbar').draggable({
    axis: "x",
    containment: '.scroll_container',
    drag: function (event, ui){}
  });

  $('.scrollbar').on('drag', updatePositions);

  function updatePositions(event, ui) {
    updateScrollbar(ui.position.left);
    var scrollDistance = updateTrackLine(ui.position.left);
    updateScrollTime(scrollDistance);
  }

  function updateScrollTime(scrollDistance){
    var time = secondize(scrollDistance);
    var minutes = ("00" + Math.floor(time / 60)).slice(-2);
    var seconds = ("00" + Math.floor(time % 60)).slice(-2);
    var milliseconds = ("000" + Math.floor(time % 1 * 1000)).slice(-3);
    $('.scroll_time .minutes').html(minutes + ':');
    $('.scroll_time .seconds').html(seconds + '.');
    $('.scroll_time .milliseconds').html(milliseconds);
  }

  function updateTrackLine(left){
    var windowWidth = parseInt($('.track_window').css('width'));
    var trackWidth = parseInt($('.track_line').css('width'));
    var scrollbarWidth = updateScrollbarWidth();
    var scrollRatio = (trackWidth - windowWidth + 100)/(windowWidth - scrollbarWidth);
    $('.track_line').css('left', -left * scrollRatio + 'px');
    return (left * scrollRatio);
  }

  function updateScrollbar(left) {
    $('.scrollbar').css('left', left);
  }

  function updateScrollbarWidth(){
    var windowWidth = parseInt($('.track_window').css('width'));
    var trackWidth = parseInt($('.track_line').css('width'));
    var scrollbarWidth = Math.min(windowWidth * windowWidth / trackWidth, windowWidth);
    $('.scrollbar').width(scrollbarWidth + 'px');
    return scrollbarWidth;
  }

  function updateTrackWidths(){
    var width = pixelize(playlist.longestLength()) + 6 + 'px';
    $('.track_line').width(width);
  }

  function updateWidths(){
    updateTrackWidths();
    updateScrollbarWidth();
  }

  $.Topic("TrackView:initializeView").subscribe(updateWidths);
  $.Topic("Track:setDelay").subscribe(updateWidths);
  $.Topic("Track:setOffset").subscribe(updateWidths);
  $.Topic("Track:setDuration").subscribe(updateWidths);
  $.Topic("Track:deleted").subscribe(updateWidths);
}
