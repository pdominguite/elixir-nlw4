defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rocketpay.Account

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :username]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    has_one :account, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:username])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: false} = changeset), do: changeset

end
