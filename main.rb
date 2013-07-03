require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry' if development?
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'movies',
  host: 'localhost'
}

class Person < ActiveRecord::Base
  belongs_to :movie
  has_many :tasks
end

class Movie < ActiveRecord::Base
  has_many :people
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

get '/' do
  erb :index
end

get '/movies' do
  @movies = Movie.all
  erb :movies
end

get '/movies/:id' do
  id = params[:id]
  movie_id = params[:movie_id]
  @movie = Movie.find(id)
  @people = Person.all
  erb :movie
end

get '/new_movie' do
  @people = Person.all
  erb :new_movie
end

post '/new_movie' do
  title = params[:title]
  release_date = params[:release_date]
  person_id = params[:person_id]
  movie = Movie.create(params)
  redirect to('/movies')
end

post '/delete/movies/:id' do
  id = params[:id]
  Movie.find(id).destroy
  redirect to('/movies')
end

post '/edit_movie/:id' do
  id = params[:id]
  title = params[:title]
  release_date = params[:release_date]
  person_id = params[:person_id]
  @movie = Movie.find(id)
  @people = Person.find(person_id)
  @movie.title = title
  @movie.release_date = release_date
  @movie.person_id = person_id
  @movie.save
  redirect to('/movies')
end

get '/people' do
  @people = Person.all
  erb :people
end

get '/people/:id' do
  id = params[:id]
  movie = params[:id]
  @person = Person.find(id)
  @movies = Movie.all
  @tasks = Task.all
  erb :person
end

get '/new_person' do
  erb :new_person
end

post '/new_person' do
  name = params[:name]
  description = params[:description]
  Person.create(params)
  redirect to('/people')
end

post '/delete/people/:id' do
  id = params[:id]
  Person.find(id).destroy
  redirect to('/people')
end

post '/edit_person/:id' do
  id = params[:id]
  name = params[:name]
  movie = params[:movie_id]
  task = params[:task_id]
  @person = Person.find(id)
  @person.name = name
  @person.movie_id = movie
  @person.task_id = task
  @person.save
  redirect to('/people')
end

get '/todos' do
  @tasks = Task.all
  erb :todos
end

get '/todos/:id' do
  id = params[:id]
  @task = Task.find(id)
  @movies = Movie.all
  @people = Person.all
  erb :todo
end

get '/new_todo' do
  @people = Person.all
  @movies = Movie.all
  erb :new_todo
end

post '/new_todo' do
  name = params[:name]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  task = Task.create(params)
  @person = Person.find(person_id)
  @person.task_id = task.id
  @person.movie_id = movie_id
  @person.save
  redirect to('/todos')
end

post '/delete/todos/:id' do
  id = params[:id]
  Task.find(id).destroy
  redirect to('/todos')
end

post '/edit_todo/:id' do
  id = params[:id]
  name = params[:name]
  description = params[:description]
  movie_id = params[:movie_id]
  person_id = params[:person_id]
  @task = Task.find(id)
  @movies = Movie.all
  @people = Person.all
  @task.name = name
  @task.description = description
  @task.movie_id = movie_id
  @task.person_id = person_id
  @task.save
  redirect to('/todos')
end