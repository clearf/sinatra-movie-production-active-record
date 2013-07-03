require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/activerecord'
require 'pry'

#need to fix movies to reflect table change

set :database, {adapter: "postgresql",
                database: "Homework",
                host: 'localhost',
                username: 'postgres',
                password: 'postgres'}

class Movie < ActiveRecord::Base
  has_one :person
  belongs_to :task
end

class Person < ActiveRecord::Base
  belongs_to :task
  belongs_to :movie
end

class Task < ActiveRecord::Base
  has_one :person
  has_one :movie
end

#shows root page

get '/' do
  @tasks = Task.all
  @movies = Movie.all
  @people = Person.all
  erb :index
end

#shows form to add a new movie
get '/movies/new' do
  @people = Person.all
  erb :new_movie
end

#adds a new movie
#Bug: doesn't like Movies with ' in the title
post '/movies/new' do
  Movie.create(params)
  redirect to '/'
end

#shows form to edit movie
get '/movies/:id/edit' do
  @movie = Movie.find(params[:id])
  @people = Person.all
  erb :movie_edit
end

#this edits the movie
#Bug: doesn't like Movies with ' in the title
post '/movies/:id/edit' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.release_date = params[:release_date]
  movie.person_id = params[:person_id]
  movie.save

  redirect to "/"
end

#this deletes the movie
#problem deleting movie that is associated in the task table
post '/movies/:id/delete' do
  Movie.destroy(params[:id])
  redirect to "/"
end

#shows form to add a new person
get '/people/new' do
  erb :new_person
end

#adds a new person
post '/people/new' do
  Person.create(params)
  redirect to '/'
end

#shows form to edit person
get '/people/:id/edit' do
  @person = Person.find(params[:id])
  erb :person_edit
end

#this edits the person
post '/people/:id/edit' do
  person = Person.find(params[:id])
  person.name = params[:name]
  person.role = params[:role]
  person.save
  redirect to "/"
end

#this deletes the person
#problem deleting person who is referenced in the tasks table XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
post '/people/:id/delete' do
  Person.destroy(params[:id])
  redirect to "/"
end

#shows the form to add a new task
get '/tasks/new' do
  @people = Person.all
  @movies = Movie.all
  erb :new_task
end

#adds a new task
post '/tasks/new' do
  @tasks = Task.create(params)
  redirect to '/'
end

#doesn't show table dependencies
#shows form to edit task
get '/tasks/:id/edit' do
  @task = Task.find(params[:id])
  @movies = Movie.all
  @people = Person.all

  erb :task_edit
end

#this edits the task
###########It changes everythign in the database except people and movie id!!!!!!!!!XXXXXXXXXXXXXXXXXX
post '/tasks/:id/edit' do
  task = Task.find(params[:id])
  task.name = params[:name]
  task.description = params[:description]
  task.person_id = params[:person_id]
  task.movie_id = params[:movie_id]
  task.save
  redirect to "/"
end

#this deletes the task
post '/tasks/:id/delete' do
  Task.destroy(params[:id])
  redirect to "/"
end

#shows individual task
get '/tasks/:id' do
  @id = params[:id]
  @task = Task.find(params[:id])
  @movie = Movie.find(@task.movie_id)
  @person = Person.find(@task.person_id)

  erb :task
end

#need to fix form to have a dropdown and remove excess inputs
#shows individual movie
get '/movies/:id' do
  @movie = Movie.find(params[:id])
  @person = Person.find(@movie.person_id)
  erb :movie
end

#shows individual person
get '/people/:id' do
  @person = Person.find(params[:id])
  erb :person
end

