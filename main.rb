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

get '/movies' do
  sql_input = "SELECT * FROM movies"
  @movies = run_sql(sql_input)
  erb :movies
end