/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos.Widgets {
	internal class GameScreen : Gtk.Box {
		private Gtk.Window parent_window;
		private Widgets.PlayerInfoBox player_one_info_box;
		private Widgets.PlayerInfoBox player_two_info_box;
		private Widgets.BoardGrid board_grid;
		private Gtk.Label turn_tracker_label;

		public signal void board_tile_clicked (int[] position);
		public signal void new_game_clicked ();


		public GameScreen (Gtk.Window parent_window) {
			this.parent_window = parent_window;
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

		public void update_marker_color (string color_name) {
			board_grid.update_marker_color (color_name);
		}

		public void show_match_over_dialog (int result) {
			string player1_name = player_one_info_box.get_player_name();
			string player2_name = player_two_info_box.get_player_name();

			Widgets.MatchOverDialog match_over_dialog = new Widgets.MatchOverDialog (result, player1_name, player2_name);

			match_over_dialog.transient_for = parent_window;

			int response_id = match_over_dialog.run ();
			if (response_id == Gtk.ResponseType.CANCEL) {
				match_over_dialog.destroy ();
			} else if (response_id == Gtk.ResponseType.ACCEPT) {
				match_over_dialog.destroy ();
				new_game_clicked ();
			} else if (response_id == Gtk.ResponseType.CLOSE) {
				match_over_dialog.destroy ();
				//quit_game_requested ();
			}
		}

		private void setup_game_screen () {
			Gtk.Frame board_frame = new Gtk.Frame (null);
			board_frame.add (board_grid);

			pack_start(player_one_info_box, true, false, 4);

			Gtk.Box board_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			turn_tracker_label = new Gtk.Label ("Player 1" + "'s Turn");
			board_box.pack_start (turn_tracker_label, false, false, 4);
			board_box.pack_start (board_frame, true, false, 0);
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
