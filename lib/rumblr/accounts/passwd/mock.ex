defmodule Rumblr.Accounts.Passwd.Mock do
  alias Rumblr.Accounts.{Passwd, User}
  @behaviour Passwd

  @impl Passwd
  def hash(passwd) do
    passwd
  end

  @impl Passwd
  def check_pass(%User{} = user, passwd) do
    user.password_hash == passwd
  end

  @impl Passwd
  def no_user_verify() do
    nil
  end
end
