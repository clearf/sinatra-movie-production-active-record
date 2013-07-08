require 'pg'
require 'sinatra'
require 'sinatra/reloader'
#more gems
require 'sinatra/activerecord'
require 'rake'

#database
set :database, { adapter: 'postgresql', database: '' } # no db name

#classes
class Person < ActiveRecord::Base
	has_many :movies
	has_many :tasks
end
class Task < ActiveRecord::Base 
	belongs_to :person #needs person_id
	belongs_to :movies #needs movie_id
end
class Movies < ActiveRecord::Base
	has_many :tasks
	belongs_to :person
end

#negotiations
get '/' do
	erb :index
end

#people
get '/people' do
	@people = Person.all
	erb :people
end

post '/people' do
	Person.create(params)
	redirect to('/people')
end

get '/people/new' do
	erb :new_person
end

get '/people/:id' do 
	@person = Person.find(params[:id])
	erb :person
end

get '/people/:id/edit' do 
	@person = Person.find(params[:id])
	erb :edit_person
end

post '/people/:id/edit' do
	@person = Person.find(params[:id])
	@person.name = params[:name]
	#@person.email = params[:email]
	@person.save
	
	redirect to('/people')
end

get '/people/:id/delete' do

	person = Person.find(params[:id])
	person.movies.each do |movie| movie.destroy end
	person.tasks.each do |task| task.destroy end
	Person.find(params[:id]).destroy	
	redirect to('/people')
end

#todos
get '/todos' do
	@todos = Task.all
	erb :todos
end

post '/todos' do 
	Task.create(params)
	redirect to('/todos')
end

get '/todos/new' do
	@movies = Movie.all
	@people = Person.all
	erb :new_todo
end

get '/todos/:id' do
	@todo = Task.find(params[:id])
	@person = @todo.person
	@movie = @todo.movie
	erb :todo 
end

post '/todos/:id' do 
	todo = Task.find(params[:id])
	todo.task = params[:task]
	todo.details = params[:details]
	todo.date = params[:date]
	todo.person_id = params[:person_id]
	todo.movie_id = params[:movie_id]
	redirect to('/todos')
end

get '/todos/:id/edit' do 
	@todo = Task.find(params[:id])
	@movies = Movie.all
	@people = Person.all
	erb :edit_todo
end

get '/todos/:id/delete' do
	Task.find(params[:id]).destroy
	redirect to('/todos')
end

#movies
get '/movies' do 
	@movies = Movie.all
	erb :movies
end

post '/movies' do
	Movie.create(params)
	redirect to('/movies')
end

get '/movies/new' do
	@people = Person.all
	erb :new_movie
end

get '/movies/:id' do 
	@movie = Movie.find(params[:id])
	erb :movie
end

post '/movies/:id' do
	movie = Movie.find(params[:id])
	movie.title = params[:title]
	movie.description = params[:description]
	movie.person_id = params[:person_id]
	redirect to('/movies')
end

get '/movies/:id/edit' do
	@movie = Movie.find(params[:id])
	@people = Person.all
	erb :edit_movie
end

get '/movies/:id/delete' do
	Task.find_all_by_movie_id(params[:id]).each do |task| task.destroy end
	Movie.find(params[:id]).destroy
	redirect to('/movies')
end
