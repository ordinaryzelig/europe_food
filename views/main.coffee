$ ->

  root = $('#impress')[0]

  # Prevent clicking of map from triggering that step.
  root.addEventListener 'click', (event) ->
    el = $(event.target)
    isMapStep = el.attr('id') == 'map'
    isChildOfMapStep = el.parents('#map').length >= 1
    if isMapStep or isChildOfMapStep
      event.stopImmediatePropagation()

  impress().init()

  # Set background image to image for current country.
  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)

    # A smoother transition from Aachen_end to the_end.
    if step.attr('id') == 'end_Aachen'
      setCountryBackgroundImage('none')
      return

    countryName = step.data('country')
    if countryName
      backgroundImageProperty = "url('images/country_backgrounds/#{countryName}.jpg')"
      setCountryBackgroundImage(backgroundImageProperty)
    else
      setCountryBackgroundImage('none')

  setCountryBackgroundImage = (value) ->
    body = $('#outerImpress')
    unless body.css('background-image') == value
      body.css 'background-image', value
