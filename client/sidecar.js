(function() {
  var Sidecar;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Sidecar = (function() {
    function Sidecar(options) {
      this.options = options;
      this.dependency_loaded = __bind(this.dependency_loaded, this);;
      this.boot = __bind(this.boot, this);;
      this.bind("dependency_loaded", this.dependency_loaded);
      this.load_dependencies();
    }
    Sidecar.prototype.boot = function() {
      this.booted = true;
      this.client = new Faye.Client('http://localhost:9292/sidecar');
      return this.client.subscribe("/assets", this.onAsset);
    };
    Sidecar.prototype.onAsset = function() {
      return console.log("Asset Channel", arguments);
    };
    Sidecar.prototype.dependency_loaded = function(dependency) {
      this.loaded.push(dependency);
      if (this.loaded.length === this.dependencies.length && !this.booted) {
        return this.boot();
      }
    };
    Sidecar.prototype.load_dependencies = function() {
      var dependency, _i, _len, _ref, _results;
      _ref = this.dependencies;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dependency = _ref[_i];
        _results.push(this.load(dependency));
      }
      return _results;
    };
    Sidecar.prototype.loaded = [];
    Sidecar.prototype.load = function(dependency) {
      var script;
      script = document.createElement('script');
      script.setAttribute("type", "text/javascript");
      script.setAttribute("src", dependency);
      script.onload = __bind(function() {
        return this.trigger("dependency_loaded", dependency);
      }, this);
      return document.getElementsByTagName('head')[0].appendChild(script);
    };
    Sidecar.prototype.dependencies = ['http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js', 'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.2.2/underscore-min.js', 'http://localhost:9292/sidecar/faye.js'];
    Sidecar.prototype.bind = function(ev, callback, context) {
      var calls, list;
      calls = this._callbacks || (this._callbacks = {});
      list = calls[ev] || (calls[ev] = []);
      list.push([callback, context]);
      return this;
    };
    Sidecar.prototype.unbind = function(ev, callback) {
      var calls, i, l, list;
      calls = void 0;
      if (!ev) {
        this._callbacks = {};
      } else if (calls = this._callbacks) {
        if (!callback) {
          calls[ev] = [];
        } else {
          list = calls[ev];
          if (!list) {
            return this;
          }
          i = 0;
          l = list.length;
          while (i < l) {
            if (list[i] && callback === list[i][0]) {
              list[i] = null;
              break;
            }
            i++;
          }
        }
      }
      return this;
    };
    Sidecar.prototype.trigger = function(eventName) {
      var args, both, callback, calls, ev, i, l, list;
      list = void 0;
      calls = void 0;
      ev = void 0;
      callback = void 0;
      args = void 0;
      both = 2;
      if (!(calls = this._callbacks)) {
        return this;
      }
      while (both--) {
        ev = (both ? eventName : "all");
        if (list = calls[ev]) {
          i = 0;
          l = list.length;
          while (i < l) {
            if (!(callback = list[i])) {
              list.splice(i, 1);
              i--;
              l--;
            } else {
              args = (both ? Array.prototype.slice.call(arguments, 1) : arguments);
              callback[0].apply(callback[1] || this, args);
            }
            i++;
          }
        }
      }
      return this;
    };
    return Sidecar;
  })();
  new Sidecar();
}).call(this);
