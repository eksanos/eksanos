/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Justin Lahman <justinlahmanCS@gmail.com>
 */
namespace Eksanos.Controllers {
	internal class Game : GLib.Object {
		private Widgets.GameScreen game_screen;
		private Model.Game game_model;

		public Game (Gtk.Window window) {
			game_screen = new Widgets.GameScreen (window);

			game_screen.board_tile_clicked.connect (on_board_tile_clicked);
			game_screen.new_game_requested.connect (on_new_game_requested);
		}

		public Widgets.GameScreen get_game_screen () {
			return game_screen;
		}

		public void generate_new_game (string player_one_name, string player_two_name, bool single_player_mode, string color_name) {
			game_model = new Model.Game (player_one_name, player_two_name, single_player_mode);

			game_model.player_score_updated.connect (on_player_score_updated);
			game_model.player_turn_started.connect (on_player_turn_started);
			game_model.player_turn_ended.connect (on_player_turn_ended);
			game_model.player_won.connect (on_player_won);
			game_model.player_lost.connect (on_player_lost);
			game_model.match_completed.connect (on_match_completed);
			game_model.board_updated.connect (on_board_updated);
			game_model.marker_placed.connect (on_marker_placed);
			game_model.new_match_ready.connect (on_new_match_ready);

			game_screen.reset ();
			game_screen.update_player_names (player_one_name, player_two_name);
			game_screen.update_marker_color (color_name);

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

		private void on_match_completed (int result) {
			game_screen.disable_board ();
			game_screen.show_match_over_dialog(result);
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
			game_model.human_place_marker (position);
		}

		private void on_new_game_requested () {
			game_model.start_new_match ();
		}
	}

}
