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