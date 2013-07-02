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
end

class Movie < ActiveRecord::Base
	belongs_to :person
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
	urgent = params[:urgent]
	if urgent.nil?
		urgent = false
	else 
		urgent = true
	end
		sql = "UPDATE tasks SET (task, details, due, urgent, person_id, movie_id)"\
	" = ('#{params[:task]}', '#{params[:details]}', '#{params[:due]}', "\
	" '#{urgent}', #{params[:person_id]}, #{params[:movie_id]}) WHERE id = "\
	" #{params[:id]}"
	run_sql(sql)
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
	@director = Person.find(@movie.director_id)
	erb :movie
end

post '/movies/:id' do
	movie = Movie.find(params[:id])
	movie.title = params[:title]
	movie.description = params[:description]
	movie.director_id = params[:director_id]
	redirect to('/movies')
end

get '/movies/:id/edit' do
	@movie = Movie.find(params[:id])
	@director = Person.find(@movie.director_id)
	@people = People.all
	erb :edit_movie
end

get '/movies/:id/delete' do
	tasks_sql = "UPDATE tasks SET movie_id = 1 WHERE movie_id = #{params[:id]}"
	run_sql(tasks_sql)
	sql = "DELETE FROM movies WHERE id = #{params[:id]}"
	run_sql(sql)
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
	binding.pry
	@person = Person.find(params[:id])
	@movies = Movie.find_by_director(params[:id])
	@tasks = Task.find_by_person(params[:id])
	redirect to('/people')
end


