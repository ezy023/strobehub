window.addEventListener('load', function(){
  var dropzone = document.getElementById('dropzone');
  dropzone.ondragover = function(e){
    // var data = e.dataTransfer.mozSetData("application/x-moz-file", file, 0);
    e.preventDefault();
    var dt = e.dataTransfer;
  }

  dropzone.ondrop = function(e){
    e.preventDefault();
    var dt = e.dataTransfer;
    var files = dt.files;
    var form = document.getElementById("song_upload");
    var formData = new FormData(form);
    var entry;

    console.log(files.length);
    for (var i = 0; i < files.length; i++) {
      var xhr = new XMLHttpRequest();
      entry = files[i];
      console.log(entry.name);
      //if(entry instanceof File){ console.log("ITS A FILE"); console.log(entry.name);  }
      formData.append("song_file", entry);
      xhr.open("POST", "http://localhost:3000/tracks", false);
      xhr.onload = function(evt){
        audioClosure(entry, i, xhr)();
      }
      xhr.send(formData);
    }
  }

  function audioClosure(entry, i, xhr){
    var entry = entry;
    var iteration = i;
    return function(){
      var songs = document.getElementById('songs');
      var song_div = document.createElement('audio');
      var trackName = document.createTextNode(entry.name);
      var track_div = document.createElement('div');
      track_div.appendChild(trackName);
      track_div.setAttribute('id', "track_" + i);
      var source_div = document.createElement('source');
      source_div.setAttribute('src', xhr.response);
      source_div.setAttribute('type', "audio/mp3");
      song_div.setAttribute('controls', "controls");
      song_div.innerHTML += "Song";
      song_div.appendChild(source_div);
      songs.appendChild(track_div);
      songs.appendChild(song_div);
    }
  }

 //function progressDiv(xhrObject, trackDiv){
 //   xhrObject.upload.addEventListener('progress', function(evt){
 //     var pc = parseInt(100 - (evt.loaded/evt.total * 100);
 //     console.log(evt.loaded/evt.total*100);
 //   });
 //}

  var uploadFile = function(file){
    var xhr = new XMLHttpRequest();
  }

});
