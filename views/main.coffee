$ ->

  impress().init()

  root = $('#impress')[0]
  body = $('#outerImpress')

  # Set background image to image for current country.
  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    countryName = step.data('country')
    if countryName
      backgroundImageProperty = "url('images/country_backgrounds/#{countryName}.jpg')"
      # Don't change it if it's the same.
      # Should get rid of a slight glitch.
      unless body.css('background-image') == backgroundImageProperty
        body.css 'background-image', backgroundImageProperty
    else
      body.css('background-image', 'none')
