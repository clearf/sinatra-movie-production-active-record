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
  id = params[:id]

  @task = Task.find(id)
  binding.pry
  @person = Person.find(@task.people_id)

  @movie = Movie.find(@task.movies_id)

  erb :task
end

post '/new_task' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

  sql = "INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('#{task}', '#{description}', #{person_id}, #{movie_id})"
  run_sql(sql)

  redirect to('/')
end

get '/edit_task/:id' do
  id = params[:id]

  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql).first

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  sql = "SELECT id, title FROM movies"
  @movies = run_sql(sql)

  erb :edit_task
end

post '/edit_task/:id' do
  id = params['id']
  task = params['task']
  description = params['description']
  person_id = params['person_id']
  movie_id = params['movie_id']

  completed = false
  if params['completed'].chomp == 'y'
    completed = true
  end

  sql = "UPDATE tasks SET (task, description, person_id, movie_id, completed) = ('#{task}', '#{description}', #{person_id}, #{movie_id}, #{completed}) WHERE id = #{id}"
  run_sql(sql)

  redirect to('/')
end

post '/delete_task/:id' do
  id = params[:id]
  sql = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql)

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
  Movie.create(params)

  redirect to('/movies')
end

get '/movies/:id' do
  id = params[:id]

  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first

  sql = "SELECT name FROM people WHERE id = #{@movie['director_id']}"
  @director = run_sql(sql).first

  erb :movie
end

get '/edit_movie/:id' do
  id = params[:id]

  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  erb :edit_movie
end

post '/edit_movie/:id' do
  id = params[:id]
  title = params[:title]
  director_id = params['director_id']
  year = params['year']
  image = params['image']

  sql = "UPDATE movies SET (title, director_id, year, image) = ('#{title}', '#{director_id}', '#{year}', '#{image}') WHERE id = #{id}"
  run_sql(sql)

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
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first

  erb :person
end

post '/new_person' do
  name = params[:name]
  title = params[:title]
  phone = params[:phone]

  sql = "INSERT INTO people (name, title, phone) VALUES ('#{name}', '#{title}', '#{phone}')"
  run_sql(sql)

  redirect to('/people')
end

get '/edit_person/:id' do
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first

  erb :edit_person
end

post '/edit_person/:id' do
  id = params['id']
  name = params['name']
  title = params['title']
  phone = params['phone']

  sql = "UPDATE people SET (name, title, phone) = ('#{name}', '#{title}', '#{phone}') WHERE id = #{id}"
  run_sql(sql)

  redirect to('/people')
end






