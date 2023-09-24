defmodule Bytebinder.NotebookTest do
  use Bytebinder.DataCase

  alias Bytebinder.Notebook

  describe "nail_watch" do
    alias Bytebinder.Notebook.NailWatch

    import Bytebinder.NotebookFixtures

    @invalid_attrs %{date: nil, flag: nil, nails: nil, skin: nil, blood: nil}

    test "list_nail_watch/0 returns all nail_watch" do
      nail_watch = nail_watch_fixture()
      assert Notebook.list_nail_watch() == [nail_watch]
    end

    test "get_nail_watch!/1 returns the nail_watch with given id" do
      nail_watch = nail_watch_fixture()
      assert Notebook.get_nail_watch!(nail_watch.id) == nail_watch
    end

    test "create_nail_watch/1 with valid data creates a nail_watch" do
      valid_attrs = %{date: ~D[2023-09-23], flag: "some flag", nails: 42, skin: 42, blood: 42}

      assert {:ok, %NailWatch{} = nail_watch} = Notebook.create_nail_watch(valid_attrs)
      assert nail_watch.date == ~D[2023-09-23]
      assert nail_watch.flag == "some flag"
      assert nail_watch.nails == 42
      assert nail_watch.skin == 42
      assert nail_watch.blood == 42
    end

    test "create_nail_watch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notebook.create_nail_watch(@invalid_attrs)
    end

    test "update_nail_watch/2 with valid data updates the nail_watch" do
      nail_watch = nail_watch_fixture()
      update_attrs = %{date: ~D[2023-09-24], flag: "some updated flag", nails: 43, skin: 43, blood: 43}

      assert {:ok, %NailWatch{} = nail_watch} = Notebook.update_nail_watch(nail_watch, update_attrs)
      assert nail_watch.date == ~D[2023-09-24]
      assert nail_watch.flag == "some updated flag"
      assert nail_watch.nails == 43
      assert nail_watch.skin == 43
      assert nail_watch.blood == 43
    end

    test "update_nail_watch/2 with invalid data returns error changeset" do
      nail_watch = nail_watch_fixture()
      assert {:error, %Ecto.Changeset{}} = Notebook.update_nail_watch(nail_watch, @invalid_attrs)
      assert nail_watch == Notebook.get_nail_watch!(nail_watch.id)
    end

    test "delete_nail_watch/1 deletes the nail_watch" do
      nail_watch = nail_watch_fixture()
      assert {:ok, %NailWatch{}} = Notebook.delete_nail_watch(nail_watch)
      assert_raise Ecto.NoResultsError, fn -> Notebook.get_nail_watch!(nail_watch.id) end
    end

    test "change_nail_watch/1 returns a nail_watch changeset" do
      nail_watch = nail_watch_fixture()
      assert %Ecto.Changeset{} = Notebook.change_nail_watch(nail_watch)
    end
  end
end
