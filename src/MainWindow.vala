namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
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
			var board = new Board();

			add (board.get_grid());
		}
	}

	protected class Board : GLib.Object {
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
					board_tiles[c,r] = new Tile (empty_tile_marker);
					board_grid.attach (board_tiles[c,r].get_button(), c, r);
				}
			}
		}
	}

	protected class Tile : GLib.Object {
		private Gtk.Button button;
		private string marker;

		public Tile (string default_marker) {
			button = new Gtk.Button.with_label(default_marker);
			button.expand = true;
			button.margin = 8;
			marker = default_marker;
		}

		construct {
		}

		public Gtk.Button get_button () {
			return button;
		}

		public string get_marker_on_tile () {
			return marker;
		}

	}
}
