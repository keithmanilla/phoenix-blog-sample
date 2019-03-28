defmodule Sample.Blog.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :name, :string

    has_many :postcategories, Sample.Blog.Postcategory

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
