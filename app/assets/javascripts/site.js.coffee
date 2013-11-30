$(document).ready ->
  # Initialize Foundation
  $(document).foundation()

  # Close alert-boxes automatically
  if ($('.alert-box').length > 0)
    setTimeout((() -> $('.alert-box .close').click()), 3000)
