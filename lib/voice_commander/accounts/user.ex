defmodule VoiceCommander.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :provider, :string
    field :avatar_url, :string
    field :provider_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:provider, :provider_id, :name, :avatar_url])
    |> validate_required([:provider, :provider_id])
    |> unique_constraint([:provider, :provider_id])
  end
end
