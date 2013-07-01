require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do 
	def run_sql(sql)
		db = PG.connect(dbname: 'production', host: 'localhost')
		result = db.exec(sql)
		db.close
		result
	end
end


get '/' do
	sql = "SELECT * FROM tasks"
	@tasks = run_sql(sql)
	erb :todos
end
