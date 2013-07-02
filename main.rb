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

get '/todos/new' do
  #stuck here
  movies_sql = "SELECT id, title FROM movies"
  contact_sql ="SELECT id, name FROM people"
  @movies = run_sql(movies_sql)
  @contact = run_sql(contact_sql)
erb :todo
end

post '/todos/new' do
  name = params[:name]
  description = params[:description]
  contact = params[:contact]
  movie = params[:movie]
  sql = "INSERT INTO todo (name, description, contact, movie) VALUES ('#{name}','#{description}','#{contact}','#{movie}')"
  run_sql(sql)
  redirect to '/todos'
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
erb :movies
end

get '/movies/new' do
erb :movie
end

post '/movies/new' do
id = params[:id]
  description = params[:description]
  contact = params[:contact]
  movie = params[:movie]
  sql = "INSERT INTO todo (name, description, contact, movie) VALUES ('#{name}','#{description}','#{contact}','#{movie}')"
  run_sql(sql)
redirect to '/movies'
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
erb :people
end

get '/people/new' do
erb :person
end

post '/people/new' do
#post to database
redirect to '/people'
end