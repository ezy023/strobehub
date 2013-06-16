function TrackView(track) {
  this.track = track;
  this.index = playlist.tracks.length;
  this.intervalId;

  this.template = _.template(
    $( "script.template" ).html()
  );

  var thisView = this;

  this.initializeView = function(track){
    if (thisView.track === track ){
      var elem = thisView.template( thisView );
      $('ul').append(elem);
      $('.audio_clip').draggable({ axis: "x" });
    }
  };

  this.render = function(track){
    if (thisView.track === track ){
      $('#track_'+thisView.index).replaceWith(thisView.template( thisView ));
      $('.audio_clip').draggable({ axis: "x" });
    }
  };

  this.moveProgressBar = function(track){
    var startTime = track.startTime;
    thisView.intervalId = setInterval(function(){
      var interval = track.context.currentTime - track.startTime;
      $('#track_'+thisView.index).find('.progress_bar').css('left', pixelize(interval));
    }, 20);
  };

  this.play = function(track){
    if (thisView.track === track ){
      thisView.moveProgressBar(track);
      console.log(thisView.intervalId);
    }
  };

  this.pause = function(track) {
    if (thisView.track === track ){
      clearInterval(thisView.intervalId);
      var interval = track.pauseTime - track.startTime;
      $('#track_'+thisView.index).find('.progress_bar').css('left', pixelize(interval));
    }
  }

  $.Topic("Track:play").subscribe(this.play);
  $.Topic("Track:pause").subscribe(this.pause);
  $.Topic("Track:bufferLoaded").subscribe(this.initializeView);
  $.Topic("Track:setDelay").subscribe(this.render);
  $.Topic("Track:setOffset").subscribe(this.render);
  $.Topic("Track:setDuration").subscribe(this.render);
}
