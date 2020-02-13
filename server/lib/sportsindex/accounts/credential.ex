defmodule Sportsindex.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  @attrs [:email, :password]

  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    belongs_to :user, Sportsindex.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, @attrs)
    |> validate_required(@attrs)
    |> validate_changeset()
  end

  def validate_changeset(struct) do
    struct
    |> transform()
    |> hash_password()
  end

  defp transform(changeset) do
    changeset
    |> update_change(:email, &String.downcase/1)
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{ password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
