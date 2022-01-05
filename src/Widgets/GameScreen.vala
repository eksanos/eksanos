namespace Eksanos.Widgets {
	internal class GameScreen : Gtk.Box {
		private Widgets.PlayerInfoBox player_one_info_box;
		private Widgets.PlayerInfoBox player_two_info_box;
		private Widgets.BoardGrid board_grid;
		private Gtk.Label turn_tracker_label;

		public signal void board_tile_clicked (int[] position);
		public signal void new_game_clicked ();


		public GameScreen () {
			orientation = Gtk.Orientation.HORIZONTAL;
			player_one_info_box = new Widgets.PlayerInfoBox ("Player 1", 4);
			player_two_info_box = new Widgets.PlayerInfoBox ("Player 2", 4);
			board_grid = new Widgets.BoardGrid (" ");
			board_grid.cell_selected.connect (on_board_cell_selected);

			setup_game_screen ();
		}

		public void reset () {
			board_grid.clear_board ();
			board_grid.enable ();
			player_one_info_box.update_player_name ("Player 1");
			player_one_info_box.update_score_label (0);
			player_one_info_box.enable ();
			player_two_info_box.update_player_name ("Player 2");
			player_two_info_box.update_score_label (0);
			player_two_info_box.disable ();
			turn_tracker_label.set_label ("Player 1's Turn");
		}

		public void update_player_names (string player_one_name, string player_two_name) {
			player_one_info_box.update_player_name (player_one_name);
			player_two_info_box.update_player_name (player_two_name);
		}

		public void update_player_score (string player_name, int score) {
			if (player_name == player_one_info_box.get_player_name ()) {
				player_one_info_box.update_score_label (score);
			} else {
				player_two_info_box.update_score_label (score);
			}
		}

		public void update_turn_label (string player_name) {
			turn_tracker_label.set_label (player_name + "'s Turn");
		}

		public void highlight_player_info (string player_name) {
			if (player_name == player_one_info_box.get_player_name ()) {
				player_one_info_box.enable ();
			} else {
				player_two_info_box.enable ();
			}
		}

		public void dim_player_info (string player_name) {
			if (player_name == player_one_info_box.get_player_name ()) {
				player_one_info_box.disable ();
			} else {
				player_two_info_box.disable ();
			}
		}

		public void disable_board () {
			board_grid.disable ();
		}

		public void enable_board () {
			board_grid.enable ();
		}

		public void clear_board () {
			board_grid.clear_board ();
		}

		public void update_tile_marker (int[] position, string marker) {
			board_grid.update_tile_marker (position, marker);
		}

		private void setup_game_screen () {
			pack_start(player_one_info_box, true, false, 4);

			Gtk.Box board_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			turn_tracker_label = new Gtk.Label ("Player 1" + "'s Turn");
			board_box.pack_start (turn_tracker_label, false, false, 4);
			board_box.pack_start (board_grid, true, false, 0);
			Gtk.Button reset_button = new Gtk.Button.with_label ("New Game");
			reset_button.clicked.connect (on_new_match_clicked);
			board_box.pack_end (reset_button, false, false, 4);
			pack_start (board_box, false, false, 0);

			pack_start (player_two_info_box, true, false, 4);
		}

		private void on_new_match_clicked () {
			new_game_clicked ();
		}

		private void on_board_cell_selected (int[] position) {
			board_tile_clicked (position);
		}
	}
}
