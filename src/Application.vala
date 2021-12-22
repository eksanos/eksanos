public class HelloPackaging : Gtk.Application {
	public HelloPackaging () {
		Object (
			application_id: "com.github.keilith-l.hello-packaging",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var main_window = new Gtk.ApplicationWindow (this) {
			default_height = 360,
			default_width = 640,
			title = "Hello Flatpak Packaging"
		};
		
		var board = new Gtk.Grid ();

		init_board (board);

	//	board.get_child_at (0,1).label = "0,1";

		main_window.add (board);
		main_window.show_all ();
	}

	public static int main (string[] args) {
		return new HelloPackaging ().run (args);
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
