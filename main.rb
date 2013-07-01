require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

helpers do
  def run_sql(sql_input)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql_input)
    db.close
    result
  end
end

get '/' do
  erb :index
end

# This should list movies
get '/movies' do
  sql_input = "SELECT * FROM movies"
  @movies = run_sql(sql_input)
  erb :movies
end

# This should show details of a single movie
get '/movies/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql_input).first
  erb :movie
end

# This should list people
get '/people' do
  sql_input = "SELECT * FROM people"
  @people = run_sql(sql_input)
  erb :people
end

# This should show details of a single person
get '/people/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql_input).first
  erb :person
end

# This should list tasks
get '/tasks' do
  sql_input = "SELECT * FROM tasks"
  @tasks = run_sql(sql_input)
  erb :todos
end

# This should list a single task
get '/tasks/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql_input).first
  erb :todo
end

