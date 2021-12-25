namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		private Board board;

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
			board = new Board();

			add (board.get_grid());
		}
	}

	internal class Board : GLib.Object {
		private Gtk.Grid board_grid;
		private Tile[,] board_tiles;

		public Board () {
		}

		construct {
			board_grid = new Gtk.Grid ();
			board_tiles = new Tile [3,3];
			init_board ("X");
		}

		public Gtk.Grid get_grid () {
			return board_grid;
		}

		private void init_board (string empty_tile_marker) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					board_tiles[c,r] = new Tile (empty_tile_marker, ((3*r + c)));
					print(((3*r + c)).to_string());
					board_grid.attach (board_tiles[c,r].get_button(), c, r);

					board_tiles[c,r].tile_selected.connect(on_tile_selected);
				}
			}
		}

		private void on_tile_selected (int id) {
			var index_r = id/3;
			var index_c = id%3;

			board_tiles[index_c,index_r].place_marker("O");
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
		}

		public void on_tile_clicked () {
			tile_selected(tile_id);
		}
	}
}
