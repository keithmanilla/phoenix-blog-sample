defmodule SampleWeb.PostcategoryController do
  use SampleWeb, :controller

  import Ecto.Query
  alias Sample.Repo

  alias Sample.Blog
  alias Sample.Blog.Postcategory
  alias Sample.Blog.Post
  alias Sample.Blog.Category

  def index(conn, _params) do
    postcategories = Blog.list_postcategories()
    render(conn, "index.html", postcategories: postcategories)
  end

  def new(conn, _params) do
    posts = Repo.all(Post) |> Enum.map(&{&1.title, &1.id})
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    changeset = Blog.change_postcategory(%Postcategory{})
    render(conn, "new.html", categories: categories, posts: posts, changeset: changeset)
  end

  def create(conn, %{"postcategory" => postcategory_params}) do
    case Blog.create_postcategory(postcategory_params) do
      {:ok, postcategory} ->
        conn
        |> put_flash(:info, "Postcategory created successfully.")
        |> redirect(to: Routes.postcategory_path(conn, :show, postcategory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    postcategory = Blog.get_postcategory!(id)
    render(conn, "show.html", postcategory: postcategory)
  end

  def edit(conn, %{"id" => id}) do
    postcategory = Blog.get_postcategory!(id)
    posts = Repo.all(Post) |> Enum.map(&{&1.title, &1.id})
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    changeset = Blog.change_postcategory(postcategory)
    render(conn, "edit.html", postcategory: postcategory, changeset: changeset, categories: categories, posts: posts)
  end

  def update(conn, %{"id" => id, "postcategory" => postcategory_params}) do
    postcategory = Blog.get_postcategory!(id)

    case Blog.update_postcategory(postcategory, postcategory_params) do
      {:ok, postcategory} ->
        conn
        |> put_flash(:info, "Postcategory updated successfully.")
        |> redirect(to: Routes.postcategory_path(conn, :show, postcategory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", postcategory: postcategory, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    postcategory = Blog.get_postcategory!(id)
    {:ok, _postcategory} = Blog.delete_postcategory(postcategory)

    conn
    |> put_flash(:info, "Postcategory deleted successfully.")
    |> redirect(to: Routes.postcategory_path(conn, :index))
  end
end
