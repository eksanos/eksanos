namespace Eksanos {
	public class MainWindow : Gtk.ApplicationWindow {
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
			game_controller = new GameController ();
			add (game_controller.get_game_screen ());
		}
	}
}
