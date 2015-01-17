timer = null
$(window).addEventListener "scroll", (->
  clearTimeout timer  if timer isnt null
  timer = setTimeout(->
  # fires when you haven't scrolled in 150 ms
  console.log "stopped scrolling"
  $(".menu").fadeIn()
  
  , 150)
  return
), false