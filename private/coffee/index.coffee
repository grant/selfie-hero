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

$('#take-picture').submit (event) ->
  event.preventDefault()

  # file
  # formData = new FormData($(this)[0])
  # console.log $(this)[0]
  # console.log formData
  formData = new FormData()
  file = event.target.files[0]
  formData.append 'photo', file, file.name
  formData.append 'token', '0Zj1B63fZVPrENzf0wc_Dg'

  $.ajax
    url: 'http://104.236.41.161/api/photos'
    type: 'POST'
    data: formData
    async: false
    cache: false
    contentType: false
    processData: false
    success: (returnedData) ->
      console.log returnedData

  return false

$('#take-picture').change (event) ->
  $('#take-picture').submit()
  # Get a reference to the taken picture or chosen file
  # files = event.target.files
  # file = undefined
  # file = files[0] if files and files.length > 0

  # console.log file


  # imageToBase64 file, (base64) ->
  #   $.post '/api/photos', photo: base64, (e) ->
  #     console.log 'replied'


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
