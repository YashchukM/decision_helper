# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $("input").on "change", (ev) ->
    name = $(@).attr('name').trim()
    val = $(this).val()
    $('input:hidden[name=\'' + name + '\']').val(val)