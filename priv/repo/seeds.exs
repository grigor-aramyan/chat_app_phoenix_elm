# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ChatApp.Repo.insert!(%ChatApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ChatApp.Repo
alias ChatApp.Coherence.User

Repo.delete_all(User)
User.changeset(%User{}, %{name: "john", email: "john.smith@gmail.com",
  password: "secret", password_confirmation: "secret"})
  |> Repo.insert!