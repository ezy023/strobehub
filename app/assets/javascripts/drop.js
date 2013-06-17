window.addEventListener('load', function(){
  var dropzone = document.getElementById('dropzone');
  // var header = document.getElementById('paragraph');

  // header.ondragstart = function(e){
  //   console.log("Drag has started"); 
  // }
  dropzone.ondragover = function(e){
    // var data = e.dataTransfer.mozSetData("application/x-moz-file", file, 0);
    e.preventDefault(); 
    var dt = e.dataTransfer;
  }

  dropzone.ondrop = function(e){
    e.preventDefault();
    var dt = e.dataTransfer;
    var files = dt.files;
    var xhr = new XMLHttpRequest();
    var form = document.getElementById("song_upload");
    var formData = new FormData(form);
    var entry;
    for (var i = 0; i < files.length; i++) {
      entry = files[i];
      //if(entry instanceof File){ console.log("ITS A FILE"); console.log(entry.name);  } 
      formData.append("song_file", entry);
      xhr.open("POST", "http://localhost:3000/tracks", true);
      xhr.onload = function(evt){
        var songs = document.getElementById('songs');
        var song_div = document.createElement('audio');
        var source_div = document.createElement('source');
        source_div.setAttribute('src', xhr.response);
        source_div.setAttribute('type', "audio/mp3");
        song_div.setAttribute('controls', "controls");
        song_div.innerHTML += "Song";
        song_div.appendChild(source_div);
        songs.appendChild(song_div);
        console.log(song_div);
      }
      xhr.send(formData);
      debugger;
    }
    console.log("THE DROP");
  }

  var uploadFile = function(file){
    var xhr = new XMLHttpRequest(); 
  }

});
