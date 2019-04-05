defmodule MongoApi.Types do
    def to_objectId(str) do
		binary_data = for <<hex::16 <- str>>, into: <<>>, do: <<String.to_integer(<<hex::16>>, 16)::8>>
		%BSON.ObjectId{value: binary_data}
    end
    
    defimpl String.Chars, for: BSON.ObjectId do
        def to_string(object_id) do
            Base.encode16(object_id.value, case: :lower) 
        end
      end
end