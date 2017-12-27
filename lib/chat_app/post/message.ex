defmodule ChatApp.Post.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.Post.Message
  alias ChatApp.Content.Topic


  schema "messages" do
    field :body, :string
    field :topic_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:body, :topic_id, :user_id])
    |> validate_required([:body, :topic_id, :user_id])
  end
end
