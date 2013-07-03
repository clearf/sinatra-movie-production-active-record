require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry' if development?
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'movie_production',
  host: 'localhost'
}

class Person < ActiveRecord::Base
  has_many :movies
  has_many :todos
end

class Movie < ActiveRecord::Base
  belongs_to :people
  has_many :todos
end

class Todo < ActiveRecord::Base
  belongs_to :people
  belongs_to :movies
end

# binding.pry

get '/' do
  erb :index
end

# This should list movies
get '/movies' do
  @movies = Movie.all
  erb :movies
end

# This should add a new movie
get '/movies/new' do
  @people = Person.all
  erb :new_movie
end

# This should send a post request to this url
post '/movies/new' do
  movie = Movie.create(params)
  redirect to "/movies/#{movie.id}"
end

# This should show details of a single movie
get '/movies/:id' do
  id = params[:id]
  @movie = Movie.find(id)
  @person = Person.find(@movie.person_id)
  erb :movie
end

# This should edit a movie
get '/movies/:id/edit' do
  id = params[:id]
  @people = Person.all
  @movie = Movie.find(id)
  erb :edit_movie
end

# This should send a post request to the url
post '/movies/:id/edit' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.release_date = params[:release_date]
  movie.person_id = params[:person_id]
  movie.save
  redirect to "/movies/#{movie.id}"
end

# This should delete a movie
## test this
post '/movies/:id/delete' do
  id = params[:id]
  movie = Movie.find(id)
  unless Todo.find_by(movie_id: movie.id).movie_id == nil
    todo = Todo.find_by(movie_id: movie.id)
    todo.movie_id = nil
    todo.save
  end
  movie.destroy
  # Movie.find(id).destroy
  redirect to('/movies')
end

# This should list people
get '/people' do
  @people = Person.all
  erb :people
end

# This should add a new person.
get '/people/new' do
  erb :new_person
end

# This should send a post request to the url
post '/people/new' do
  person = Person.create(params)
  redirect to "/people/#{person.id}"
end

# This should show details of a single person
get '/people/:id' do
  id = params[:id]
  @person = Person.find(id)
  erb :person
end

# This should edit a person
get '/people/:id/edit' do
  id = params[:id]
  @person = Person.find(id)
  erb :edit_person
end

# This should send a post request to the url
post '/people/:id/edit' do
  person = Person.find(params[:id])
  person.name = params[:name]
  person.save
  redirect to "/people/#{person.id}"
end

# This should delete a person
## test this
post '/people/:id/delete' do
  id = params[:id]
  person = Person.find(id)
  unless Movie.find_by(person_id: person.id).person_id == nil
    movie = Movie.find_by(person_id: person.id)
    movie.person_id = nil
    movie.save
  end
  person.destroy
  # Person.find(id).destroy
  redirect to('/people')
end

# This should list tasks
get '/todos' do
  @todos = Todo.all
  erb :todos
end

# This should add a new task
get '/todos/new' do
  @movies = Movie.all
  @people = Person.all
  erb :new_todo
end

# This should send a post request to the url
post '/todos/new' do
  todo = Todo.create(params)
  redirect to "/todos/#{todo.id}"
end

# This should list a single task
get '/todos/:id' do
  id = params[:id]
  @todo = Todo.find(id)
  @person = Person.find(@todo.person_id)
  @movie = Movie.find(@todo.movie_id)
  erb :todo
end

# This should edit a task
get '/todos/:id/edit' do
  id = params[:id]
  @todo = Todo.find(id)
  @people = Person.all
  @movies = Movie.all
  erb :edit_task
end

# This should send a post request to the url
post '/todos/:id/edit' do
  todo = Todo.find(params[:id])
  todo.name = params[:name]
  todo.description = params[:description]
  todo.due_date = params[:due_date]
  todo.person_id = params[:person_id]
  todo.movie_id = params[:movie_id]
  todo.save
  redirect to "/todos/#{todo.id}"
end

# This should delete a task
post '/todos/:id/delete' do
  id = params[:id]
  Todo.find(id).destroy
  redirect to('/todos')
end
