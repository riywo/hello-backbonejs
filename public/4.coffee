class Item extends Backbone.Model
  defaults:
    part1: "hello"
    part2: "world"

class List extends Backbone.Collection
  model: Item

class ItemView extends Backbone.View
  tagName: "li"
  initialize: ->
  render: =>
    $(@el).html("<span>#{@model.get('part1')} #{@model.get('part2')}</span>")
    return @

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
  render: =>
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

