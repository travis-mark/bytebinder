defmodule Bytebinder.AdminTest do
  use Bytebinder.DataCase

  alias Bytebinder.Admin

  describe "games" do
    alias Bytebinder.Admin.Game

    import Bytebinder.AdminFixtures

    @invalid_attrs %{game: nil, game_no: nil, solution: nil, release_date: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Admin.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Admin.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{game: "some game", game_no: "some game_no", solution: "some solution", release_date: ~D[2023-08-25]}

      assert {:ok, %Game{} = game} = Admin.create_game(valid_attrs)
      assert game.game == "some game"
      assert game.game_no == "some game_no"
      assert game.solution == "some solution"
      assert game.release_date == ~D[2023-08-25]
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{game: "some updated game", game_no: "some updated game_no", solution: "some updated solution", release_date: ~D[2023-08-26]}

      assert {:ok, %Game{} = game} = Admin.update_game(game, update_attrs)
      assert game.game == "some updated game"
      assert game.game_no == "some updated game_no"
      assert game.solution == "some updated solution"
      assert game.release_date == ~D[2023-08-26]
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_game(game, @invalid_attrs)
      assert game == Admin.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Admin.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Admin.change_game(game)
    end
  end
end
