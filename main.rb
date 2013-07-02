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

class Movies < ActiveRecord::Base
  belongs_to :person
end

class Tasks < ActiveRecord::Base
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

#Individual People Page
get '/people/:id' do
@person = Person.find(params[:id])
# sql = "SELECT * FROM people WHERE id ='#{@person}'"
# @person_details = run_sql(sql).first
# sql = "SELECT * FROM tasks where person_id ='#{@person}'"
# @tasks = run_sql(sql)
# sql = "SELECT * FROM movies where person_id ='#{@person}'"
# @movies = run_sql(sql)
erb :person
end

post '/people/:id/delete' do
  @person_id = params[:id]
  sql = "DELETE FROM people where id = '#{@person_id}'"
  run_sql(sql)
  sql = "DELETE FROM movies where person_id = '#{@person_id}'"
  run_sql(sql)
  sql = "DELETE FROM tasks where person_id = '#{@person_id}'"
  run_sql(sql)

  redirect to ('/people')
end

#Edit People
get '/people/:id/edit' do
  @person_id = params[:id]
  sql = "SELECT * FROM people WHERE id='#{@person_id}'"
  @person_details = run_sql(sql).first
  erb :edit_person
end

post '/people/:id' do
  person_id = params[:id]
  name = params[:name]
  sql = "UPDATE people SET (name) = ('#{name}') WHERE id =#{person_id}"
  run_sql(sql)
  redirect to('/people')
end

#list movies
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

get '/movies/new' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :new_movie
end

post '/movies/new' do
  name = params[:name]
  person_id = params[:person_id]
  sql = "INSERT INTO movies (name, person_id) VALUES ('#{name}', '#{person_id}')"
  run_sql(sql)
  redirect to('/movies')
end

#Individual Movie Page
get '/movies/:id' do
  @movie_id = params[:id]
  sql = "SELECT * FROM movies WHERE id= '#{@movie_id}'"
  @movie_details = run_sql(sql).first
  sql = "SELECT * FROM tasks where movie_id ='#{@movie_id}'"
  @tasks = run_sql(sql).first
  erb :movie
end


#Delete Movie Page
post '/movies/:id/delete' do
  @movie_id = params[:id]
  sql = "DELETE FROM movies where id = '#{@movie_id}'"
  run_sql(sql)
  redirect to ('/movies')
end

#Edit Movies
get '/movies/:id/edit' do
  @movie_id = params[:id]
  sql = "SELECT * FROM movies WHERE id='#{@movie_id}'"
  @movie_details = run_sql(sql).first
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :edit_movie
end

post '/movies/:id' do
  movie_id = params[:id]
  name = params[:name]
  person_id = params[:person_id]
  sql = "UPDATE movies SET (name, person_id) = ('#{name}', #{person_id}) WHERE id =#{movie_id}"
  run_sql(sql)
  redirect to('/movies')
end

#list tasks
get '/tasks' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

#
get '/tasks/new' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
erb :new_task
end

#
post '/tasks/new' do
  name = params[:name]
  description = params[:description]
  movie_id = params[:movie_id]
  person_id = params[:person_id]
  sql = "INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('#{name}', '#{description}', #{movie_id}, #{person_id}) "
  run_sql(sql)
  redirect to('/tasks')
end

#Individual Task Page
get '/tasks/:id' do
  @task_id = params[:id]
  sql = "SELECT * FROM tasks where id='#{@task_id}'"
  @task_details = run_sql(sql).first
  sql = "Select * FROM movies"
  @movie_details = run_sql(sql)
    sql = "Select * FROM people"
  @people_details = run_sql(sql)
  erb :todo
end

post '/tasks/:id/delete' do
  @task_id = params[:id]
  sql = "DELETE FROM tasks where id = '#{@task_id}'"
  run_sql(sql)
redirect to ('/tasks')
end

#Edit Tasks
get '/tasks/:id/edit' do
  @task_id = params[:id]
  sql = "SELECT * FROM tasks WHERE id='#{@task_id}'"
  @task_details = run_sql(sql).first
  sql = "Select * FROM movies"
  @movie_details = run_sql(sql)
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :edit_task
end

post '/tasks/:id' do
  task_id = params[:id]
  name = params[:name]
  description = params[:description]
  movie_id = params[:movie_id]
  person_id = params[:person_id]
  sql = "UPDATE tasks SET (name, description, movie_id, person_id) = ('#{name}', '#{description}', #{movie_id}, #{person_id}) WHERE id =#{task_id}"
  run_sql(sql)
  redirect to('/tasks')
end





