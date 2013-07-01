require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

def run_sql(sql)
  db = PG.connect(dbname: 'movie_app', host: 'localhost')
  result = db.exec(sql)
  db.close
  result
end

get '/' do
erb :index
end

get '/todos' do
erb :todo
end

get '/movies' do
erb :movies
end

get '/people' do
erb :people
end