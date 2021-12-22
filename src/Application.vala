namespace Eksanos{
	public class Application : Gtk.Application {
		public MainWindow app_window;

		public Application () {
			Object (
				application_id: "com.github.keilith-l.eksanos",
				flags: ApplicationFlags.FLAGS_NONE
			);
		}

		protected override void activate () {
			if (get_windows().length() > 0) {
				app_window.present();
				return;
			}

			app_window = new MainWindow (this);

			var board = new Gtk.Grid ();

			init_board (board);

			app_window.add (board);
			app_window.show_all ();
		}

		public static int main (string[] args) {
			return new Application ().run (args);
		}

		private void init_board(Gtk.Grid board) {
			for (int r = 0; r < 3; ++r){
				for (int c = 0; c < 3; ++c){
					add_button_to_grid (board, r, c, 1, 1);
				}
			}
		}

		private void add_button_to_grid (Gtk.Grid *grid, int row, int col, int span_row, int span_col ) {
			grid->attach (new Gtk.Button.with_label ("-"), row, col, span_row, span_col);
		}
	}
}
