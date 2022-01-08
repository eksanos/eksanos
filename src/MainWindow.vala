namespace Eksanos {
	public class MainWindow : Hdy.ApplicationWindow {
		private GameController game_controller;
		private MainMenu main_menu;
		private Hdy.Deck deck;
		private Gtk.Button nav_button;

		public MainWindow (Eksanos.Application eksanos_app) {
			Object (
				application: eksanos_app,
				title: "Eksanos",
				default_height: 480,
				default_width: 640,
				resizable: false
			);
		}

		construct {
			Hdy.init ();
			var global_grid = new Gtk.Grid ();
			global_grid.orientation = Gtk.Orientation.VERTICAL;

			nav_button = new Gtk.Button.with_label ("Main Menu");
			game_controller = new GameController ();
			main_menu = new MainMenu ();

			var header_bar = new Hdy.HeaderBar (){
				hexpand = true,
				has_subtitle = false,
				show_close_button = true,
				title = "Eksanos"
			};

			header_bar.pack_start (nav_button);
			nav_button.set_visible (false);
			nav_button.set_can_focus (false);

			deck = new Hdy.Deck ();
			deck.set_transition_type (Hdy.DeckTransitionType.UNDER);
			deck.add (main_menu.get_menu_screen ());
			deck.add (game_controller.get_game_screen ());
			deck.set_visible_child (main_menu.get_menu_screen ());

			main_menu.start_game_requested.connect ((player_one_name, player_two_name, color_name) => {
				game_controller.generate_new_game (player_one_name, player_two_name, color_name);
				deck.set_visible_child (game_controller.get_game_screen ());
				nav_button.set_visible (true);
			});

			nav_button.clicked.connect (() => {
				deck.set_visible_child (main_menu.get_menu_screen ());
				nav_button.set_visible (false);

			});

			global_grid.add (header_bar);

			global_grid.add (deck);
			add (global_grid);
		}
	}
}
