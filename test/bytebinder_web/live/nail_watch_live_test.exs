defmodule BytebinderWeb.NailWatchLiveTest do
  use BytebinderWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bytebinder.NotebookFixtures

  @create_attrs %{date: "2023-09-23", flag: "some flag", nails: 42, skin: 42, blood: 42}
  @update_attrs %{date: "2023-09-24", flag: "some updated flag", nails: 43, skin: 43, blood: 43}
  @invalid_attrs %{date: nil, flag: nil, nails: nil, skin: nil, blood: nil}

  defp create_nail_watch(_) do
    nail_watch = nail_watch_fixture()
    %{nail_watch: nail_watch}
  end

  describe "Index" do
    setup [:create_nail_watch]

    test "lists all nail_watch", %{conn: conn, nail_watch: nail_watch} do
      {:ok, _index_live, html} = live(conn, ~p"/nail_watch")

      assert html =~ "Listing Nail watch"
      assert html =~ nail_watch.flag
    end

    test "saves new nail_watch", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/nail_watch")

      assert index_live |> element("a", "New Nail watch") |> render_click() =~
               "New Nail watch"

      assert_patch(index_live, ~p"/nail_watch/new")

      assert index_live
             |> form("#nail_watch-form", nail_watch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#nail_watch-form", nail_watch: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/nail_watch")

      html = render(index_live)
      assert html =~ "Nail watch created successfully"
      assert html =~ "some flag"
    end

    test "updates nail_watch in listing", %{conn: conn, nail_watch: nail_watch} do
      {:ok, index_live, _html} = live(conn, ~p"/nail_watch")

      assert index_live |> element("#nail_watch-#{nail_watch.id} a", "Edit") |> render_click() =~
               "Edit Nail watch"

      assert_patch(index_live, ~p"/nail_watch/#{nail_watch}/edit")

      assert index_live
             |> form("#nail_watch-form", nail_watch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#nail_watch-form", nail_watch: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/nail_watch")

      html = render(index_live)
      assert html =~ "Nail watch updated successfully"
      assert html =~ "some updated flag"
    end

    test "deletes nail_watch in listing", %{conn: conn, nail_watch: nail_watch} do
      {:ok, index_live, _html} = live(conn, ~p"/nail_watch")

      assert index_live |> element("#nail_watch-#{nail_watch.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#nail_watch-#{nail_watch.id}")
    end
  end

  describe "Show" do
    setup [:create_nail_watch]

    test "displays nail_watch", %{conn: conn, nail_watch: nail_watch} do
      {:ok, _show_live, html} = live(conn, ~p"/nail_watch/#{nail_watch}")

      assert html =~ "Show Nail watch"
      assert html =~ nail_watch.flag
    end

    test "updates nail_watch within modal", %{conn: conn, nail_watch: nail_watch} do
      {:ok, show_live, _html} = live(conn, ~p"/nail_watch/#{nail_watch}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Nail watch"

      assert_patch(show_live, ~p"/nail_watch/#{nail_watch}/show/edit")

      assert show_live
             |> form("#nail_watch-form", nail_watch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#nail_watch-form", nail_watch: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/nail_watch/#{nail_watch}")

      html = render(show_live)
      assert html =~ "Nail watch updated successfully"
      assert html =~ "some updated flag"
    end
  end
end
