require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do 
	def exec_sql(sql)
		db = PG.connect(dbname: 'production', host: 'localhost')
		result = db.exec(sql)
		db.close
		result
	end
end


get '/' do
	sql = "SELECT * FROM tasks;"
	@tasks = exec_sql(sql)
	erb :todos
end
