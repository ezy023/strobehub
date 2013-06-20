function pixelize(seconds){
  return Math.floor(seconds / 60 * 600);
}

function secondize(pixels){
  return pixels / 600 * 60;
}

var context = new webkitAudioContext();
var playlist = new TrackList(context);

$(document).ready(function() {
  function UserInterface() {
    var CKEY = 67;
    var SKEY = 83;
    var SPACE = 32;
    var selectStart;
    var selectEnd;
    var selectedTrack;
    setupTemplate();
    var trackView = new TrackView();
    var scrollController = new ScrollController();

    var url = window.location.pathname + ".json";
    $.getJSON(url, function(data) {
      $.each(data, function(index, track) {
        loadTrack(track.id, track.url, track.offset, track.delay, track.duration);
      });
    });

    $(document).on("keyup", keyUpEvent);
    $(document).on("keydown", keyDownEvent);
    $('#track_list').on('mousedown', '.audio_clip', updateDelay);
    $('ul').on('click',clickRouter)
    $('#add_track').click( createTrack );
    $('#play_all').click( playAll );
    $('#stop_all').click( stopAll );
    $('#save_version').submit( checkUser );


    function clickRouter(e){
      e.preventDefault();
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
        case ('delete'):
          deleteClick($(e.target));
          break;
        case ('delete_confirm'):
          deleteConfirm($(e.target));
          break;
        case ('delete_cancel'):
          deleteCancel($(e.target));
          break;
        case ('show_hide'):
          showHide($(e.target));
          break;
      }
    }

    function showHide(target) {
      $('.show_hide').toggle(300);
      getTrackList().slideToggle(300);
    }

    function getTrackList(){
      return $('#track_list');
    }

    function deleteClick(target){
      var confirm = "<a class='delete_confirm' href='#'>confirm</a>"
      var cancel =  "<a class='delete_cancel' href='#'>cancel</a>"
      target.closest("span").html(cancel + '&nbsp;' + confirm);
    }

    function deleteConfirm(target){
      var targetRow = target.closest('li')
      var index = targetRow.data('index');
      playlist.tracks[index].deleteTrack();
      targetRow.remove();
    }

    function deleteCancel(target){
      var deleteLink = "<a class='delete' href='#'>delete</a>"
      target.closest("span").html(deleteLink);
    }

    function keyDownEvent(e) {
      switch (e.which) {
        case (SKEY):
          createSoundSelection();
          break;
        case (SPACE):
          playAll();
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

    var dropzone = document.getElementById('dropzone');
    dropzone.ondragover = function(e){
      e.preventDefault();
      var dt = e.dataTransfer;
    }

    dropzone.ondrop = function(e){
      e.preventDefault();
      var dt = e.dataTransfer;
      var files = dt.files;
      var form = document.getElementById("song_upload");
      for (var i = 0; i < files.length; i++) {
        var xhr = new XMLHttpRequest();
        var formData = new FormData(form);
        var entry = files[i];
        formData.append("song_file", entry);
        xhr.open("POST", "/tracks", true);
        xhr.onload = function(evt){
          createTrack(this.response);
        }
        xhr.send(formData);
        displayLoader(i);
      }
    }

    function displayLoader(unique_id){
      var empty_track_div = document.createElement('div');
      empty_track_div.setAttribute('class', "loading_track track_row");
      $('#track_list').prepend(empty_track_div);
    }

    function createTrack(url) {
      var url = url;
      var lastTrack = _.max(playlist.tracks,function(track){return track.index;});
      var index = _.max([lastTrack.index + 1, 0]);
      var track = new Track({index:index, url:url, context:context});
      playlist.addTrack(track);
    }

    function loadTrack(id, url, offset, delay, duration) {
      var id = id;
      var lastTrack = _.max(playlist.tracks,function(track){return track.index;});
      var index = _.max([lastTrack.index + 1, 0]);
      var url = url;
      var offset = offset;
      var delay = delay;
      var duration = duration;
      var track = new Track({id:id, index:index, url:url, context:context, offset:offset, delay:delay, duration:duration});
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
      var index = target.closest('li').data('index');
      playlist.tracks[index].pause();
    }

    function resumeTrack(target) {
      target.html('||');
      target.removeClass();
      target.addClass('pause_track');
      var index = target.closest('li').data('index');
      playlist.tracks[index].resume();
    }

    function stopTrack(target) {
      var playPauseButton = target.parent().children('.pause_track');
      playPauseButton.html('>');
      playPauseButton.removeClass();
      playPauseButton.addClass('resume_track');
      var index = target.closest('li').data('index');
      playlist.tracks[index].stop();
    }

    function setSelectedTrack(e) {
      var index = $(e.target).closest('li').data('index');
      selectedTrack = playlist.tracks[index];
    }

    function updateDelay(e) {
      setSelectedTrack(e);
      $(document).mouseup(function() {
        var left = parseInt($('#track_'+selectedTrack.index).find('.audio_clip').css("left"));
        var delay = secondize(left);
        selectedTrack.setDelay(delay);
      });
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

    function checkUser(e) {
      e.preventDefault();
      var currentUser = $('#current_user').html();
      var versionOwner = $('#version_owner').html();
      if (currentUser === versionOwner) {
        url = $(this).find('form').attr('action')
        saveVersion(url);
      } else if (currentUser === "") {
        window.location.href = '/login';
      } else {
        sporkVersion();
      }
    }

    function saveVersion(url) {
      $.ajax({
        type: "POST",
        url: url,
        dataType: 'json',
        contentType: 'application/json',
        data: playlist.toJSONString()
      });
    }

    function sporkVersion() {
      var url = $('#spork_version form').attr('action');
      $.post(url, function(newPath) {
        var repoID = newPath.repository_id;
        var versionID = newPath.version_id;
        var url = '/repositories/' + repoID + '/versions/' + versionID;
        window.location.href = url;
      });
    }
  }
  UserInterface();
});
