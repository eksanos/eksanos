namespace Eksanos {
	public class MainWindow : Hdy.ApplicationWindow {
		private GameController game_controller;
		private MainMenu main_menu;

		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 360,
				default_width: 640,
				resizable: false
			);
		}

		construct {
			Hdy.init ();
			var global_grid = new Gtk.Grid ();
			global_grid.orientation = Gtk.Orientation.VERTICAL;

			var header_bar = new Hdy.HeaderBar (){
				hexpand = true,
				has_subtitle = false,
				show_close_button = true,
				title = "Eksanos"
			};

			game_controller = new GameController ();

			main_menu = new MainMenu ();
			main_menu.start_game_requested.connect ((a,b) => {
				print (a + " " + b);
			});

			global_grid.add (header_bar);

			global_grid.add (main_menu.get_menu_screen ());
			//global_grid.add (game_controller.get_game_screen ());
			add (global_grid);
		}
	}
}
