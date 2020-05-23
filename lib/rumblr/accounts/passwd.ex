defmodule Rumblr.Accounts.Passwd do
  alias Rumblr.Accounts.User

  @callback hash(String.t()) :: String.t()
  @callback check_pass(%User{}, String.t()) :: {:ok, %User{}} | {:error, String.t()}
  @callback no_user_verify() :: nil

  defp impl() do
    Application.fetch_env!(:rumblr, :passwd)
  end

  def hash(passwd) do
    apply(impl(), :hash, [passwd])
  end

  def check_pass(%User{} = user, passwd) do
    apply(impl(), :check_pass, [user, passwd])
  end

  def no_user_verify() do
    apply(impl(), :no_user_verify)
  end
end
