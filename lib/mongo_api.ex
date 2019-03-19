defmodule MongoApi do
	use Application
	require Logger
	import Supervisor.Spec
  
	def start(_type, _args) do
		db_url = Application.get_env(:link, :db_url)
		children = [
			worker(Mongo, [[name: :mongo, pool: DBConnection.Poolboy, url: db_url]])
		] 
		
	  	Supervisor.start_link(children, strategy: :one_for_one)
	end

	def findOne(collection, query) do
		Mongo.find(:mongo, collection, query, pool: DBConnection.Poolboy) |> Enum.to_list |> List.first
	end

	def find(collection, query) do
		Mongo.find(:mongo, collection, query, pool: DBConnection.Poolboy) |> Enum.to_list
	end
	
  end
