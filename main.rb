require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'movie_manager',
  host: 'localhost'
}

class Task < ActiveRecord::Base
  belongs_to :movie #needs a movie_id
  belongs_to :person #needs a person_id
end

class Movie < ActiveRecord::Base
  has_many :people
  has_many :tasks
end

class Person < ActiveRecord::Base
  belongs_to :movie # needs a movie_id
  has_many :tasks
end

get '/' do
  @tasks = Task.all

  @people = Person.all

  @movies = Movie.all

  erb :tasks
end

##################################
## Tasks
##################################

get '/tasks/:id' do
  @task = Task.find(params[:id])
  @person = @task.person

  @movie = @task.movie

  erb :task
end

post '/new_task' do
  Task.create(params)

  redirect to('/')
end

get '/edit_task/:id' do
  @task = Task.find(params[:id])
  @people = Person.all
  @movies = Movie.all

  erb :edit_task
end

post '/edit_task/:id' do
  @task = Task.find(params[:id])
  @task.task = params['task']
  @task.description = params['description']
  @task.person_id = params['person_id']
  @task.movie_id = params['movie_id']

  @task.completed = false
  if params['completed'].chomp == 'y'
    @task.completed = true
  end

  @task.save

  redirect to('/')
end

post '/delete_task/:id' do
  Task.find(params[:id]).destroy

  redirect to('/')
end

##################################
## Movies
##################################

get '/movies' do
  @people = Person.all

  @movies = Movie.all

  erb :movies
end

post '/new_movie' do
  # binding.pry
  @movie = Movie.create(title: params[:title], year: params[:year], image: params[:image])
  @movie.people << Person.find(params[:people])
  @movie.save
  redirect to('/movies')
end

get '/movies/:id' do
  @movie = Movie.find(params[:id])
  @people = @movie.people.first
  @tasks = @movie.tasks

  erb :movie
end

get '/edit_movie/:id' do
  @movie = Movie.find(params[:id])

  @people = Person.all

  erb :edit_movie
end

post '/edit_movie/:id' do

  @movie = Movie.find(params[:id])
  @movie.title = params[:title]
  @movie.people << Person.find(params['people_id'])
  @movie.year = params['year']
  @movie.image = params['image']

  @movie.save

  redirect to('/movies')
end

post '/delete_movie/:id' do
  Movie.find(params[:id]).destroy

  redirect to('/movies')
end

##################################
## People
##################################

get '/people' do
  @people = Person.all

  erb :people
end

get '/people/:id' do
  @person = Person.find(params[:id])

  erb :person
end

post '/new_person' do
  Person.create(params)

  redirect to('/people')
end

get '/edit_person/:id' do
  @person = Person.find(params[:id])

  erb :edit_person
end

post '/edit_person/:id' do
  @person = Person.find(params[:id])
  @person.name = params['name']
  @person.title = params['title']
  @person.phone = params['phone']

  @person.save

  redirect to('/people')
end

post '/delete_person/:id' do
  Person.find(params[:id]).destroy

  redirect to('/people')
end




