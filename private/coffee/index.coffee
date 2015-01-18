$(window).scroll ->
  clearTimeout $.data(this, "scrollTimer")
  $.data this, "scrollTimer", setTimeout(->
    
    # do something
    $(".menu").fadeIn()
    $("#camera").fadeIn()
  , 250)

  $(".menu").fadeOut()
  $("#camera").fadeOut()

# camera logic
$("#camera").click ->
  # Get a reference to the taken picture or chosen file
  files = event.target.files
  file = undefined
  file = files[0]  if files and files.length > 0
