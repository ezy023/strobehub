var BufferLoader = function(context, url, callback){
  console.log("right, here");
  console.log(url);

  var request = new XMLHttpRequest();

  this.context = context;
  this.callback = callback;
  this.url = url;
  request.open("GET", url, true);
  request.responseType = "arraybuffer";

  var that = this;

  request.onload = function() {
    that.context.decodeAudioData(request.response, that.successCallback, that.errorCallback);
  };

  request.onerror = function() {
    alert('BufferLoader: XHR error');
  };

  this.errorCallback = function(error) {
    console.error('decodeAudioData error', error);
  };

  this.successCallback = function(buffer){
    if (buffer) {
      console.log("Success loading buffer: " + that.url)
      callback(buffer);
    } else {
      alert('error decoding file data: ' + that.url);
      return;
    }
  };

  request.send();
}
