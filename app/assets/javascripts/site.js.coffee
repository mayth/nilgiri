class window.Site
  id: $('#main-content').data('page-id')
  actions: []

  doAction: =>
    for action in this.actions
      if this.id
        if action.id == this.id
          action.fn(this)
        else if action.id == 'common'
          action.fn(this)
  
  addAction: (id, fn) =>
    this.actions.push({id: id, fn: fn})
