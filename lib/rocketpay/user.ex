defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |>cast(params, @required_params)
    |>validate_required(@required_params)
    |>validate_length(:password, min: 6)
    |>validate_number(:age, greater_than_or_equal_to: 18)
    |>validate_format(:email, ~r/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/)
    |>unique_constraint([:email])
    |>unique_constraint([:nickname])
    |>put_password
  end

  defp put_password(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password(changeset), do: changeset
end
