function TrackView() {
  this.intervals = {};
  this.trackTemplate = _.template($( "script.template" ).html());
  var thisView = this;

  this.initializeView = function(track){
    var elem = thisView.trackTemplate(track);
    $('.loading_track').first().replaceWith(elem);
    $('.audio_clip').draggable({ axis: "x" });
    $.Topic('TrackView:initializeView').publish();
  };

  this.render = function(track){
    var trackRow = $('#track_'+track.index);
    trackRow.find('.audio_clip').css('left', pixelize(track.delay) + 'px');
    trackRow.find('.audio_clip').width(pixelize(track.duration) + 'px');
    trackRow.find('.delay').html(Math.floor(track.delay*1000)/1000);
    trackRow.find('.offset').html(Math.floor(track.offset*1000)/1000);
    trackRow.find('.duration').html(Math.floor(track.duration*1000)/1000);
  };

  this.updateProgressBar = function(track) {
    var elapsedTime = track.context.currentTime - track.startTime;
    $('#track_'+track.index).find('.progress_bar').css('left', pixelize(elapsedTime) + 'px');
  };

  this.updateGlobalPlayTime = function(){
    var earliestTrack = _.max(playlist.tracks, function(track){
      return track.context.currentTime - track.startTime;
    });
    var elapsedTime = earliestTrack.context.currentTime - earliestTrack.startTime;
    var minutes = ("00" + Math.floor(elapsedTime / 60)).slice(-2);
    var seconds = ("00" + Math.floor(elapsedTime % 60)).slice(-2);
    var milliseconds = ("000" + Math.floor(elapsedTime % 1 * 1000)).slice(-3);
    $('#global_info .minutes').html(minutes + ':');
    $('#global_info .seconds').html(seconds + '.');
    $('#global_info .milliseconds').html(milliseconds);
  };

  this.strobe = function() {
    var fiftyShadesOfRage = ['#36FE39', '#F2FE45', '#FC0307', '#DE95FF','#E5E5E3'];
    $('h1').css('color', fiftyShadesOfRage[Math.floor(Math.random() * fiftyShadesOfRage.length)]);
    $('h2').css('color', fiftyShadesOfRage[Math.floor(Math.random() * fiftyShadesOfRage.length)]);
    $('h3').css('color', fiftyShadesOfRage[Math.floor(Math.random() * fiftyShadesOfRage.length)]);
    $('a').css('color', fiftyShadesOfRage[Math.floor(Math.random() * fiftyShadesOfRage.length)]);
  };

  this.play = function(track){
    var startTime = track.startTime;
    var intervalId = setInterval(function(){
      thisView.updateProgressBar(track);
      // thisView.strobe();
      thisView.updateGlobalPlayTime();
    }, 40);
    thisView.intervals[track.index] = intervalId;
  };

  this.pause = function(track) {
    clearInterval(thisView.intervals[track.index]);
  };

  this.clearClock = function(){
    $('#global_info .minutes').html('00:');
    $('#global_info .seconds').html('00.');
    $('#global_info .milliseconds').html('000');
  };

  this.stop = function(track){
    thisView.pause(track);
    $('#track_'+track.index).find('.progress_bar').css('left', '0px');
  };

  this.stopAll = function(){
    thisView.clearClock();
    $('.progress_bar').css('left', '0px');
    for (key in thisView.intervals){clearInterval(thisView.intervals[key])};
  };

  $.Topic("TrackList:stopAll").subscribe(this.stopAll);
  $.Topic("TrackList:playAll").subscribe(this.play);
  $.Topic("Track:bufferLoaded").subscribe(this.initializeView);
  $.Topic("Track:play").subscribe(this.play);
  $.Topic("Track:pause").subscribe(this.pause);
  $.Topic("Track:stop").subscribe(this.stop);
  $.Topic("Track:setDelay").subscribe(this.render);
  $.Topic("Track:setOffset").subscribe(this.render);
  $.Topic("Track:setDuration").subscribe(this.render);
}
