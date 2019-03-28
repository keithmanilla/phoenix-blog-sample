defmodule SampleWeb.PostcategoryControllerTest do
  use SampleWeb.ConnCase

  alias Sample.Blog

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:postcategory) do
    {:ok, postcategory} = Blog.create_postcategory(@create_attrs)
    postcategory
  end

  describe "index" do
    test "lists all postcategories", %{conn: conn} do
      conn = get(conn, Routes.postcategory_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Postcategories"
    end
  end

  describe "new postcategory" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.postcategory_path(conn, :new))
      assert html_response(conn, 200) =~ "New Postcategory"
    end
  end

  describe "create postcategory" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.postcategory_path(conn, :create), postcategory: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.postcategory_path(conn, :show, id)

      conn = get(conn, Routes.postcategory_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Postcategory"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.postcategory_path(conn, :create), postcategory: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Postcategory"
    end
  end

  describe "edit postcategory" do
    setup [:create_postcategory]

    test "renders form for editing chosen postcategory", %{conn: conn, postcategory: postcategory} do
      conn = get(conn, Routes.postcategory_path(conn, :edit, postcategory))
      assert html_response(conn, 200) =~ "Edit Postcategory"
    end
  end

  describe "update postcategory" do
    setup [:create_postcategory]

    test "redirects when data is valid", %{conn: conn, postcategory: postcategory} do
      conn = put(conn, Routes.postcategory_path(conn, :update, postcategory), postcategory: @update_attrs)
      assert redirected_to(conn) == Routes.postcategory_path(conn, :show, postcategory)

      conn = get(conn, Routes.postcategory_path(conn, :show, postcategory))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, postcategory: postcategory} do
      conn = put(conn, Routes.postcategory_path(conn, :update, postcategory), postcategory: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Postcategory"
    end
  end

  describe "delete postcategory" do
    setup [:create_postcategory]

    test "deletes chosen postcategory", %{conn: conn, postcategory: postcategory} do
      conn = delete(conn, Routes.postcategory_path(conn, :delete, postcategory))
      assert redirected_to(conn) == Routes.postcategory_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.postcategory_path(conn, :show, postcategory))
      end
    end
  end

  defp create_postcategory(_) do
    postcategory = fixture(:postcategory)
    {:ok, postcategory: postcategory}
  end
end
