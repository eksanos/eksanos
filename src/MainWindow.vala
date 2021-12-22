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

			init_board (board);

			add (board);
		}

		private void init_board(Gtk.Grid board) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					add_button_to_grid (board, r, c, 1, 1);
				}
			}
		}

		private void add_button_to_grid (Gtk.Grid *grid, int row, int col, int span_row, int span_col ) {
			var button = new Gtk.Button.with_label("-");
			button.expand = true;
			button.margin = 8;

			grid->attach (button, row, col, span_row, span_col);
		}
	}
}
