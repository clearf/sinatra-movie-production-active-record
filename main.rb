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

binding.pry

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
post '/movies/:id/delete' do
  id = params[:id]
  Movie.find(id).destroy
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
  redirect to('/people')
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
  sql_input = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql_input).first
  second_sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(second_sql_input)
  erb :edit_person
end

# This should send a post request to the url
post '/people/:id/edit' do
  id = params[:id]
  person_name = params[:person_name]
  director = params[:director]
  if director == "yes"
    director = true
  else
    director = false
  end
  movie_id = params[:movie_id]
  sql_input = "UPDATE people SET (person_name, director, movie_id) = ('#{person_name}', #{director}, #{movie_id}) WHERE id = #{id}"
  run_sql(sql_input)
  redirect to('/people')
end

# This should delete a person
post '/people/:id/delete' do
  id = params[:id]
  sql_input = "UPDATE tasks SET (person_id) = (null) WHERE person_id = #{id}"
  run_sql(sql_input)
  second_sql_input = "DELETE FROM people WHERE id = #{id}"
  run_sql(second_sql_input)
  redirect to('/people')
end

# This should list tasks
get '/tasks' do
  sql_input = "SELECT * FROM tasks"
  @tasks = run_sql(sql_input)
  erb :todos
end

# This should add a new task
get '/tasks/new' do
  sql_input = "SELECT id, person_name FROM people"
  @people = run_sql(sql_input)
  second_sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(second_sql_input)
  erb :new_todo
end

# This should send a post request to the url
post '/tasks/new' do
  task_name = params[:task_name]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql_input = "INSERT INTO tasks (task_name, description, person_id, movie_id) VALUES ('#{task_name}', '#{description}', #{person_id}, #{movie_id})"
  run_sql(sql_input)
  redirect to('/tasks')
end

# This should list a single task
get '/tasks/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql_input).first
  second_sql_input = "SELECT * FROM movies WHERE id = #{@task['movie_id']}"
  @movie = run_sql(second_sql_input).first
  third_sql_input = "SELECT * FROM people WHERE id = #{@task['person_id']}"
  @person = run_sql(third_sql_input).first
  erb :todo
end

# This should edit a task
get '/tasks/:id/edit' do
  id = params[:id]
  sql_input = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql_input).first
  second_sql_input = "SELECT id, person_name FROM people"
  @people = run_sql(second_sql_input)
  third_sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(third_sql_input)
  erb :edit_task
end

# This should send a post request to the url
post '/tasks/:id/edit' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql_input = "UPDATE tasks SET (task_name, description, person_id, movie_id) = ('#{task_name}', '#{description}', #{person_id}, #{movie_id}) WHERE id = #{id}"
  run_sql(sql_input)
  redirect to('/tasks')
end

# This should delete a task
post '/tasks/:id/delete' do
  id = params[:id]
  sql_input = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql_input)
  redirect to('/tasks')
end




