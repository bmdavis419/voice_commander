defmodule VoiceCommanderWeb.AuthController do
  use VoiceCommanderWeb, :controller
  plug Ueberauth

  alias VoiceCommander.Accounts

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    provider_id = to_string(auth.uid)

    user_params = %{
      provider: "github",
      provider_id: provider_id,
      name: auth.info.name || auth.info.nickname,
      avatar_url: auth.info.image
    }

    case Accounts.find_or_create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> redirect(to: ~p"/")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: ~p"/")
  end
end
