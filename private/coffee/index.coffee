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
api.post.users("rogerthechen@gmail.com") (res) ->
  console.log(res)
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
  photo_id = $(this).attr("data-photo-id")
  hearts_text = $(this).find(".likes-text")
  hearts_wrapper = $(this).find(".likes-container")
  num_likes = parseInt(hearts_text.text())
  $(this).find('.overlay').fadeIn('slow')
  $(this).find('.overlay').fadeOut()
  token = $("#api-token").val()
  console.log token
  api.post.heart(photo_id, token) (body) ->
    console.log "liked"
    console.log body
    hearts_text.text(body.heart_count)
    # toggles color
    if body.heart_status
      hearts_wrapper.removeClass("text-light").addClass("text-primary")
    else
      hearts_wrapper.removeClass("text-primary").addClass("text-light")

$('#recency-sort').click ->
  $("#sorting-order").value = "recency"
  console.log("switched to recency sort")
  $(this).removeClass("btn-primary").addClass("btn-default")

$('#hearts-sort').click ->
  $("#sorting-order").value = "hearts"
  console.log("switched to hearts sort")
  $(this).removeClass("btn-primary").addClass("btn-default")
