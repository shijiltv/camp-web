window.lastBlogIndex = -1
window.createBlogView = (blog) ->
  body = ""
  body += '<div class="row" id="blog-'+window.lastBlogIndex+'" style="display: none">'
  body += ' <a href="'+blog.link+'" target="_blank">'
  body += '   <div class="col-sm-12">'
  body += '     <h4 class="title">'
  body += '       ' + blog.title
  body += '     </h4>'
  body += '   </div>'
  body += '   <div class="col-sm-12">'
  body += '     <span class="body">'
  body += '       ' + blog.body.substring(0,260)+"..."
  body += '     </span>'
  body += '   </div>'
  body += '   <div class="col-sm-12">'
  body += '     <small class="pull-right author">'
  body += '       - ' + blog.author
  body += '     </small>'
  body += '   </div>'
  body += '  </a>'
  body += '</div>'
  $(body)

$(document).on 'ready page:load', ->
  $(".blog-slider").exists ->
    slider = $(this)
    blogs = slider.data('blogs')
    if blogs.length is 0
      $(this).remove()
      return
    animater = ->
      showNewBlog = ->
        window.lastBlogIndex++
        if blogs.length <= window.lastBlogIndex
          window.lastBlogIndex = 0
        slider.append createBlogView(blogs[window.lastBlogIndex])
        $("#blog-" + window.lastBlogIndex).show "slide",
          direction: "right"
        , 1000
      if window.lastBlogIndex isnt -1
        $("#blog-" + window.lastBlogIndex).hide "slide",
          direction: "left"
        , 1000, ->
          $(this).remove()
          showNewBlog()
      else
        showNewBlog()
    animater()
    setInterval animater, 5000
