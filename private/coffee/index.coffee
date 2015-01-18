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
  file = files[0]  if files and files.length > 0

  
  $("#image-form").submit()
  event.preventDefault()

$("#image-form").submit -> 
  console.log "submitting"
  $.ajax
    error: (xhr) ->
      status "Error: " + xhr.status
      return

    success: (response) ->
      if response.error
        status "Opps, something bad happened"
        return
      imageUrlOnServer = response.path
      status "Success, file uploaded to:" + imageUrlOnServer

      newImg = $("#new-photo").attr("src", "http://lorempixel.com/people/400/400").attr("class", "img-responsive photo").load ->
        newImg.prependTo($("#new-photo-wrapper"))
