updateDifficulties = (data, e) ->
  e.empty()
  if data.length == 0
    e.attr('disabled', '')
    e.append($('<option>').text('N/A').attr('value', '').select())
  else
    e.removeAttr('disabled')
    e.attr('required', '')
    e.append($('<option>').text('Choose difficulty').attr('value', '').select())
    for val in data
      e.append($('<option>').text(val).attr('value', val))

updatePlaystyles = (data, e) ->
  e.empty()
  if data.length == 0
    e.attr('disabled', '')
    e.removeAttr('required')
    e.append($('<option>').text('N/A').attr('value', '').select())
  else
    e.removeAttr('disabled')
    e.attr('required', '')
    e.append($('<option>').text('Choose playstyle').attr('value', '').select())
    for val in data
      e.append($('<option>').text(val).attr('value', val))

updateMusics = (data, e) ->
  e.empty()
  if data.length == 0
    e.attr('disabled', '')
    e.append($('<option>').text('N/A').attr('value', '').select())
  else
    e.removeAttr('disabled')
    e.attr('required', '')
    if data.length == 1
      music = data[0]
      e.append($('<option>').text(music['name']).attr('value', music['id']).select())
    else
      e.append($('<option>').text('Choose music').attr('value', '').select())
      for val in data
        e.append($('<option>').text(val['name']).attr('value', val['id']))

resetAll = (elements) ->
  updateDifficulties([], elements.difficulty)
  updatePlaystyles([], elements.playstyle)
  updateMusics([], elements.music)


window.score_new = () ->
  q = (query) -> $('#new_score ' + query)
  resetAll({
    difficulty: q('#score_difficulty'),
    playstyle: q('#score_playstyle'),
    music: q('#score_music_id')
  })
  q('#machine').change(() ->
    machine_id = $(this).val()
    if (!machine_id? || machine_id == '')
      resetAll()
      return

    season = q('#score_season_id').val()
    $.get("/machines/#{machine_id}.json",
      (machine) ->
        updateDifficulties(machine['difficulties'], q('#score_difficulty'))
        updatePlaystyles(machine['playstyles'], q('#score_playstyle'))
        $.get("/machines/#{machine_id}/musics.json", {season_id: season},
          (musics) ->
            updateMusics(musics, q('#score_music_id'))
        )
    )
  )

