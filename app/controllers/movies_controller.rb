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
  # GO DEEP: http://stackoverflow.com/questions/10972300/in-rails-with-check-box-tag-how-do-i-keep-the-checkboxes-checked-after-submitt 
    @movies = Movie.order(params[:sort_param])
    @movies = @movies.where(:rating => params[:ratings].keys) if params[:ratings].present?
    @all_ratings = Movie.uniq.pluck(:rating)  
    
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

=begin

  def filter
    @movies = Movie.where(:rating => @filtered)
    @filtered = []

    if check_box_tag == true
      @filtered.push(:rating)
    end
  end
  http://stackoverflow.com/questions/15034262/how-to-push-keys-and-values-into-an-empty-hash-w-ruby
  http://stackoverflow.com/questions/20235206/ruby-get-all-keys-in-a-hash-including-sub-keys
=end
end
