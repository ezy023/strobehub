var BufferLoader = {
  load:function(context, url, callback){
    var request = new XMLHttpRequest();
    this.context = context;
    this.callback = callback;
    request.open("GET", url, true);
    request.responseType = "arraybuffer";
    var loader = this;

    request.onload = function() {
      loader.context.decodeAudioData(request.response, loader.successCallback,loader.errorCallback);
    };

    request.onerror = function() {
      alert('BufferLoader: XHR error');
    };

    this.errorCallback = function(error) {
      console.error('decodeAudioData error', error);
    };

    this.successCallback = function(buffer){
      if (buffer) {
        callback(buffer);
      } else {
        alert('error decoding file data: ' + url);
        return;
      }
    };
    request.send();
  }
}
