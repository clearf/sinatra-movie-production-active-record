require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

# helper function that runs an input sql string
def run_sql(sql)
	db = PG.connect(dbname: 'production', host: 'localhost')
	result = db.exec(sql)
	db.close
	result
end


get '/' do

end

# lists all of the tasks that require completion
get '/todos' do
	sql = "SELECT * FROM tasks"
	@todos = run_sql(sql)
	erb :todos
end

# adds a new todo to the lists of tasks to be done
post '/todos' do 
	urgent = params[:urgent]
	if urgent == "on"
		urgent = true
	else
		urgent = false
	end
	sql = "INSERT INTO tasks (task, details, due, urgent) VALUES "\
	"('#{params[:task]}', '#{params[:details]}', '#{params[:due]}', "\
	" '#{params[:urgent]}')"
	run_sql(sql)
	redirect to('/todos')
end

# shows the details of a task
get '/todos/:id' do
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	@todo = run_sql(sql).first
	erb :todo 
end

# updates the details of a task
post '/todos/:id' do 
	urgent = params[:urgent]
	binding.pry
	if urgent == "on"
		urgent = true
	else
		urgent = false
	end
	sql = "UPDATE tasks SET (task, details, due, urgent) = "\
	"('#{params[:task]}', '#{params[:details]}', '#{params[:due]}', "\
	" '#{params[:urgent]}') WHERE id = #{params[:id]}"
	run_sql(sql)
	redirect to('/todos')
end

# 
get '/todos/new' do 
	people_sql = "SELECT * FROM people"
	movies_sql = "SELECT * FROM movies"
	@people = run_sql(people_sql)
	@movies = run_sql(movies_sql)
	erb :new_todo
end

get '/todos/:id/edit' do 
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	@todo = run_sql(sql).first
	erb :edit_todo
end

