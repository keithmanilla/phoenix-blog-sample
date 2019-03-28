defmodule Sample.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query
  alias Sample.Blog.Comment
  alias Sample.Blog.Category


  schema "posts" do
    field :content, :string
    field :title, :string

    has_many :comments, Sample.Blog.Comment, on_delete: :delete_all

    has_many :postcategories, Sample.Blog.Postcategory, on_delete: :delete_all

    has_many :categories, through: [:postcategories, :category]

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content])
    |> cast_assoc(:comments)
    |> cast_assoc(:postcategories)
    # |> cast_assoc(:categories)
    |> validate_required([:title])
  end
end
