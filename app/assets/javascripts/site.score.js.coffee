updateDifficulties = (data, e) ->
  e.empty()
  e.append($('<option>').text('Choose difficulty').attr('value', '').select())
  for val in data
    e.append($('<option>').text(val).attr('value', val))

updatePlaystyles = (data, e) ->
  e.empty()
  if data.length != 0
    e.removeAttr('disabled')
    e.attr('required', '')
    e.append($('<option>').text('Choose playstyle').attr('value', '').select())
    for val in data
      e.append($('<option>').text(val).attr('value', val))
  else
    e.attr('disabled', '')
    e.removeAttr('required')

updateMusics = (data, e) ->
  e.empty()
  if data.length == 0
    e.attr('disabled', '')
    e.append($('<option>').text('Unavailable...').attr('value', '').select())
  else if data.length == 1
    music = data[0]
    e.append($('<option>').text(music['name']).attr('value', music['id']).select())
  else
    e.append($('<option>').text('Choose music').attr('value', '').select())
    for val in data
      e.append($('<option>').text(val['name']).attr('value', val['id']))

window.score_new = () ->
  q = (query) -> $('#new_score ' + query)
  q('#machine').change(() ->
    season = q('#score_season').val()
    machine_id = $(this).val()
    $.get("/machines/#{machine_id}.json",
      (machine) ->
        updateDifficulties(machine['difficulties'], q('#score_difficulty'))
        updatePlaystyles(machine['playstyles'], q('#score_playstyle'))
        $.get("/machines/#{machine_id}/musics.json",
          (musics) ->
            updateMusics(musics, q('#score_music_id'))
        )
    )
  )

