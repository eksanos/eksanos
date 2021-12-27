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

	internal class Player : GLib.Object {
		private string player_name;
		private string marker;
		private int score;

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

		public void change_score_by (int delta) {
			score = score + delta;
		}

		public int get_score () {
			return score;
		}
	}

	internal class Board : GLib.Object {
		private Gtk.Grid board_grid;
		private Tile[,] board_tiles;
		private string current_marker;

		public signal void marker_placed ();

		public Board () {
		}

		construct {
			board_grid = new Gtk.Grid ();
			board_grid.set_size_request(360,360);
			board_tiles = new Tile [3,3];
			current_marker = "M";
			init_board (" ");
		}

		public Gtk.Grid get_grid () {
			return board_grid;
		}

		public void set_current_marker(string marker) {
			this.current_marker = marker;
		}

		public string[] get_row (int r) {
			string[] row = new string[3];
			for (int i = 0; i < 3; ++i) {
				row[i] = board_tiles[i,r].get_marker();
			}
			return row;
		}

		public string[] get_col (int c) {
			string[] col = new string[3];
			for (int i = 0; i < 3; ++i) {
				col[i] = board_tiles[c,i].get_marker();
			}
			return col;
		}

		public string[] get_diag (int d) {
			string[] diag = new string[3];
			if (d == 0) {
				diag[0] = board_tiles[0,0].get_marker();
				diag[1] = board_tiles[1,1].get_marker();
				diag[2] = board_tiles[2,2].get_marker();
			} else {
				diag[0] = board_tiles[0,2].get_marker();
				diag[1] = board_tiles[1,1].get_marker();
				diag[2] = board_tiles[2,0].get_marker();
			}
			return diag;
		}

		public void clear_board () {
			for (int r = 0; r < 3; ++r) {
				for (int c = 0; c < 3; ++c) {
					board_tiles[c,r].clear_tile();
				}
			}
		}

		public void disable () {
			board_grid.set_sensitive (false);
		}

		public void enable () {
			board_grid.set_sensitive (true);
		}

		private void init_board (string empty_tile_marker) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					board_tiles[c,r] = new Tile (empty_tile_marker, ((3*r + c)));
					board_grid.attach (board_tiles[c,r].get_button(), c, r);

					board_tiles[c,r].tile_selected.connect (on_tile_selected);
				}
			}
		}

		private void on_tile_selected (int id) {
			var index_r = id/3;
			var index_c = id%3;

			board_tiles[index_c,index_r].place_marker(current_marker);
			marker_placed ();
		}
	}

	internal class Tile : GLib.Object {
		private Gtk.Button button;
		private string marker;
		private int tile_id;

		public signal void tile_selected(int id);

		public Tile (string default_marker, int id) {
			button = new Gtk.Button.with_label(default_marker);
			button.expand = true;
			button.margin = 8;
			button.clicked.connect(on_tile_clicked);
			marker = default_marker;
			tile_id = id;
		}

		public Gtk.Button get_button () {
			return button;
		}

		public string get_marker () {
			return marker;
		}

		public void clear_tile () {
			marker = " ";
			button.label = marker;
			button.set_sensitive(true);
		}

		public void place_marker (string marker_id) {
			marker = marker_id;
			button.label = marker;
			button.set_sensitive(false);
		}

		public void on_tile_clicked () {
			tile_selected(tile_id);
		}
	}
}
