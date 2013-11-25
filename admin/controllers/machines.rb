Nilgiri::Admin.controllers :machines do
  get :index do
    @title = "Machines"
    @machines = Machine.all
    render 'machines/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'machine')
    @machine = Machine.new
    render 'machines/new'
  end

  post :create do
    @machine = Machine.new(params[:machine])
    if @machine.save
      @title = pat(:create_title, :model => "machine #{@machine.id}")
      flash[:success] = pat(:create_success, :model => 'Machine')
      params[:save_and_continue] ? redirect(url(:machines, :index)) : redirect(url(:machines, :edit, :id => @machine.id))
    else
      @title = pat(:create_title, :model => 'machine')
      flash.now[:error] = pat(:create_error, :model => 'machine')
      render 'machines/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "machine #{params[:id]}")
    @machine = Machine.find(params[:id])
    if @machine
      render 'machines/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'machine', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "machine #{params[:id]}")
    @machine = Machine.find(params[:id])
    if @machine
      if @machine.update_attributes(params[:machine])
        flash[:success] = pat(:update_success, :model => 'Machine', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:machines, :index)) :
          redirect(url(:machines, :edit, :id => @machine.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'machine')
        render 'machines/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'machine', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Machines"
    machine = Machine.find(params[:id])
    if machine
      if machine.destroy
        flash[:success] = pat(:delete_success, :model => 'Machine', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'machine')
      end
      redirect url(:machines, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'machine', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Machines"
    unless params[:machine_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'machine')
      redirect(url(:machines, :index))
    end
    ids = params[:machine_ids].split(',').map(&:strip)
    machines = Machine.find(ids)
    
    if Machine.destroy machines
    
      flash[:success] = pat(:destroy_many_success, :model => 'Machines', :ids => "#{ids.to_sentence}")
    end
    redirect url(:machines, :index)
  end
end
