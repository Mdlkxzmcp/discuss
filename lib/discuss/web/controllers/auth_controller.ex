defmodule Discuss.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Discuss.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Discuss.Accounts

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{ provider: Map.get(params, "provider"),
      token: auth.credentials.token, email: auth.info.email,
      username: auth.info.nickname, location: auth.info.location }

    sign_in(conn, user_params)

  end

  defp sign_in(conn, params) do
    case insert_or_update_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error when signing in :C")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(params) do
    case Accounts.get_user_by_email(params) do
      nil ->
        Accounts.create_user(params)
      user ->
        {:ok, user}
    end
  end
end
