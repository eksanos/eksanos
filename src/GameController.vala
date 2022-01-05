namespace Eksanos {
	internal class GameController : GLib.Object {
		private Widgets.GameScreen game_screen;
		private Model.Game game_model;

		public GameController () {
			game_screen = new Widgets.GameScreen ();

			game_screen.board_tile_clicked.connect (on_board_tile_clicked);
			game_screen.new_game_clicked.connect (on_new_game_clicked);
		}

		public Gtk.Box get_game_screen () {
			return game_screen;
		}

		public void generate_new_game (string player_one_name, string player_two_name) {
			game_model = new Model.Game (player_one_name, player_two_name);

			game_model.player_score_updated.connect (on_player_score_updated);
			game_model.player_turn_started.connect (on_player_turn_started);
			game_model.player_turn_ended.connect (on_player_turn_ended);
			game_model.player_won.connect (on_player_won);
			game_model.player_lost.connect (on_player_lost);
			game_model.match_completed.connect (on_match_completed);
			game_model.board_updated.connect (on_board_updated);
			game_model.marker_placed.connect (on_marker_placed);
			game_model.new_match_ready.connect (on_new_match_ready);

			game_screen.update_player_names (player_one_name, player_two_name);
		}

		private void on_player_score_updated (string player_name, int score) {
			game_screen.update_player_score (player_name, score);
		}

		private void on_player_turn_started (string player_name) {
			game_screen.highlight_player_info (player_name);
			game_screen.update_turn_label (player_name);
		}

		private void on_player_turn_ended (string player_name) {
			game_screen.dim_player_info (player_name);
		}

		private void on_player_won (string player_name) {
			return;
		}

		private void on_player_lost (string player_name) {
			return;
		}

		private void on_match_completed (string result) {
			game_screen.disable_board ();
		}

		private void on_board_updated (string[,] board_state) {
			return;
		}

		private void on_marker_placed (int[] position, string marker) {
			game_screen.update_tile_marker (position, marker);
		}

		private void on_new_match_ready (string starting_player) {
			game_screen.enable_board ();
			game_screen.clear_board ();
		}

		private void on_board_tile_clicked (int[] position) {
			game_model.place_marker (position);
		}

		private void on_new_game_clicked () {
			game_model.start_new_match ();
		}
	}

}
