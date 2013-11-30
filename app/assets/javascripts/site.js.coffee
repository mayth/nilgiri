$(document).ready ->
  if ($('.alert-box').length > 0)
    setTimeout((() -> $('.alert .close').click()), 3000)
