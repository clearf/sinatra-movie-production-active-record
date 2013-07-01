require 'pry'
require 'pg'
require 'postgres'
require 'postgres/reloader' if development?

helpers do 
	def exec_sql(sql)
		db = PG.connect(dbname: 'production', host: 'localhost')
		result = db.exec(sql)
		db.close
		result
	end
end


get '/' do

end
