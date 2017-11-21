def fixture(:category) do
  {:ok, category} = Category.create_category(valid_attrs())
  category
end

describe "Categories" do
  test "categories index requires authentication", %{conn: conn} do
    categories_path(conn, :index)
  end
end
