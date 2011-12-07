class Sidecar
  constructor: (@options)->
    @bind "dependency_loaded", @dependency_loaded
    @load_dependencies()

  boot: ()=>
    @booted = true
    @client = new Faye.Client('http://localhost:9292/sidecar')
    @client.subscribe "/assets", @onAsset

    console.log "Sidecar Loaded"
  
  onAsset: ()->
    console.log "Asset Channel", arguments

  dependency_loaded: ( dependency )=>
    @loaded.push(dependency)
    
    if @loaded.length is 3 and not @booted
      @boot()
    else
      console.log @loaded.length
  
  load_dependencies: ()->
    _( @dependencies ).each (value, external_resource)=>
      if value is "undefined"
        @load(external_resource)
      else
        @dependency_loaded(external_resource)

  loaded: []

  load: (dependency)->
    script = document.createElement 'script'
    script.setAttribute "type", "text/javascript"
    script.setAttribute "src", dependency 

    script.onload = ()=> 
      @trigger "dependency_loaded", dependency

    document.getElementsByTagName('head')[0].appendChild script

  dependencies:{
    'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js': typeof(jQuery),
    'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.2.2/underscore-min.js': typeof(_),
    'http://localhost:9292/sidecar/faye.js':typeof(Faye)
  },
  bind: (ev, callback, context) ->
    calls = @_callbacks or (@_callbacks = {})
    list = calls[ev] or (calls[ev] = [])
    list.push [ callback, context ]
    this

  unbind: (ev, callback) ->
    calls = undefined
    unless ev
      @_callbacks = {}
    else if calls = @_callbacks
      unless callback
        calls[ev] = []
      else
        list = calls[ev]
        return this  unless list
        i = 0
        l = list.length

        while i < l
          if list[i] and callback is list[i][0]
            list[i] = null
            break
          i++
    this

  trigger: (eventName) ->
    list = undefined
    calls = undefined
    ev = undefined
    callback = undefined
    args = undefined
    both = 2
    return this  unless calls = @_callbacks
    while both--
      ev = (if both then eventName else "all")
      if list = calls[ev]
        i = 0
        l = list.length

        while i < l
          unless callback = list[i]
            list.splice i, 1
            i--
            l--
          else
            args = (if both then Array::slice.call(arguments, 1) else arguments)
            callback[0].apply callback[1] or this, args
          i++
    this


new Sidecar()
