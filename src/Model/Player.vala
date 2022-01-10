namespace Eksanos.Model {
	internal class Player : GLib.Object {
		protected string player_name;
		protected string marker;
		protected int score;

		public Player (string player_name, string marker) {
			this.player_name = player_name;
			this.marker = marker;
			score = 0;
		}

		public string get_name () {
			return player_name;
		}

		public string get_marker () {
			return marker;
		}

		public int get_score () {
			return score;
		}

		public void change_score_by (int delta) {
			score = score + delta;
		}
	}

	internal class ComPlayer : Model.Player {
		private string[,] board_state;
		private uint think_seconds;

		public signal void move_decided (int[] position);

		public ComPlayer (string com_player_name, string marker) {
			base(com_player_name, marker);
			board_state = new string[3,3];
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					board_state[c,r] = " ";
				}
			}

			think_seconds = 1;
		}

		public void react_to_board_update (string[,] board_state) {
			print ("reacting to board update\n");
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					print (board_state[c,r]);
				}
			}
			this.board_state = board_state;
		}

		public void react_to_turn_start (string player_name) {
			if (player_name == this.player_name) {
				print ("com turn start\n");
				GLib.Timeout.add_seconds_full (GLib.Priority.DEFAULT, think_seconds, decide_move);
				//decide_move ();
			}
		}

		private bool decide_move () {
			int[,] free_spaces = get_free_spaces ();

			int index = GLib.Random.int_range (0, free_spaces.length[0]);

			int[] position = new int[2];
			position[0] = free_spaces[index,0];
			position[1] = free_spaces[index,1];
			move_decided (position);
			return false;
		}

		private int[,] get_free_spaces () {
			int length = count_number_free_spaces ();
			int[,] free_spaces = new int[length, 2];
			int index = 0;

			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					if (board_state[c,r] == " ") {
						free_spaces[index,0] = c;
						free_spaces[index,1] = r;
						index = index + 1;
					}
				}
			}

			return free_spaces;
		}

		private int count_number_free_spaces () {
			int count = 0;
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					if (board_state[c,r] == " ") {
						count += 1;
					}
				}
			}
			return count;
		}

	}
}
