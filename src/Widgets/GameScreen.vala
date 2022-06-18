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
		private Widgets.TurnTrackerStack turn_tracker_stack;

		public signal void board_tile_clicked (int[] position);
		public signal void new_game_requested ();
		public signal void quit_game_requested ();
		public signal void back_to_main_menu_requested ();


		public GameScreen (Gtk.Window parent_window) {
			this.parent_window = parent_window;
			orientation = Gtk.Orientation.VERTICAL;
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
			turn_tracker_stack.add_turn_text ("Player 1's Turn");
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
			turn_tracker_stack.add_turn_text (player_name + "'s Turn");
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
			return;
			int response_id = 0; //match_over_dialog.run ();
			if (response_id == Gtk.ResponseType.CANCEL) {
				match_over_dialog.destroy ();
				back_to_main_menu_requested ();
			} else if (response_id == Gtk.ResponseType.ACCEPT) {
				match_over_dialog.destroy ();
				new_game_requested ();
			} else if (response_id == Gtk.ResponseType.CLOSE) {
				match_over_dialog.destroy ();
				quit_game_requested ();
			}
		}

		private void setup_game_screen () {
			set_margin_start(12);
			set_margin_end(12);

			Gtk.Frame board_frame = new Gtk.Frame (null);
			turn_tracker_stack = new TurnTrackerStack ("Player 1" + "'s Turn");

			board_frame.set_child (board_grid);


			Gtk.Box player_info = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			player_info.append (player_one_info_box); //, true, false, 4);

			player_info.append (player_two_info_box); //, true, false, 4);

			append (turn_tracker_stack); //, false, false, 4);

			append (player_info); //, false, false, 0);
			Gtk.Box board_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);
			board_box.append (board_frame); //, true, false, 0);
			Gtk.Button reset_button = new Gtk.Button.with_label ("New Game");
			reset_button.clicked.connect (on_new_match_clicked);
			board_box.append (reset_button); //, false, false, 4);
			append (board_box); //, false, false, 0);

		}

		private void on_new_match_clicked () {
			new_game_requested ();
		}

		private void on_board_cell_selected (int[] position) {
			board_tile_clicked (position);
		}
	}
}
