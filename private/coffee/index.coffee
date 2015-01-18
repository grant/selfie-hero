$ = require 'jquery'

$(window).scroll ->
  clearTimeout $.data(this, "scrollTimer")
  $.data this, "scrollTimer", setTimeout(->

    # do something
    $(".menu").fadeIn()
    $("#camera").fadeIn()
  , 250)

  $(".menu").fadeOut()
  $("#camera").fadeOut()

# camera logic to pass the event to the actual file input
$("#camera").click ->
  $("#take-picture").click()


$("#take-picture").change (event) ->
  # Get a reference to the taken picture or chosen file
  files = event.target.files
  file = undefined
  file = files[0] if files and files.length > 0
  formData = new FormData()
  formData.append 'file', file

  console.log formData
  $.ajax
    url: '/api/photos'
    data: formData
    processData: false
    type: 'POST'
    success: (data) ->
      console.log data

  event.preventDefault()
  # # Image reference
  # showPicture = $("#new-photo")

  # # Get window.URL object
  # URL = window.URL or window.webkitURL

  # # Create ObjectURL
  # imgURL = URL.createObjectURL(file)

  # # Set img src to ObjectURL
  # showPicture.src = imgURL

  # # For performance reasons, revoke used ObjectURLs
  # URL.revokeObjectURL imgURL
