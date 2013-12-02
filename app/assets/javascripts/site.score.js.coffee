updateDifficulties = (machine_id, e) ->
  $.get("/machine/difficulties/#{machine_id}.json",
    (data) ->
      e.empty()
      e.append($('<option>').text('Choose difficulty').attr('value', '').select())
      for val in data
        e.append($('<option>').text(val).attr('value', val))
  )

updatePlaystyles = (machine_id, e) ->
  $.get("/machine/playstyles/#{machine_id}.json",
    (data) ->
      e.empty()
      if data?
        e.removeAttr('disabled')
        e.attr('required', '')
        e.append($('<option>').text('Choose playstyle').attr('value', '').select())
        for val in data
          e.append($('<option>').text(val).attr('value', val))
      else
        e.attr('disabled')
        e.removeAttr('required')
  )

updateMusics = (machine_id, season_id, e) ->
  $.get("/machine/musics/#{machine_id}/#{season_id}.json",
    (data) ->
      e.empty()
      if data.length == 1
        music = data[0]
        e.append($('<option>').text(music['name']).attr('value', music['id']).select())
      else
        e.append($('<option>').text('Choose music').attr('value', '').select())
        for val in data
          e.append($('<option>').text(val['name']).attr('value', val['id']))
  )

$(document).ready ->
  q = (query) -> $('#score ' + query)
  q('#score_machine_id').change(() ->
    season = q('#score_season_id').val()
    machine_id = $(this).val()
    updateDifficulties(machine_id, q('#score_difficulty'))
    updatePlaystyles(machine_id, q('#score_playstyle'))
    updateMusics(machine_id, season, q('#score_music_id'))
  )
