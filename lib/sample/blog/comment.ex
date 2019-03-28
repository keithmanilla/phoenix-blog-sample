defmodule Sample.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  # import Ecto.Query
  # alias Sample.Blog.Post

  alias Sample.Repo

  schema "comments" do
    field :body, :string
    # field :post_id, :id

    belongs_to :post, Sample.Blog.Post # , on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body, :post_id])
    |> foreign_key_constraint(:post_id)
  end
end
