defmodule Sample.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Sample.Repo

  alias Sample.Blog.Post
  # alias Sample.Blog.Comment

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post) |> Repo.preload(:comments) |> Repo.preload(postcategories: :category) |> Repo.preload(postcategories: :post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload(:comments) |> Repo.preload(postcategories: :category)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    # |> Post.changeset2(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Sample.Blog.Comment


  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment) |> Repo.preload[:post]
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id) |> Repo.preload(:post )

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  alias Sample.Blog.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  alias Sample.Blog.Postcategory

  @doc """
  Returns the list of postcategories.

  ## Examples

      iex> list_postcategories()
      [%Postcategory{}, ...]

  """
  def list_postcategories do
    Repo.all(Postcategory) |> Repo.preload(:post) |> Repo.preload(:category)
  end

  @doc """
  Gets a single postcategory.

  Raises `Ecto.NoResultsError` if the Postcategory does not exist.

  ## Examples

      iex> get_postcategory!(123)
      %Postcategory{}

      iex> get_postcategory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_postcategory!(id), do: Repo.get!(Postcategory, id)

  @doc """
  Creates a postcategory.

  ## Examples

      iex> create_postcategory(%{field: value})
      {:ok, %Postcategory{}}

      iex> create_postcategory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_postcategory(attrs \\ %{}) do
    %Postcategory{}
    |> Postcategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a postcategory.

  ## Examples

      iex> update_postcategory(postcategory, %{field: new_value})
      {:ok, %Postcategory{}}

      iex> update_postcategory(postcategory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_postcategory(%Postcategory{} = postcategory, attrs) do
    postcategory
    |> Postcategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Postcategory.

  ## Examples

      iex> delete_postcategory(postcategory)
      {:ok, %Postcategory{}}

      iex> delete_postcategory(postcategory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_postcategory(%Postcategory{} = postcategory) do
    Repo.delete(postcategory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking postcategory changes.

  ## Examples

      iex> change_postcategory(postcategory)
      %Ecto.Changeset{source: %Postcategory{}}

  """
  def change_postcategory(%Postcategory{} = postcategory) do
    Postcategory.changeset(postcategory, %{})
  end
end
