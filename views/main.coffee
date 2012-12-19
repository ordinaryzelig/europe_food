$ ->

  root = $('#impress')[0]

  # Prevent clicking of map from triggering that step.
  root.addEventListener 'click', (event) ->
    el = $(event.target)

    isMapStep = el.attr('id') == 'map'
    isChildOfMapStep = el.parents('#map').length >= 1
    isNotCurrentCountry = el.country != window.currentCountry
    if isMapStep or isChildOfMapStep or isNotCurrentCountry
      event.stopImmediatePropagation()

  impress().init()

  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    countryName = step.data('country')

    # Set currentCountry.
    window.currentCountry = countryName

    # A smoother transition from Aachen_end to the_end.
    if step.attr('id') == 'end_Aachen'
      setCountryBackgroundImage('none')
      return

    # Set background image to image for current country.
    if countryName
      backgroundImageProperty = "url('images/country_backgrounds/#{countryName}.jpg')"
      setCountryBackgroundImage(backgroundImageProperty)
    else
      setCountryBackgroundImage('none')

  setCountryBackgroundImage = (value) ->
    body = $('#outerImpress')
    unless body.css('background-image') == value
      body.css 'background-image', value

$.fn.country = ->
  ownCountry = $(this).data('country')

  if ownCountry
    return ownCountry
  else
    $(this).parents('.step').data('country')
