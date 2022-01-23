defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf) when byte_size(cpf) == 11 and is_bitstring(cpf) do
    id = UUID.uuid4()

    {:ok, %__MODULE__{
      name: name,
      email: email,
      cpf: cpf,
      id: id
    }}
  end

  def build(_name, _email, _cpf), do: {:error, "Invalid parameters"}
end
