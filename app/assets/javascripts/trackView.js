function TrackView() {
  this.intervals = {};
  this.template = _.template($( "script.template" ).html());
  var thisView = this;

  this.initializeView = function(track){
    var elem = thisView.template(track);
    $('ul').append(elem);
    $('.audio_clip').draggable({ axis: "x" });
  };

  this.render = function(track){
    $('#track_'+track.id).replaceWith(thisView.template( track ));
    $('.audio_clip').draggable({ axis: "x" });
  };

  this.updateProgressBar = function(track) {
    var elapsedTime = track.context.currentTime - track.startTime;
    $('#track_'+track.id).find('.progress_bar').css('left', pixelize(elapsedTime));
  };

  this.play = function(track){
    var startTime = track.startTime;
    var intervalId = setInterval(thisView.updateProgressBar(track), 20);
    thisView.intervals[track.id] = intervalId;
  };

  this.pause = function(track) {
    clearInterval(intervals[track.id]);
    var elapsedTime = track.pauseTime - track.startTime;
  };

  $.Topic("Track:bufferLoaded").subscribe(this.initializeView);
  $.Topic("Track:play").subscribe(this.play);
  $.Topic("Track:pause").subscribe(this.pause);
  $.Topic("Track:setDelay").subscribe(this.render);
  $.Topic("Track:setOffset").subscribe(this.render);
  $.Topic("Track:setDuration").subscribe(this.render);
}
