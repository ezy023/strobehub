function pixelize(seconds){
  return Math.floor(seconds / playlist.longestDuration * 600);
}

function secondize(pixels){
  return pixels / 600 * playlist.longestDuration;
}
var context = new webkitAudioContext();
var playlist = new TrackList(context);

$(document).ready(function() {
  function UserInterface() {
    var CKEY = 67;
    var SKEY = 83;
    var selectStart;
    var selectEnd;
    var selectedTrack;
    setupTemplate()
    var trackView = new TrackView();

    $(document).on("keyup", keyUpEvent);
    $(document).on("keydown", keyDownEvent);
    $('#track_list').on('mouseup', '.audio_clip', updateDelay);
    $('#track_list').click(clickRouter)
    $('#add_track').click( addTrack );
    $('#play_all').click( playAll );
    $('#stop_all').click( stopAll );


    function clickRouter(e){
      switch ($(e.target).attr('class')){
        case ('pause_track'):
          pauseTrack($(e.target));
          break;
        case ('resume_track'):
          resumeTrack($(e.target));
          break;
        case ('stop_track'):
          stopTrack($(e.target));
          break;
      }
    }

    function keyDownEvent(e) {
      switch (e.which) {
        case (SKEY):
          createSoundSelection();
          break;
      }
    }

    function keyUpEvent(e) {
      switch (e.which) {
        case (CKEY):
          cropSelection();
        break;
      }
    }

    function addTrack() {
      var url = '/james_bond.wav';
      // TODO dynamically get the url via a menu of options
      var lastTrack = _.max(playlist.tracks,function(track){return track.index;});
      var index = _.max([lastTrack.index + 1, 0]);
      var track = new Track({index:index, url:url, context:context});
      playlist.addTrack(track);
    }

    function playAll() {
      playlist.playAllAt(0);
    }

    function stopAll() {
      playlist.stopAll(0);
    }


    function pauseTrack(target) {
      target.html('>');
      target.removeClass();
      target.addClass('resume_track');
      var index = target.parent().parent().data('index');
      playlist.tracks[index].pause();
    }

    function resumeTrack(target) {
      target.html('||');
      target.removeClass();
      target.addClass('pause_track');
      var index = target.parent().parent().data('index');
      playlist.tracks[index].resume();
    }

    function stopTrack(target) {
      var playPauseButton = target.parent().children('.pause_track');
      playPauseButton.html('>');
      playPauseButton.removeClass();
      playPauseButton.addClass('resume_track');
      var index = target.parent().parent().data('index');
      playlist.tracks[index].stop();
    }

    function setSelectedTrack(e) {
      var index = $(e.target).closest('li').data('index');
      selectedTrack = playlist.tracks[index];
    }

    function updateDelay(e) {
      setSelectedTrack(e);
      var left = parseInt($(this).css("left"), 10);
      var delay = secondize(left);
      selectedTrack.setDelay(delay);
    }


    function createSoundSelection() {
      $('.audio_clip').draggable('disable');
      $('#track_list').on("mousedown", '.audio_clip', startSoundSelection);
      enableDragging();
    }

    function startSoundSelection(e) {
      setSelectedTrack(e);
      var parentOffset = $(this).offset();
      selectStart = e.pageX - parentOffset.left;
      $(this).mouseup( endSoundSelection );
    }

    function endSoundSelection(e) {
      var parentOffset = $(this).offset();
      selectEnd = e.pageX - parentOffset.left;
    }

    function enableDragging() {
      $(document).on("keyup", function() {
        $('.audio_clip').draggable('enable');
      });
    }

    function cropSelection() {
      console.log('current offset = ' + selectedTrack.offset + ' , current delay = ' + selectedTrack.delay);
      selectedTrack.setOffset(selectedTrack.offset + secondize(Math.min(selectStart, selectEnd)));
      selectedTrack.setDelay(selectedTrack.delay + secondize(Math.min(selectStart, selectEnd)));
      console.log('new offset = ' + selectedTrack.offset + ' , new delay = ' + selectedTrack.delay);

      selectedTrack.setDuration(secondize(Math.abs(selectEnd - selectStart)));
    }

    function setupTemplate() {
      _.templateSettings = {
        interpolate: /\{\{\=(.+?)\}\}/g,
        evaluate: /\{\{(.+?)\}\}/g,
        variable: "obj"
      };
    }

  }
  UserInterface();
});
