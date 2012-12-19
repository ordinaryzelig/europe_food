$ ->

  impress().init()

  root = $('#impress')[0]
  body = $('#outerImpress')

  # Set background image to image for current country.
  root.addEventListener 'impress:stepenter', (event) ->
    step = $(event.target)
    countryName = step.data('country')
    if countryName
      body.css 'background-image', "url('images/country_backgrounds/#{countryName}.jpg')"
    else
      body.css('background-image', 'none')
