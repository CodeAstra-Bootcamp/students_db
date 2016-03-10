@AttendantUtils =
  init: ->
    $('.attendant_item').click ->
      StudentsDBUtils.toggle($(@).find('.fa'))
