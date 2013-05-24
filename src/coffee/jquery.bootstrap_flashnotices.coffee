#
# jquery plugin for a flashmessenger using twitter bootstrap alerts...
#
# @author Alexander Nickel
# @date 2013-01-30T09:39:51Z
#
$ = jQuery

config =
  container: null
  message_visible: 10000

# the methods
methods =
  init: (options) ->
    # set options
    $.extend config, options
    
    # create the container for the flashnotices...
    if $("#flashnotices").length < 1
      config.container = $("<div id=\"flashnotices\"></div>")
      config.container.prependTo $("#wrapper")
  
  create_notice: (message,type) ->
    # create the flashnotice and insert into flashnotices...
    message = $("<div class=\"alert alert-#{type} fade in\"><button class=\"close\" data-dismiss=\"alert\">&times;</button>#{message}</div>")
    message.prependTo config.container
    message.delay(config.message_visible).fadeOut -> $(this).remove()
  
  info: (message) -> methods.create_notice message, "info"
  
  success: (message) -> methods.create_notice message, "success"
  
  error: (message) -> methods.create_notice message, "error"

# the jquery plugin
$.flashnotices = (method,options...) ->
  if methods[method]
    methods[method].apply this, options
  else if typeof method is "object" or not method
    methods.init.apply this, arguments
  else
    $.error "Method " + method + " does not exist in Bootstrap Flashnotices Plugin"