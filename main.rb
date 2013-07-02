require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_app', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
erb :index
end

get '/todos' do
  sql = "SELECT * FROM todo"
  @todo = run_sql(sql)
erb :todos
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
erb :movies
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
erb :people
end