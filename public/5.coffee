Backbone.sync = (method, model, success, error) =>
  success()

class Item extends Backbone.Model
  defaults:
    part1: "hello"
    part2: "world"

class List extends Backbone.Collection
  model: Item

class ItemView extends Backbone.View
  tagName: "li"
  events:
    "click span.swap": "swap"
    "click span.remove": "remove"
  initialize: ->
    @model.bind('change', @render)
    @model.bind('remove', @unrender)

  render: =>
    swap_html = "<span class='swap' style='color:blue;'>[swap]</span>"
    remove_html = "<span class='remove' style='color:red;'>[remove]</span>"
    $(@el).html("<span>#{@model.get('part1')} #{@model.get('part2')}</span>&nbsp;&nbsp;" + swap_html + remove_html)
    return @

  unrender: =>
    $(@el).remove()

  swap: ->
    swapped =
      part1: @model.get('part2')
      part2: @model.get('part1')
    @model.set(swapped)

  remove: ->
    @model.destroy()

class ListView extends Backbone.View
  el: $("body")
  initialize: ->
    @collection = new List()
    @collection.bind('add', @appendItem)
    @counter = 0
    @render()
    @display_tag = $("ul")
  events:
    "click button#add": "addItem"
  render: ->
    @el.append("<button id='add'>Add list item</button>")
    @el.append("<ul></ul>")
    for item in @collection
      @appendItem item
  addItem: ->
    @counter++
    item = new Item()
    item.set({
      part2: item.get('part2') + " #{@counter}!"
    })
    @collection.add(item)
  appendItem: (item) =>
    item_view = new ItemView({model: item})
    @display_tag.append(item_view.render().el)

$ ->
  list_view = new ListView()
