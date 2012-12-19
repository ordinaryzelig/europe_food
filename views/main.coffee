$ ->

  root = $('#impress')[0]

  # Prevent undesirable clicks:
  #   clicking on map
  #   clicking on other countries' images that just happen to be in the vicinity.
  root.addEventListener 'click', (event) ->
    el = $(event.target)
    isMapStep = el.attr('id') == 'map'
    isChildOfMapStep = el.parents('#map').length >= 1
    if isMapStep or isChildOfMapStep
      event.stopImmediatePropagation()
      return

    isNotCurrentLocation = el.getLocation() != window.currentLocation

  ##############
  # impress:init
  ##############

  # When initializing, mark instructionsShown as false.
  root.addEventListener 'impress:init', (event) ->
    window.instructionsShown = false

  impress().init()

  ###################
  # impress:stepenter
  ###################

  # Set background image to image for current location.
  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    locationName = step.data('location')

    # Set currentLocation.
    window.currentLocation = locationName

    # Set background image.
    if locationName
      backgroundImageProperty = "url('images/location_backgrounds/#{locationName}.jpg')"
      setLocationBackgroundImage(backgroundImageProperty)
    else
      setLocationBackgroundImage('none')

  # Show instructions if we're on the map step for the first time.
  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    if step.attr('id') == 'map' and !window.instructionsShown
      showInstructions()

  # A smoother transition from end_Aachen to the_end.
  root.addEventListener 'impress:stepenter', (even) ->
    step = $(event.target)
    if step.attr('id') == 'end_Aachen'
      setLocationBackgroundImage('none')

  ########################
  # Hide/Show instructions
  ########################

  # Remove instructions when leaving step.
  root.addEventListener 'impress:stepleave', (event) ->
    hideInstructions()

  # Show instructions when clicked.
  $('#showInstructions').click (event) ->
    showInstructions()

  # Remove instructions when clicked.
  $('#instructions').click (event) ->
    hideInstructions()

  showInstructions = ->
    window.instructionsShown = true
    $('#instructions').fadeIn()

  hideInstructions = ->
    $('#instructions').fadeOut()

  #########
  # Helpers
  #########

  setLocationBackgroundImage = (value) ->
    body = $('#outerImpress')
    unless body.css('background-image') == value
      body.css 'background-image', value

###############
# jQery Helpers
###############

# Get the location of an element from either itself or a parent step.
$.fn.getLocation = ->
  ownLocation = $(this).data('location')
  if ownLocation
    return ownLocation
  else
    $(this).parents('.step').data('location')