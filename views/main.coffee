$ ->

  root = $('#impress')[0]

  # Prevent clicking of map from triggering that step.
  root.addEventListener 'click', (event) ->
    el = $(event.target)

    isMapStep = el.attr('id') == 'map'
    isChildOfMapStep = el.parents('#map').length >= 1
    isNotCurrentLocation = el.location != window.currentLocation
    if isMapStep or isChildOfMapStep or isNotCurrentLocation
      event.stopImmediatePropagation()

  impress().init()

  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    locationName = step.data('location')

    # Set currentLocation.
    window.currentLocation = locationName

    # A smoother transition from Aachen_end to the_end.
    if step.attr('id') == 'end_Aachen'
      setLocationBackgroundImage('none')
      return

    # Set background image to image for current location.
    if locationName
      backgroundImageProperty = "url('images/location_backgrounds/#{locationName}.jpg')"
      setLocationBackgroundImage(backgroundImageProperty)
    else
      setLocationBackgroundImage('none')

  setLocationBackgroundImage = (value) ->
    body = $('#outerImpress')
    unless body.css('background-image') == value
      body.css 'background-image', value

$.fn.location = ->
  ownLocation = $(this).data('location')

  if ownLocation
    return ownLocation
  else
    $(this).parents('.step').data('location')
