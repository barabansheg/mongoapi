defmodule MongoApi do
	use Application
	require Logger
	import Supervisor.Spec
  
	def start(_type, _args) do
		db_url = Application.get_env(:mongoapi, :db_url)
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

	def insert(collection, document) do
		Mongo.insert_one(:mongo, collection, document, pool: DBConnection.Poolboy)
	end

	def insert(collection, document, :result) do
		{:ok, %{inserted_id: inserted_id}} = insert(collection, document)
		findOne(collection, %{ _id: inserted_id })
	end

	def update(collection, query, document, :one) do
		Mongo.update_one(:mongo, collection, query, %{"$set": document}, pool: DBConnection.Poolboy)
	end

	def update(collection, query, document) do
		update(collection, query, document, :one)
	end

	def update(collection, query, document, :many) do
		Mongo.update_many(:mongo, collection, query, %{"$set": document}, pool: DBConnection.Poolboy)
	end

	

  end
