$(window).scroll ->
  clearTimeout $.data(this, "scrollTimer")
  $.data this, "scrollTimer", setTimeout(->
    
    # do something
    $(".menu").fadeIn()
    $("#camera").fadeIn()
  , 250)

  $(".menu").fadeOut()
  $("#camera").fadeOut()