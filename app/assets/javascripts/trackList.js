function TrackList(context, savedJSON){
  this.context = context;
  this.tracks = [];
  this.longestDuration = 10;

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
    this.longestDuration = state.longestDuration;
    for (i in state.tracks){
      state.tracks[i].context = this.context;
      this.tracks.push(new Track(tracks[i]));
    }
  };

  this.playAllAt = function(time){
    for (i in this.tracks) {
      this.tracks[i].playAt(time);
    }
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
    $.Topic('TrackList:stopAll').publish();
  };

  this.resumeAll = function(){
    for (i in this.tracks) {
      this.tracks[i].resume(time);
    }
  };


  if(typeof(savedJSON) !== 'undefined' ) {
    this.load(savedJSON);
  };
}
