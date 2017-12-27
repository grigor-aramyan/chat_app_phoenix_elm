defmodule ChatApp.Content.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.Post.Message
  alias ChatApp.Content.Topic


  schema "topics" do
    field :message_count, :integer
    field :title, :string
    field :user_id, :id

    has_many :messages, Message, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
