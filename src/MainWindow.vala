namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		private Board board;
		private int turn_counter;
		private Player player_one;
		private Player player_two;
		private Player* current_player;

		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 360,
				default_width: 360,
				resizable: false
			);
		}

		construct {
			player_one = new Player ("Player 1", "X");
			player_two = new Player ("Player 2", "O");
			current_player = player_one;

			board = new Board ();
			board.marker_placed.connect (on_marker_placed);
			board.set_current_marker(current_player->get_marker());

			turn_counter = 0;

			add (board.get_grid());
		}

		private void on_marker_placed () {
			turn_counter = turn_counter + 1;
			if (current_player == player_one) {
				current_player = player_two;
			} else {
				current_player = player_one;
			}
			board.set_current_marker(current_player->get_marker());
		}

	}

	internal class Player : GLib.Object {
		private string player_name;
		private string marker;

		public Player (string player_name, string marker) {
			this.player_name = player_name;
			this.marker = marker;
		}

		public string get_marker () {
			return marker;
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

		construct {
		}

		public Gtk.Button get_button () {
			return button;
		}

		public string get_marker_on_tile () {
			return marker;
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
