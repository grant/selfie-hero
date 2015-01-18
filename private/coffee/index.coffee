$ = require 'jquery'
api = require './api'
moment = require 'moment'

SERVER_URL = "http://104.236.41.161"

# handlebars template
renderPhoto = Handlebars.compile($("#photo-template").html())

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
  formData.append 'token', $("#api-token").val()
  formData.append 'latitude', 39.9500
  formData.append 'longitude', 75.1900

  $.ajax
    url: 'http://104.236.41.161/api/photos'
    type: 'POST'
    data: formData
    async: false
    cache: false
    contentType: false
    processData: false
    success: (returnedData) ->
      data = JSON.parse(returnedData)
      timestamp_text = moment(data.created_at).fromNow()
      newPhoto =
        url: data.url
        created_at_text: timestamp_text
        id: data.id
        hearts_count: data.hearts_count
      newPhoto = $(renderPhoto(newPhoto))
      $(".photo-list").prepend(newPhoto)
      newPhoto.click ->
        heartPhoto($(this))
  return false

heartPhoto = (obj) ->
  photo_id = obj.attr("data-photo-id")
  hearts_text = obj.find(".likes-text")
  hearts_wrapper = obj.find(".likes-container")
  num_likes = parseInt(hearts_text.text())
  obj.find('.overlay').fadeIn('slow')
  obj.find('.overlay').fadeOut()
  token = $("#api-token").val()
  console.log token
  api.post.heart photo_id, token, (body) ->
    hearts_text.text(body.heart_count)
    if body.heart_status
      hearts_wrapper.removeClass("text-light").addClass("text-primary")
    else
      hearts_wrapper.removeClass("text-primary").addClass("text-light")
$('#take-picture').change (event) ->
  $('#take-picture').submit()

$('.photo').click ->
  heartPhoto($(this))

$('#recency-sort').click ->
  $("#sorting-order").value = "recency"
  console.log("switched to recency sort")
  $("#hearts-sort").removeClass("btn-primary").addClass("btn-default")
  $("#recency-sort").removeClass("btn-default").addClass("btn-primary")
  api.get.photos "recency", (body) ->
    console.log($("#photos-list"))
    console.log(body)
    $("#photos-list").empty()
    # for selfie in body
      # $("#photos-list").append(renderPhoto(selfie))

$('#hearts-sort').click ->
  $("#sorting-order").value = "hearts"
  console.log("switched to hearts sort")
  $("#recency-sort").removeClass("btn-primary").addClass("btn-default")
  $(this).removeClass("btn-default").addClass("btn-primary")
  api.get.photos "hearts", (body) ->
    $("#photos-list").html("")
    console.log($("#photos-list"))
    # for selfie in body
      # $("#photos-list").append(renderPhoto(selfie))
