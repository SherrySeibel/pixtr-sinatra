require "sinatra"
require "active_record"
require "pq"

ActiveRecord::Base.establish_connection(
  adapter: "postgres",
  database: "flashcards"
)

class Flashcards < ActiveRecord::Base
end

