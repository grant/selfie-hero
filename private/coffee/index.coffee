$ = require 'jquery'

$(window).scroll ->
  clearTimeout $.data(this, 'scrollTimer')
  $.data this, 'scrollTimer', setTimeout(->

    # do something
    $('.menu').fadeIn()
    $('#camera').fadeIn()
  , 250)

  $('.menu').fadeOut()
  $('#camera').fadeOut()

# camera logic to pass the event to the actual file input
$('#camera').click ->
  $('#take-picture').click()

# Converts a file to base 64
imageToBase64 = (file, cb) ->
  fr = new FileReader()
  fr.onload = (e) ->
    cb e.target.result
  fr.readAsDataURL file

$('#take-picture').change (event) ->
  # Get a reference to the taken picture or chosen file
  files = event.target.files
  file = undefined
  file = files[0] if files and files.length > 0

  imageToBase64 file, (base64) ->
    $.post '/api/photos',
      data:
        photo: base64
      success: ->
        console.log 'success'


  # Image reference

  # Get window.URL object
  # URL = window.URL or window.webkitURL

  # # Create ObjectURL
  # imgURL = URL.createObjectURL(file)

  # # Set img src to ObjectURL
  # # showPicture.src = imgURL

  # # For performance reasons, revoke used ObjectURLs
  # URL.revokeObjectURL imgURL
  # event.preventDefault()
