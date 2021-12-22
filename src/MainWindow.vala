namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 360,
				default_width: 360
			);
		}

		construct {
			var board = new Gtk.Grid ();
			string[,] board_data = new string [3,3];
			init_board_data (board_data, "X");
			init_board (board, board_data);

			add (board);
		}

		private void init_board (Gtk.Grid board, string[,] board_data) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					add_button_to_grid (board, r, c, board_data[c,r]);
				}
			}
		}

		private void init_board_data (string[,] board_data, string empty_tile_char) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					board_data[c,r] = empty_tile_char;
				}
			}
		}

		private void add_button_to_grid (Gtk.Grid *grid, int col, int row, string empty_tile_char ) {
			var button = new Gtk.Button.with_label(empty_tile_char);
			button.expand = true;
			button.margin = 8;

			grid->attach (button, col, row, 1, 1);
		}
	}
}
