class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.order(params[:sort_param])
    @all_ratings = Movie.uniq.pluck(:rating) 
    @selected_ratings = (params[:ratings].present? ? params[:ratings].keys : []) 
    @sort_param = (params[:sort_param].present? ? params[:sort_param] : [])

    if @sort_param != []
      session[:sort_param] = @sort_param
    end

    if session[:sort_param] != []
      @movies = @movies.order(session[:sort_param])
    end
    
    if @selected_ratings != [] 
      session[:selected_ratings] = @selected_ratings
    end

    if session[:selected_ratings] != []
      @movies = @movies.where(:rating => session[:selected_ratings]) 
      #add rating to session    
    elsif params[:ratings].present? &&  session[:selected_ratings] == []
      @movies = @movies.where(:rating => params[:ratings].keys) 
    else
      @movies = Movie.order(params[:sort_param])
    end

    
  
  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


end
