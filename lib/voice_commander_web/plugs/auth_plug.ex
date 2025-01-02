defmodule VoiceCommanderWeb.AuthPlug do
  @behaviour Plug

  import Plug.Conn
  import Phoenix.Controller

  alias VoiceCommander.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn

      user_id ->
        case Accounts.get_user(user_id) do
          nil -> conn
          user -> assign(conn, :current_user, user)
        end
    end
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
