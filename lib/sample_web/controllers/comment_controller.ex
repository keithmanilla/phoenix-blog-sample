defmodule SampleWeb.CommentController do
  use SampleWeb, :controller

  import Ecto.Query
  alias Sample.Repo

  alias Sample.Blog
  alias Sample.Blog.Comment
  alias Sample.Blog.Post

  def index(conn, _params) do
    comments = Repo.all(Comment) |> Repo.preload(:post)
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Blog.change_comment(%Comment{})
    posts = Repo.all(Post) |> Enum.map(&{&1.title, &1.id})
    # changeset =
    #   comment
    #   |> build_assoc(:post)
    #   |> Comment.changeset()
    render(conn, "new.html", changeset: changeset, posts: posts)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Blog.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    changeset = Blog.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Blog.get_comment!(id)

    case Blog.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    {:ok, _comment} = Blog.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
