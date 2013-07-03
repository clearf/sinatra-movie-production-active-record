require 'pg'
<<<<<<< HEAD
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql',
                database: 'movie_app',
                host: 'localhost'}

# helpers do
#   def run_sql(sql)
#     db = PG.connect(dbname: 'movie_app', host: 'localhost')
#     result = db.exec(sql)
#     db.close
#     result
#   end
# end

class Todo < ActiveRecord::Base
end

class People < ActiveRecord::Base
end

class Movies < ActiveRecord::Base
end



get '/' do
erb :index
end

get '/todos' do
  @todo = Todo.all
  # sql = "SELECT * FROM todo"
  # @todo = run_sql(sql)
erb :todos
end

get '/todos/new' do
  @movies = Movies.all
  @contact = People.all
  # movies_sql = "SELECT id, title FROM movies"
  # contact_sql ="SELECT id, name FROM people"
  # @movies = run_sql(movies_sql)
  # @contact = run_sql(contact_sql)
erb :todo
end

post '/todos/new' do
  Todo.create(params)
  # name = params[:name]
  # description = params[:description]
  # contact = params[:contact]
  # movie = params[:movie]
  # sql = "INSERT INTO todo (name, description, contact, movie) VALUES ('#{name}','#{description}','#{contact}','#{movie}')"
  # run_sql(sql)
  redirect to '/todos'
end

get '/movies' do
  @movies = Movies.all
  # sql = "SELECT * FROM movies"
  # @movies = run_sql(sql)
erb :movies
end

get '/movies/new' do
erb :movie
end

post '/movies/new' do
  Movies.create(params)
  # release_date = params[:release_date]
  # title = params[:title]
  # director = params[:director]
  # sql = "INSERT INTO movies (release_date,title, director) VALUES ('#{release_date}','#{title}','#{director}')"
  # run_sql(sql)
redirect to '/movies'
end

get '/people' do
  @people = People.all
  # sql = "SELECT * FROM people"
  # @people = run_sql(sql)
erb :people
end

get '/people/new' do
erb :person
end

post '/people/new' do
  People.create(params)
redirect to '/people'
end
=======
require 'sinatra'
require 'sinatra/reloader' if development?



get '/new_todo'  do
end

post '/new_todo'  do
end
>>>>>>> d2045a22c06761a1dfbc7dba531272a90ab69742
