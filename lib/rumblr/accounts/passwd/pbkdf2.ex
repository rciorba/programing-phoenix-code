defmodule Rumblr.Accounts.Passwd.Pbkdf2 do
  alias Rumblr.Accounts.{Passwd, User}
  @behaviour Passwd

  @impl Passwd
  def hash(passwd) do
    Pbkdf2.hash_pwd_salt(passwd)
  end

  @impl Passwd
  def check_pass(%User{} = user, passwd) do
    Pbkdf2.verify_pass(passwd, user.password_hash)
  end

  @impl Passwd
  def no_user_verify() do
    Pbkdf2.no_user_verify()
  end
end
