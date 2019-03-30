defmodule SampleWeb.PostController do
  use SampleWeb, :controller

  import Ecto.Query
  alias Sample.Repo

  alias Sample.Blog
  alias Sample.Blog.Post
  alias Sample.Blog.Comment
  alias Sample.Blog.Postcategory
  alias Sample.Blog.Category

  def index(conn, _params) do
    posts = Blog.list_posts()# |> Repo.preload[:comments]
    # changeset = Blog.change_comment(%Comment{})
    # posts = Repo.all Ecto.assoc(posts, :comments)
    # posts = from(p in Blog, preload: [:comments]) |> Repo.all(Post)

    render(conn, "index.html", posts: posts)
  end


  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    # changeset = Blog.change_post(%Post{
                                      # postcategories:
                                      # [%Sample.Blog.Postcategory{category_id: "%Category{}"}],
                                      # comments:
                                      # [%Sample.Blog.Comment{body: ""}],
                                      # })
    render(conn, "new.html", categories: categories, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))
        # |> assign(:post_id, "#{post.id}")
        # |> assign(:body, "hellow assigned text")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id) |> Repo.preload(:comments) |> Repo.preload(postcategories: :category)
    comments = Repo.all(Comment)
    render(conn, "show.html", post: post, comments: comments)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id) |> Repo.preload(:comments) |> Repo.preload(postcategories: :category)
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    # changeset= Blog.change_post(post)
    changeset = Blog.change_post(%Post{
                                  # comments:
                                  # [%Sample.Blog.Comment{body: ""}]
                                  postcategories:
                                  [%Sample.Blog.Postcategory{category_id: "%Category{}"}]
                                  })
    # changeset = Blog.change_post(%Post{comments: [%Sample.Blog.Comment{body: "Hello World comment!", post_id: "#{post.id}"}]})
    render(conn, "edit.html", post: post, categories: categories, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id) |> Repo.preload(:comments) |> Repo.preload(postcategories: :category)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
