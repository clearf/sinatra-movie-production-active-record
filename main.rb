require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'imdb'
require 'sinatra/activerecord'


#################### CONNECT ACTIVERECORD  / SET UP CLASSES ####################
set :database, {
  adapter: 'postgresql',
  database: 'movie_todo_hw',
  host: 'localhost'
}

class Movie < ActiveRecord::Base
  has_many :todos
end

class Person < ActiveRecord::Base
  has_many :todos
end

class Todo < ActiveRecord::Base
  belongs_to :movies
  belongs_to :people
end

#################### DEFINE METHODS ####################
# METHOD TO FETCH IBMD DATA AND SAVE INTOT HE DATABASE #
########################################################

def download_movie(title)
  # DOWNLOAD AND ASSIGN DATA TO VARIABLES
  movie_data = Imdb::Search.new(title).movies.first

  title = movie_data.title
  year = movie_data.year
  company = movie_data.company
  genres = movie_data.genres.join(", ").to_s
  length = movie_data.length
  director = movie_data.director.join
  mpaa_rating = movie_data.mpaa_rating
  poster = movie_data.poster

  Movie.create(
    title: title,
    year: year,
    company: company,
    genres: genres,
    length: length,
    director: director,
    mpaa_rating: mpaa_rating,
    poster: poster
  )
end



#################### MAIN LANDING PAGE ####################
get '/' do
  @got_movies = Movie.all
  @got_people = Person.all
  @got_todos = Todo.all
  erb :index
end


#################### MOVIE SECTION ####################
get '/movies' do
  @got_movies = Movie.all
  erb :movies
end

# HERE THE USER INPUT A NEW MOVIE
get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  new_movie = download_movie(params[:title])
  redirect to("/movies/#{new_movie.id}")
end

# HERE USER CAN EDIT THE MOVIE INFO
get '/movies/edit/:id' do
  @got_movie = Movie.find(params[:id])
  erb :edit_movie
end

# EDIT THE DATABASE AND REDIRECT
post '/movies/edit/:id' do
  title = params[:title]
  year = params[:year]
  company = params[:company]
  genres = params[:genres]
  length = params[:length]
  director = params[:director]
  mpaa_rating = params[:mpaa_rating]
  poster = params[:poster]

  movie_to_edit = Movie.find(params[:id])
  movie_to_edit.update(title: title)
  movie_to_edit.update(year: year)
  movie_to_edit.update(company: company)
  movie_to_edit.update(genres: genres)
  movie_to_edit.update(length: length)
  movie_to_edit.update(director: director)
  movie_to_edit.update(mpaa_rating: mpaa_rating)
  movie_to_edit.update(poster: poster)

  redirect to("/movies/#{movie_to_edit.id}")
end

# HERE USER CAN DELETE A MOVIE
post '/movies/delete/:id' do
  movie_to_delete = Movie.find(params[:id])
  movie_to_delete.destroy
  redirect to('/movies')
end

# SHOW DETAILS OF EACH MOVIE
get '/movies/:id' do
  @got_movie = Movie.find(params[:id])
  erb :movie
end


#################### PEOPLE SECTION ####################
# SHOW ALL PEOPLE WORKING
get '/people' do
  @got_people = Person.all
  erb :people
end

# HERE USER CAN ADD A NEW PERSON
get '/people/new' do
  erb :new_person
end

# ADD A NEW PERSON TO DATABASE AND REDIRECT
post '/people/new' do
  new_person = Person.create(params)
  redirect to("/people")
end

# HERE USER CAN EDIT A NEW PERSON
get '/people/edit/:id' do
  @got_person = Person.find(params[:id])
  erb :edit_person
end

# EDIT THE DATABASE AND REDIRECT
post '/people/edit/:id' do
  name = params[:name]
  title = params[:title]
  phone = params[:phone]
  idiot = params[:idiot]

  person_to_edit = Person.find(params[:id])
  person_to_edit.update(name: name)
  person_to_edit.update(title: title)
  person_to_edit.update(phone: phone)
  person_to_edit.update(idiot: idiot)

  redirect to("/people/#{person_to_edit.id}")
end

# HERE USER CAN DELETE A PERSON
  post '/people/delete/:id' do
  person_to_delete = Person.find(params[:id])
  person_to_delete.destroy
  redirect to('/people')
end

# SHOW DETAILS OF EACH INDIVIDUAL
get '/people/:id' do
  @got_person = Person.find(params[:id])
  erb :person
end

#################### TODO SECTION ####################
# SHOW ALL TASKS
get '/todos' do
  @got_movies = Movie.all
  @got_people = Person.all
  @got_todos = Todo.all
  erb :todos
end

# HERE USER CAN ADD A NEW TASKS
get '/todos/new' do
  @got_movies = Movie.all
  @got_people = Person.all
  erb :new_todo
end

post '/todos/new' do
  new_todo = Todo.create(params)
  redirect to('/todos')
end

# HERE USER CAN EDIT A NEW TESK
get '/todos/edit/:id' do
  @got_todo = Todo.find(params[:id])

  @got_movies = Movie.all
  @got_people = Person.all
  erb :edit_todo
end

# EDIT THE DATABASE AND REDIRECT
post '/todos/edit/:id' do
  todo = params[:todo].capitalize
  note = params[:note].capitalize
  status = params[:status]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

  todo_to_edit = Todo.find(params[:id])
  todo_to_edit.update(todo: todo)
  todo_to_edit.update(note: note)
  todo_to_edit.update(status: status)
  todo_to_edit.update(person_id: person_id)
  todo_to_edit.update(movie_id: movie_id)

  redirect to("/todos/#{todo_to_edit.id}")
end

# HERE USER CAN DELETE A TASK
  post '/todos/delete/:id' do
  todo_to_delete = Todo.find(params[:id])
  todo_to_delete.destroy
  redirect to('/todos')
end

# SHOW DETAILS OF EACH TASK
get '/todos/:id' do
  @got_todo = Todo.find(params[:id])
  got_people = Person.all
  got_movie = Movie.all

  @assignee = got_people.find(@got_todo.person_id)[:name]
  @for_movie = got_movie.find(@got_todo.movie_id)[:title]

  erb :todo
end





