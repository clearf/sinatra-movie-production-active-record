require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql',
                database: 'production_new',
                host: 'localhost'}

class Person < ActiveRecord::Base
  has_many :tasks
end

class Movie < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

get '/new_todo'  do
end

post '/new_todo'  do
end
