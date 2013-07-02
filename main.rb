require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'production',
  host: 'localhost'
}

class Person < ActiveRecord::Base
  has_many :movies
  has_many :tasks
end

class Movie < ActiveRecord::Base
  belongs_to :person
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

get '/' do
  erb :home
end

#list people
get '/people' do
  @people = Person.all
  erb :people
end

#Input Form To Add New Person
get '/people/new' do
  erb :new_person
end

#Input to Database from Form
post '/people/new' do
 person = Person.create(params)
  redirect to('/people')
end


# #Individual People Page
get '/people/:id' do
@person = Person.find(params[:id])
@person_details = Person.find(params[:id])
@tasks = Task.find_by_person_id(params[:id])
@movies = Movie.find_by_person_id(params[:id])
erb :person
end

post '/people/:id/delete' do
  Person.find(params[:id]).destroy
  redirect to ('/people')
end

#Edit People
get '/people/:id/edit' do
  @person_id = params[:id]
  @person_details = Person.find(params[:id])
  erb :edit_person
end

post '/people/:id' do
  person = Person.find(params[:id])
  person.name = params[:name]
  person.save
  redirect to('/people')
end

#list movies
get '/movies' do
  @movies = Movie.all
  erb :movies
end

get '/movies/new' do
  @people = Person.all
  erb :new_movie
end

post '/movies/new' do
  movie = Movie.create(params)
  redirect to('/movies')
end

#Individual Movie Page
get '/movies/:id' do
  @movie_details = Movie.find(params[:id])
  @people = Person.all
  @tasks = Task.find_by_movie_id(params[:id])
  binding.pry
  erb :movie
end


# Delete Movie Page
post '/movies/:id/delete' do
  Movie.find(params[:id]).destroy
  redirect to ('/movies')
end

#Edit Movies
get '/movies/:id/edit' do
  @movie_id = params[:id]
  @movie_details = Movie.find(params[:id])
  @people = Person.all
  erb :edit_movie
end

post '/movies/:id' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.person_id = params[:person_id]
  movie.save
  redirect to('/movies')
end

#list tasks
get '/tasks' do
  @tasks = Task.all
  erb :todos
end

#
get '/tasks/new' do
  @movies = Movie.all
  @people = Person.all
erb :new_task
end

#
post '/tasks/new' do
  task= Task.create(params)
  redirect to('/tasks')
end

#Individual Task Page
get '/tasks/:id' do
  @task = Task.find(params[:id])
  @task_details = Task.find(params[:id])
  @movie_details = Movie.all
  @people_details = Person.all
  erb :todo
end

post '/tasks/:id/delete' do
  @task_id = params[:id]
  Task.find(params[:id]).destroy
redirect to ('/tasks')
end

#Edit Tasks
get '/tasks/:id/edit' do
  @task_id = params[:id]
  @task_details = Task.find(params[:id])
  @movie_details = Movie.all
  @people = Person.all
  erb :edit_task
end

post '/tasks/:id/update' do
  task = Task.find(params[:id])
  task.name = params[:name]
  task.description = params[:description]
  task.person_id = params[:person_id]
  task.movie_id = params[:movie_id]
  task.save
  redirect to('/tasks')
end





