class window.ListView extends Backbone.View
  el: $("body")
  initialize: ->
    @counter = 0
    @render()
    @display_tag = $("ul")
  events:
    "click button#add": "addItem"
  render: =>
    @el.append("<button id='add'>Add list item</button>")
    @el.append("<ul></ul>")
  addItem: ->
    @counter++
    @display_tag.append("<li>hello world #{@counter}</li>")

$ ->
  list_view = new ListView()
