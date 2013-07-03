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

# page for editing a specific movie
get '/movies/:id/edit' do
  @id = params[:id]
  @movie = Movie.find(params[:id])
  erb :edit_movie
end

# edits specific movie once form is filled out
post '/movies/:id/edit' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.director = params[:director]
  movie.release_date = params[:release_date]
  movie.save
  redirect to "/movies/#{movie.id}"
end

# page for deleting a specific movie
get '/movies/:id/delete' do
  @movie = Movie.find(params[:id])
  @tasks = Task.find_all_by_movie_id(params[:id])
  erb :delete_movie
end

# deletes specific movie once form is filled out
post '/movies/:id/delete' do
  Task.find_all_by_movie_id(params[:id]).each do |task|
    task.destroy
  end
  Movie.find(params[:id]).destroy
  redirect to "/movies"
end

# page with list of people
get '/people' do
  @people = Person.all
  erb :people
end

# individual person page
get '/people/:id' do
  @person = Person.find(params[:id])
  @tasks = Task.find_all_by_person_id(params[:id])
  erb :person
end

# page for adding a new person to the database
get '/add_person' do
  erb :add_person
end

# adds a new person to the database once form is filled out
post '/add_person' do
  person = Person.create(params)
  redirect to '/people'
end

# page for editing a specific person
get '/people/:id/edit' do
  @id = params[:id]
  @person = Person.find(params[:id])
  erb :edit_person
end

# edits specific person once form is filled out
post '/people/:id/edit' do
  person = Person.find(params[:id])
  person.name = params[:name]
  person.save
  redirect to "/people/#{person.id}"
end

# page for deleting a specific person
get '/people/:id/delete' do
  @person = Person.find(params[:id])
  sql_tasks = "select * from tasks where person = #{@id}"
  @tasks = Task.find_all_by_person_id(params[:id])
  erb :delete_person
end

# deletes specific person once form is filled out
post '/people/:id/delete' do
  Task.find_all_by_person_id(params[:id]).each do |task|
    task.destroy
  end
  Person.find(params[:id]).destroy
  redirect to "/people"
end

# page with all tasks
get '/tasks' do
  @movies = Movie.all
  @tasks = Task.all
  erb :todos
end

# individual task page
get '/tasks/:id' do
  id = params[:id]
  @task = Task.find(params[:id])
  @person = Person.find(@task.person_id)
  @movie = Movie.find(@task.movie_id)
  erb :todo
end

# page for adding a new task to the database
get '/add_task' do
  @movies = Movie.all
  @people = Person.all
  erb :add_task
end

# adds a new task to the database once form is filled out
post '/add_task' do
  task = Task.create(params)
  redirect to '/tasks'
end