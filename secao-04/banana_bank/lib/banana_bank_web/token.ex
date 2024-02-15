defmodule BananaBankWeb.Token do
  alias Phoenix.Token
  alias BananaBankWeb.Endpoint
  alias BananaBank.Users.User

  @sign_salt "banana_bank_api"

  def sign(%User{id: id} = _user), do: Token.sign(Endpoint, @sign_salt, id)

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
