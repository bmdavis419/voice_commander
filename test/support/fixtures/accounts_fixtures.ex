defmodule VoiceCommander.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VoiceCommander.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        avatar_url: "some avatar_url",
        name: "some name",
        provider: "some provider",
        provider_id: "some provider_id"
      })
      |> VoiceCommander.Accounts.create_user()

    user
  end
end
