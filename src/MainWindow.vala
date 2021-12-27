namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		private Board board;
		private int turn_counter;
		private Player player_one;
		private Player player_two;
		private Player* current_player;

		private Gtk.Box game_screen;
		private Gtk.Box player_one_info_box;
		private Gtk.Label player_one_score_label;

		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 360,
				default_width: 640,
				resizable: true
			);
		}

		construct {
			game_screen = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

			player_one = new Player ("Player 1", "X");
			player_two = new Player ("Player 2", "O");
			current_player = player_one;

			board = new Board ();
			board.marker_placed.connect (on_marker_placed);
			board.set_current_marker (current_player->get_marker());

			turn_counter = 0;

			player_one_info_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 8);
			player_one_info_box.pack_start(new Gtk.Label (player_one.get_name()), true, true, 2);
			player_one_score_label = new Gtk.Label ("Score: ");
			player_one_info_box.pack_start(player_one_score_label, true, true, 2);

			game_screen.pack_start(player_one_info_box, true, true, 0);

			Gtk.Box board_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 8);
			board_box.pack_start(board.get_grid(), true, false, 0);
			Gtk.Button reset_button = new Gtk.Button.with_label ("New Game");
			reset_button.clicked.connect (start_new_round);
			board_box.pack_end(reset_button, false, false, 4);
			game_screen.pack_start(board_box, false, false, 0);

			game_screen.pack_start(new Gtk.Label (player_two.get_name() + " info"), true, true, 0);

			add (game_screen);
		}

		private void on_marker_placed () {
			turn_counter = turn_counter + 1;

			if (check_for_win_condition ()) {
				print(current_player->get_name () + " wins!");
				current_player->change_score_by (1);
				player_one_score_label.set_label(current_player->get_score().to_string());
				board.disable();
			} else {
				swap_current_player ();
			}
		}

		private void swap_current_player () {
			if (current_player == player_one) {
				current_player = player_two;
			} else {
				current_player = player_one;
			}
			board.set_current_marker (current_player->get_marker());
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

		private void start_new_round () {
			turn_counter = 0;
			swap_current_player ();
			board.clear_board ();
			board.enable ();
		}
	}
}
