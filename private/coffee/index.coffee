$ = require 'jquery'
api = require './api'

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

$('.photo').click ->
  console.log "photo clicked!"
  photo_id = $(this).attr("data-photo-id")
  hearts_text = $(this).find(".likes-text")
  hearts_wrapper = $(this).find(".likes-container")
  num_likes = parseInt(hearts_text.text())
  console.log(photo_id)
  $(this).find('.overlay').fadeIn('slow')
  $(this).find('.overlay').fadeOut()
  api.post.heart(photo_id) (body) ->
    console.log("liked")
    console.log(body)
    hearts_text.text(num_likes+1)
    hearts_wrapper.removeClass("text-light").addClass("text-primary")
