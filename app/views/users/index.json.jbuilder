json.array!(@users) do |user|
  json.extract! user, :id, :nome, :sobrenome, :email, :telefone
  json.url user_url(user, format: :json)
end
