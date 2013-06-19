function TrackList(context, savedJSON){
  this.context = context;
  this.tracks = [];
  this.timeoutId = [];

  this.addTrack = function(track) {
    this.tracks.push(track);
  };

  this.toJSONString = function(){
    var state = {tracks:[]};
    for (i in this.tracks){
      state['tracks'].push(this.tracks[i].toJSON());
    }
    return JSON.stringify(state);
  };

  this.load = function(json) {
    var state = JSON.parse(json);
    for (i in state.tracks){
      state.tracks[i].context = this.context;
      this.tracks.push(new Track(tracks[i]));
    }
  };

  this.longestLength = function(){
    var longest = 0;
    for(i in this.tracks){
      if (!this.tracks[i].deleted){
        var totalLength = parseFloat(this.tracks[i].duration) +  parseFloat(this.tracks[i].delay);
        longest = (longest < totalLength) ? totalLength : longest;
      }
    }
    return longest;
  };

  this.setStopTimer = function(time){
    this.timeoutId = setTimeout(this.stopAll, (this.longestLength() - time)*1000);
  };

  this.pauseAll = function(){
    for (i in this.tracks) {
      this.tracks[i].pause(time);
    }
  };

  this.stopAll = function(){
    for (i in this.tracks) {
      this.tracks[i].stop();
    }
    for (i in this.timeoutId) { clearTimeout(timeoutId[i]); }
    $.Topic('TrackList:stopAll').publish();
  };

  this.resumeAll = function(){
    for (i in this.tracks) {
      if (!this.tracks[i].deleted){ this.tracks[i].resume(time); }
    }
    this.setStopTimer(time);
  };

  this.playAllAt = function(time){
    for (i in this.tracks) {
      if (!this.tracks[i].deleted){ this.tracks[i].resume(time); }
    }
    this.setStopTimer(time);
  };


  if(typeof(savedJSON) !== 'undefined' ) {
    this.load(savedJSON);
  };
}
