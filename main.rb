require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rake'
require 'sinatra/activerecord'

set :database, {
	adapter: 'postgresql',
	database: 'production',
	host: 'localhost'
}

class Person < ActiveRecord::Base
	has_many :movies
	has_many :tasks
end

class Movie < ActiveRecord::Base
	belongs_to :person
	has_many :tasks
end

class Task < ActiveRecord::Base
	belongs_to :person
	belongs_to :movie
end

get '/' do
	erb :index
end

# lists all of the tasks that require completion
get '/todos' do
	@todos = Task.all
	erb :todos
end

# adds a new todo to the lists of tasks to be done
post '/todos' do 
	Task.create(params)
	redirect to('/todos')
end

# gets the necessary data to create a new task item (people and movies)
get '/todos/new' do
	@movies = Movie.all
	@people = Person.all
	erb :new_todo
end

# shows the details of a task
get '/todos/:id' do
	
	@todo = Task.find(params[:id])
	@person = @todo.person
	@movie = @todo.movie
	erb :todo 
end

# updates the details of a task
post '/todos/:id' do 
	todo = Task.find(params[:id])
	todo.details = params[:details]
	todo.due = params[:due]
	todo.task = params[:task]
	todo.urgent = params[:urgent]
	todo.person_id = params[:person_id]
	todo.movie_id = params[:movie_id]
	todo.save
	redirect to('/todos')
end

# retrieves the necessary data to update a task (people, movies, task details)
get '/todos/:id/edit' do 
	
	@todo = Task.find(params[:id])
	@movies = Movie.all
	@people = Person.all
	@current_person = @todo.person
	@current_movie = @todo.movie
	erb :edit_todo
end

# deletes a task
get '/todos/:id/delete' do
	Task.find(params[:id]).destroy
	redirect to('/todos')
end

#################### End Task Specific Routes #########################

# lists all of the movies currently listed as in production
get '/movies' do 
	
	@movies = Movie.all
	erb :movies
end

# adds a new movie by passing in the parameters
post '/movies' do
	Movie.create(params)
	redirect to('/movies')
end

# gets add form
get '/movies/new' do
	@people = Person.all
	erb :new_movie
end

# shows a single movie on its own page
get '/movies/:id' do 
	@movie = Movie.find(params[:id])
	if @movie.person_id
		@director = Person.find(@movie.person_id)
	else
		@director = nil
	end
	erb :movie
end

# edits a movie
post '/movies/:id' do
	movie = Movie.find(params[:id])
	movie.title = params[:title]
	movie.description = params[:description]
	movie.person_id = params[:person_id]
	movie.save
	redirect to('/movies')
end

#gets movie edit form
get '/movies/:id/edit' do
	@movie = Movie.find(params[:id])
	if @movie.person_id
		@director = Person.find(@movie.person_id)
	else
		@director = nil
	end
	@people = Person.all
	erb :edit_movie
end

#removes a movie and all tasks associated with it
get '/movies/:id/delete' do
	Task.find_all_by_movie_id(params[:id]).each do |task|
		task.destroy
	end
	Movie.find(params[:id]).destroy
	redirect to('/movies')
end

#################### End Movie Specific Routes ########################

# lists all of the people in the database
get '/people' do
	@people = Person.all
	erb :people
end

# adds a new person to the database
post '/people' do
	Person.create(params)
	redirect to('/people')
end

# gets the new person form
get '/people/new' do
	erb :new_person
end

# list a person on a single page
get '/people/:id' do 
	@person = Person.find(params[:id])
	erb :person
end

# gets the edit form for a person
get '/people/:id/edit' do 
	@person = Person.find(params[:id])
	erb :edit_person
end

# saves edits to database
post '/people/:id/edit' do
	person = Person.find(params[:id])
	person.name = params[:name]
	person.email = params[:email]
	person.save
	redirect to('/people')
end

#deletes a person and all tasks and movies associated with them
get '/people/:id/delete' do

	person = Person.find(params[:id])
	person.movies.each do |movie|
		movie.destroy
	end
	person.tasks.each do |task|
		task.destroy
	end
	person.destroy
	redirect to('/people')
end


