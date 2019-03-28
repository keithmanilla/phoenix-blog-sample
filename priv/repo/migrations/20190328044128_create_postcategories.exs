defmodule Sample.Repo.Migrations.CreatePostcategories do
  use Ecto.Migration

  def change do
    create table(:postcategories) do
      add :post_id, references(:posts, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:postcategories, [:post_id])
    create index(:postcategories, [:category_id])
  end
end
