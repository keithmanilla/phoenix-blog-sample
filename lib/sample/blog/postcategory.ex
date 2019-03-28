defmodule Sample.Blog.Postcategory do
  use Ecto.Schema
  import Ecto.Changeset


  schema "postcategories" do
    # field :post_id, :id
    # field :category_id, :id

    belongs_to :post, Sample.Blog.Post
    belongs_to :category, Sample.Blog.Category
    timestamps()
  end

  @doc false
  def changeset(postcategory, attrs) do
    postcategory
    |> cast(attrs, [:post_id, :category_id])
    # |> cast_assoc(:post)
    # |> cast_assoc(:category)
    |> validate_required([:post_id, :category_id])
  end
end
