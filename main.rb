require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql',
                database: 'production_new',
                host: 'localhost'}

class Person < ActiveRecord::Base
  has_many :tasks
end

class Movie < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

# index page - immediately redirects to list of movies
get '/' do
  redirect to '/movies'
end

# page with list of movies - basically index page
get '/movies' do
  @movies = Movie.all
  erb :movies
end

# individual movie page
get '/movies/:id' do
  @movie = Movie.find(params[:id])
  # sql_tasks = "select * from tasks where movie = #{id}"
  @tasks = Task.find_all_by_movie_id(params[:id])
  erb :movie
end

# page for adding a new person to the database
get '/add_movie' do
  erb :add_movie
end

# adds a new movie to the database once form is filled out
post '/add_movie' do
  movie = Movie.create(params)
  redirect to '/movies'
end