defmodule MongoApiTest do
  use ExUnit.Case
  doctest MongoApi

  test "greets the world" do
    assert MongoApi.hello() == :world
  end
end
