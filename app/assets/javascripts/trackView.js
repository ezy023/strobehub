function TrackView() {
  this.intervals = {};
  this.template = _.template($( "script.template" ).html());
  var thisView = this;

  this.initializeView = function(track){
    var elem = thisView.template(track);
    $('ul#track_list').append(elem);
    $('.audio_clip').draggable({ axis: "x" });
  };

  this.render = function(track){
    $('#track_'+track.index).replaceWith(thisView.template( track ));
    $('.audio_clip').draggable({ axis: "x" });
  };

  this.updateProgressBar = function(track) {
    var elapsedTime = track.context.currentTime - track.startTime;
    $('#track_'+track.index).find('.progress_bar').css('left', pixelize(elapsedTime) + 'px');
  };

  this.play = function(track){
    var startTime = track.startTime;
    var intervalId = setInterval(function(){
      thisView.updateProgressBar(track);
    }, 20);
    thisView.intervals[track.index] = intervalId;
  };

  this.pause = function(track) {
    clearInterval(thisView.intervals[track.index]);
    var elapsedTime = track.pauseTime - track.startTime;
  };

  this.stop = function(track){
    thisView.pause(track);
    $('#track_'+track.index).find('.progress_bar').css('left', '0px');
  };


  $.Topic("TrackList:stopAll").subscribe(this.stopAll);
  $.Topic("Track:bufferLoaded").subscribe(this.initializeView);
  $.Topic("Track:play").subscribe(this.play);
  $.Topic("Track:pause").subscribe(this.pause);
  $.Topic("Track:stop").subscribe(this.stop);
  $.Topic("Track:setDelay").subscribe(this.render);
  $.Topic("Track:setOffset").subscribe(this.render);
  $.Topic("Track:setDuration").subscribe(this.render);
}
