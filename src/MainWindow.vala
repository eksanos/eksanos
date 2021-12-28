namespace Eksanos {
	public class MainWindow : Hdy.ApplicationWindow {
		private GameController game_controller;

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
			Hdy.init ();
			var global_grid = new Gtk.Grid ();
			global_grid.orientation = Gtk.Orientation.VERTICAL;

			var header_bar = new Hdy.HeaderBar (){
				has_subtitle = false,
				show_close_button = true,
				title = "Eksanos"
			};

			game_controller = new GameController ();

			global_grid.add (header_bar);
			global_grid.add (game_controller.get_game_screen ());
			add (global_grid);
		}
	}
}
