require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?


def run_sql(sql)
	db = PG.connect(dbname: 'production', host: 'localhost')
	result = db.exec(sql)
	db.close
	result
end


get '/' do

end

get '/todos' do
	sql = "SELECT * FROM tasks"
	@todos = run_sql(sql)
	erb :todos
end

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

get '/todos/:id' do
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	@todo = run_sql(sql).first
	erb :todo
end

get '/todos/new' do 
	people_sql = "SELECT * FROM people"
	movies_sql = "SELECT * FROM movies"
	@people = run_sql(people_sql)
	@movies = run_sql(movies_sql)
	erb :new_todo
end

get '/todos/edit' do 
	people_sql = "SELECT * FROM people"
	movies_sql = "SELECT * FROM movies"
	@people = run_sql(people_sql)
	@movies = run_sql(movies_sql)
	erb :edit_todo
end



