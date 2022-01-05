namespace Eksanos.Model {
	internal class Game : GLib.Object {
		private Model.Player player_one;
		private Model.Player player_two;
		private Model.Player* current_player;
		private Model.Board board;

		private int turn_counter;
		private string current_state;

		public signal void player_turn_started (string player_name);
		public signal void player_turn_ended (string player_name);
		public signal void board_updated (string[,] board_state);
		public signal void marker_placed (int[] position, string marker);
		public signal void match_completed (string result);
		public signal void new_match_ready (string starting_player);
		public signal void player_won (string player_name);
		public signal void player_lost (string player_name);
		public signal void player_score_updated (string player_name, int score);

		public Game (string player_one_name, string player_two_name) {
			player_one = new Model.Player (player_one_name, "X");
			player_two = new Model.Player (player_two_name, "O");
			current_player = player_one;

			board = new Model.Board ();

			turn_counter = 1;
			current_state = "match_in_progress";
		}

		public bool place_marker (int[] position) {
			if (current_state == "match_finished") {
				return false;
			}

			if (board.is_position_empty (position) == false) {
				return false;
			}

			board.place_marker (position[0], position[1], current_player->get_marker ());
			marker_placed (position, current_player->get_marker ());

			if (check_for_win_condition ()) {
				current_player->change_score_by (1);
				player_score_updated (current_player->get_name (), current_player->get_score ());

				current_state = "match_finished";
				match_completed ("victory");
				player_won (current_player->get_name ());
				player_lost (get_waiting_player().get_name ());

			} else {
				turn_counter += 1;
				if (turn_counter <= 9) {
					player_turn_ended (current_player->get_name ());
					swap_current_player ();
					player_turn_started (current_player->get_name ());
				} else {
					match_completed ("draw");
				}

			}

			return true;
		}

		public void start_new_match() {
			turn_counter = 1;
			current_state = "match_in_progress";
			board.clear_board ();
			player_turn_ended (current_player->get_name ());
			swap_current_player ();
			player_turn_started (current_player->get_name ());
			new_match_ready (current_player->get_name ());
		}

		private void swap_current_player () {
			if (current_player == player_one) {
				current_player = player_two;
			} else {
				current_player = player_one;
			}
		}

		private Model.Player get_waiting_player () {
			if (current_player->get_name () == player_one.get_name ()) {
				return player_two;
			}

			return player_one;
		}

		private bool check_for_win_condition () {
			for (int r = 0; r < 3; ++r){
				if(three_in_a_row_check(board.get_row(r), current_player->get_marker ())){
					return true;
				}
			}
			for (int c = 0; c < 3; ++c){
				if(three_in_a_row_check(board.get_col(c), current_player->get_marker ())){
					return true;
				}
			}
			for (int d = 0; d < 2; ++d){
				if(three_in_a_row_check(board.get_diag(d), current_player->get_marker ())){
					return true;
				}
			}

			return false;
		}

		private bool three_in_a_row_check(string[] marker_array, string match_value) {
			for (int i = 0; i < 3; ++i) {
				if (marker_array[i] != match_value) {
					return false;
				}
			}

			return true;
		}
	}
}
