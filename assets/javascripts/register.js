/***** register form *****/
var machine_params = {
  'iidxsp': {'type': 'int', 'diff': ['NORMAL', 'HYPER', 'ANOTHER']},
  'iidxdp': {'type': 'int', 'diff': ['NORMAL', 'HYPER', 'ANOTHER']},
  'popn': {'type': 'int', 'diff': ['NORMAL', 'HYPER', 'EX']},
  'gfg': {'type': 'perc', 'diff': ['BASIC', 'ADVANCED', 'EXTREME', 'MASTER']},
  'gfb': {'type': 'perc', 'diff': ['BASIC', 'ADVANCED', 'EXTREME', 'MASTER']},
  'dm': {'type': 'perc', 'diff': ['BASIC', 'ADVANCED', 'EXTREME', 'MASTER']},
  'ddrsp': {'type': 'int', 'diff': ['BEGINNER', 'BASIC', 'DIFFICULT', 'EXPERT', 'CHALLENGE']},
  'ddrdp': {'type': 'int', 'diff': ['BASIC', 'DIFFICULT', 'EXPERT', 'CHALLENGE']},
  'jb': {'type': 'int', 'diff': ['BASIC', 'ADVANCED', 'EXTREME']},
  'rb': {'type': 'perc', 'diff': ['BASIC', 'MEDIUM', 'HARD']},
  'sdvx': {'type': 'int', 'diff': ['NOVICE', 'ADVANCED', 'EXHAUST', 'INFINITE']},
  'dea': {'type': 'int', 'diff': ['LIGHT', 'STANDARD', 'EXTREME', 'MASTER', 'STEALTH']},
  'ftt': {'type': 'int', 'diff': ['ベーシック', 'スーパー', 'ウルトラ']},
  'mm': {'type': 'int', 'diff': ['EASY', 'BASIC', 'ADVANCED', 'EXPERT', 'MASTER']}
};
var type_patterns = {
  'int': '(0|[1-9][0-9]*)',
  'perc': '(0|[1-9][0-9]*)(\.[0-9]+)?'
}

function setDifficulty(diff_name) {
  var $diff_sel = $('#difficulty');
  $diff_sel.empty();
  $.each(diff_name, function(idx, val) {
    $diff_sel.append($('<option>').text(val));
  });
}

function changeToIntegerForm($score_form) {
  $('#score_type').val('int');
  $score_form.attr('pattern', type_patterns['int']);
  if ($score_form.parent().hasClass('input-append')) {
    $score_form.unwrap();
    $score_form.parent().children('.add-on').remove();
  }
}

function changeToPercentForm($score_form) {
  $('#score_type').val('perc');
  $score_form.attr('pattern', type_patterns['perc']);
  $score_form.wrap($('<div>').addClass('input-append'));
  $score_form.parent().append($('<span>').addClass('add-on').text('%'));
}

function setScoreType(type) {
  var $score_form = $('#score');
  if (type === 'int') {
    changeToIntegerForm($score_form);
  } else if (type === 'perc') {
    changeToPercentForm($score_form);
  } else {
    changeToIntegerForm($score_form);
  }
}

function setupForm() {
  var v = machine_params[$('#machine option:selected').val()];
  setDifficulty(v['diff']);
  setScoreType(v['type']);
}

$(document).ready(function() {
  if ($('body').attr('id') === 'score_register') {
    // events
    $('#machine').change(function() {
      setupForm();
    });

    // init
    setupForm();
  }
});
