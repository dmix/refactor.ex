def fixture(:comment) do
  {:ok, comment} = Comment.create_category(valid_attrs())
  comment
end

describe "Comments" do
  test "comments index requires authentication", %{conn: conn} do
    categories_path(conn, :index)
  end
end
