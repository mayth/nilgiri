require 'time'

Nilgiri::Admin.controllers :seasons do
  get :index do
    @title = "Seasons"
    @seasons = Season.all
    render 'seasons/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'season')
    t = Time.now
    @season = Season.new(start: t, expiry: t.next_month)
    render 'seasons/new'
  end

  post :create do
    begin
      params[:season]['start'] = Time.parse(params[:season]['start'])
      params[:season]['expiry'] = Time.parse(params[:season]['expiry'])
    rescue ArgumentError
      @title = pat(:create_title, model: 'season')
      flash.now[:error] = pat(:create_error, model: 'season')
      render 'seasons/new'
    end

    @season = Season.new(params[:season])
    if @season.save
      @title = pat(:create_title, :model => "season #{@season.id}")
      flash[:success] = pat(:create_success, :model => 'Season')
      params[:save_and_continue] ? redirect(url(:seasons, :index)) : redirect(url(:seasons, :edit, :id => @season.id))
    else
      @title = pat(:create_title, :model => 'season')
      flash.now[:error] = pat(:create_error, :model => 'season')
      render 'seasons/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "season #{params[:id]}")
    @season = Season.find(params[:id])
    if @season
      render 'seasons/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'season', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "season #{params[:id]}")
    @season = Season.find(params[:id])
    if @season
      begin
        params[:season]['start'] = Time.parse(params[:season]['start'])
        params[:season]['expiry'] = Time.parse(params[:season]['expiry'])
      rescue ArgumentError
        flash.now[:error] = pat(:update_error, :model => 'season')
        render 'seasons/edit'
      end
      if @season.update_attributes(params[:season])
        flash[:success] = pat(:update_success, :model => 'Season', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:seasons, :index)) :
          redirect(url(:seasons, :edit, :id => @season.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'season')
        render 'seasons/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'season', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Seasons"
    season = Season.find(params[:id])
    if season
      if season.destroy
        flash[:success] = pat(:delete_success, :model => 'Season', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'season')
      end
      redirect url(:seasons, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'season', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Seasons"
    unless params[:season_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'season')
      redirect(url(:seasons, :index))
    end
    ids = params[:season_ids].split(',').map(&:strip)
    seasons = Season.find(ids)
    
    if Season.destroy seasons
    
      flash[:success] = pat(:destroy_many_success, :model => 'Seasons', :ids => "#{ids.to_sentence}")
    end
    redirect url(:seasons, :index)
  end
end
