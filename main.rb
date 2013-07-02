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
	if  params[:urgent].nil?
		 params[:urgent] = false
	else 
		 params[:urgent] = true
	end
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
	@person = Task.person
	@movie = Task.movie
	erb :todo 
end

# updates the details of a task
post '/todos/:id' do 

	todo = Task.find(params[:id])
	todo.task = params	[:task]
	todo.details = params[:details]
	todo.due = params[:due]
	todo.urgent = params[:urgent]
	todo.person_id = params[:person_id]
	todo.movie_id = params[:movie_id]
	redirect to('/todos')
end

# retrieves the necessary data to update a task (people, movies, task details)
get '/todos/:id/edit' do 
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	movies_sql = "SELECT * FROM movies" 
	people_sql = "SELECT * FROM people"
	@todo = run_sql(sql).first
	@movies = run_sql(movies_sql)
	@people = run_sql(people_sql)
	current_person_sql = "SELECT * from people WHERE id = #{@todo['person_id']}"
	current_movie_sql = "SELECT * FROM people WHERE id = #{@todo['movie_id']}"
	@current_person = run_sql(current_person_sql).first
	@current_movie = run_sql(current_movie_sql).first
	erb :edit_todo
end

# deletes a task
get '/todos/:id/delete' do
	sql = "DELETE FROM tasks WHERE id = #{params[:id]}"
	run_sql(sql)
	redirect to('/todos')
end

#################### End Task Specific Routes #########################

# lists all of the movies currently listed as in production
get '/movies' do 
	
	@movies = Movie.all
	erb :movies
end

post '/movies' do
	Movie.create(params)
	redirect to('/movies')
end

# adds a new movie to the movies in production
get '/movies/new' do
	@people = Person.all
	erb :new_movie
end


get '/movies/:id' do 
	@movie = Movie.find(params[:id])
	@director = Person.find(@movie.person_id)
	erb :movie
end

post '/movies/:id' do
	movie = Movie.find(params[:id])
	movie.title = params[:title]
	movie.description = params[:description]
	movie.person_id = params[:person_id]
	movie.save
	redirect to('/movies')
end

get '/movies/:id/edit' do
	@movie = Movie.find(params[:id])
	@director = Person.find(@movie.person_id)
	@people = Person.all
	erb :edit_movie
end

get '/movies/:id/delete' do
	Task.find_all_by_movie_id(params[:id]).each do |task|
		task.destroy
	end
	Movie.find(params[:id]).destroy
	redirect to('/movies')
end

#################### End Movie Specific Routes ########################

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
	@person.email = params[:email]
	@person.save
	redirect to('/people')
end

get '/people/:id/delete' do
	# Movie.find_all_by_person_id(params[:id]).each do |movie|
	# 	movie.destroy
	# end
	# Task.find_all_by_person_id(params[:id]).each do |task|
	# 	task.person_id = nil
	# 	task.save
	# end
	person = Person.find(params[:id])
	person.movies.each do |movie|
		movie.destroy
	end
	person.tasks.each do |task|
		task.destroy
	end
	# Person.find(params[:id]).destroy
	redirect to('/people')
end


