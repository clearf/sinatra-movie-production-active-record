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
  has_many :tasks
end

class Movie < ActiveRecord::Base
  has_many :people
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :people
  belongs_to :movies
end

get '/' do
  erb :index
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

get '/movies/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql)
  sql2 = "SELECT * FROM people WHERE id = #{@movie.first['director']};"
  @director = run_sql(sql2).first
  sql3 = "SELECT * FROM people;"
  @people = run_sql(sql3)
  erb :movie
end

get '/new_movie' do
  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)
  erb :new_movie
end

post '/new_movie' do
  title = params[:title]
  release_date = params[:release_date]
  director = params[:director]
  sql = "INSERT INTO movies (title, release_date, director) VALUES ('#{title}', #{release_date}, '#{director}');"
  run_sql(sql)
  redirect to('/movies')
end

post '/delete/movies/:id' do
  id = params[:id]
  sql = "DELETE FROM movies WHERE id = #{id}"
  run_sql(sql)
  redirect to('/movies')
end

post '/edit_movie/:id' do
  id = params[:id]
  title = params[:title]
  release_date = params[:release_date]
  director = params[:director]
  sql1 = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql1)
  sql2= "SELECT * FROM people where id = #{director};"
  @people = run_sql(sql2)
  sql3 = "SELECT * FROM people WHERE id = #{@movie.first['director']};"
  @director = run_sql(sql3).first
  sql = "UPDATE movies SET (title, release_date, director) = ('#{title}', #{release_date}, '#{director}') WHERE id = #{id};"
  run_sql(sql)
  redirect to('/movies')
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/people/:id' do
  id = params[:id]
  movie = params[:id]
  sql1 = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql1)
  sql2 = "SELECT * FROM movies"
  @movies = run_sql(sql2)
  sql3 = "SELECT * FROM tasks"
  @tasks = run_sql(sql3)
  erb :person
end

get '/new_person' do
  erb :new_person
end

post '/new_person' do
  name = params[:name]
  description = params[:description]
  sql = "INSERT INTO people (name) VALUES ('#{name}');"
  run_sql(sql)
  redirect to('/people')
end

post '/delete/people/:id' do
  id = params[:id]
  sql = "DELETE FROM people WHERE id = #{id}"
  run_sql(sql)
  redirect to('/people')
end

post '/edit_person/:id' do
  id = params[:id]
  name = params[:name]
  movie = params[:movie]
  task = params[:task]
  sql = "UPDATE people SET (name, movie, task) = ('#{name}', #{movie}, '#{task}') WHERE id = #{id}"
  run_sql(sql)
  redirect to('/people')
end

get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

get '/todos/:id' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql)
  erb :todo
end

get '/new_todo' do
  sql1 = "SELECT id, name FROM people"
  @people = run_sql(sql1)
  sql2 = "SELECT id, title FROM movies"
  @movies = run_sql(sql2)
  erb :new_todo
end

post '/new_todo' do
  name = params[:name]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql = "INSERT INTO tasks (name, description, person_id, movie_id) VALUES ('#{name}', '#{description}', #{person_id}, #{movie_id});"
  run_sql(sql)
  redirect to('/todos')
end

post '/delete/todos/:id' do
  id = params[:id]
  sql = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql)
  redirect to('/todos')
end

post '/edit_todo/:id' do
  id = params[:id]
  name = params[:name]
  description = params[:description]
  movie_id = params[:movie_id]
  person_id = params[:person_id]
  sql = "UPDATE tasks SET (name, description, person_id, movie_id) = ('#{name}', '#{description}', #{person_id}, #{movie_id}) WHERE id = #{id}"
  run_sql(sql)
  redirect to('/todos')
end