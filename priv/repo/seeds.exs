# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumblr.Repo.insert!(%Rumblr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Rumblr.Multimedia

for category <- ~w(erlang elixir phoenix ecto live-view) do
  Multimedia.create_category!(category)
end
